using Brp.AutorisatieEnProtocollering.Proxy.Data;
using Brp.Shared.Infrastructure.Autorisatie;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;

namespace Brp.AutorisatieEnProtocollering.Proxy.Autorisatie;

public class AuthorisationService : IAuthorisation
{
    private readonly IServiceProvider _serviceProvider;

    public AuthorisationService(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public bool Protocolleer(int afnemerCode, string geleverdePersoonslijstIds, string requestBody)
    {
        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        var input = JObject.Parse(requestBody);

        var zoekElementNrs = BepaalElementNrVanZoekParameters(input);
        var fieldElementNrs = BepaalElementNrVanFieldsVoorProtocollering(input);

        var zoekRubrieken = new List<string>();
        foreach (var (Name, Value) in zoekElementNrs)
        {
            zoekRubrieken.AddRange(Value);
        }
        var requestZoekRubrieken = string.Join(", ", zoekRubrieken.Distinct().OrderBy(x => x));

        var gevraagdeRubrieken = new List<string>();
        foreach(var (Name, Value) in fieldElementNrs)
        {
            gevraagdeRubrieken.AddRange(Value);
        }
        var requestGevraagdeRubrieken = string.Join(", ", gevraagdeRubrieken.Distinct().OrderBy(x => x));

        foreach (var plId in geleverdePersoonslijstIds.Split(','))
        {
            Protocollering protocollering = new()
            {
                RequestId = Guid.NewGuid().ToString(),
                AfnemerCode = afnemerCode,
                PersoonslijstId = long.Parse(plId),
                RequestZoekRubrieken = requestZoekRubrieken,
                RequestGevraagdeRubrieken = requestGevraagdeRubrieken
            };

            appDbContext.Add(protocollering);
        }
        appDbContext.SaveChanges();

        return true;
    }

    public AuthorisationResult Authorize(int afnemerCode, int? gemeenteCode, string requestBody)
    {
        using var scope = _serviceProvider.CreateScope();

        var appDbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        var autorisatie = appDbContext.GetActueleAutorisatieFor(afnemerCode);
        if (GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(autorisatie))
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor het gebruik van deze API.",
                                 detail: "Niet geautoriseerd voor ad hoc bevragingen.",
                                 code: "unauthorized",
                                 reason: autorisatie != null
                                    ? $"Vereiste ad_hoc_medium: A of N. Werkelijk: {autorisatie.AdHocMedium}. Afnemer code: {autorisatie.AfnemerCode}"
                                    : $"Geen\\Verlopen autorisatie gevonden voor Afnemer code {afnemerCode}");
        }

        var input = JObject.Parse(requestBody);

        if (gemeenteCode.HasValue)
        {
            return Authorized();
        }

        var zoekElementNrs = BepaalElementNrVanZoekParameters(input);

        var geautoriseerdeElementNrs = autorisatie!.RubrieknummerAdHoc!.Split(' ');

        var nietGeautoriseerdQueryElementNrs = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, zoekElementNrs);
        if (nietGeautoriseerdQueryElementNrs.Any())
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor de gebruikte parameter(s).",
                                 detail: $"U bent niet geautoriseerd voor het gebruik van parameter(s): {string.Join(", ", nietGeautoriseerdQueryElementNrs.OrderBy(x => x))}.",
                                 code: "unauthorizedParameter");
        }

        var fieldElementNrs = BepaalElementNrVanFields(input);

        var nietGeautoriseerdFieldNames = BepaalNietGeautoriseerdeElementNamen(geautoriseerdeElementNrs, fieldElementNrs);
        if (nietGeautoriseerdFieldNames.Any())
        {
            return NotAuthorized(title: "U bent niet geautoriseerd voor één of meerdere opgegeven field waarden.",
                                 code: "unauthorizedField",
                                 reason: $"afnemer '{afnemerCode}' is niet geautoriseerd voor fields {string.Join(", ", nietGeautoriseerdFieldNames.OrderBy(x => x))}");
        }

        return Authorized();
    }

    private static AuthorisationResult NotAuthorized(string? title = null, string? detail = null, string? code = null, string? reason = null)
    {
        return new AuthorisationResult
        {
            IsValid = false,
            Errors = new List<AuthorisationFailure>
            {
                new()
                {
                    Title = title,
                    Detail = detail,
                    Code = code,
                    Reason = reason
                }
            }
        };
    }

    private static AuthorisationResult Authorized()
    {
        return new AuthorisationResult
        {
            IsValid = true,
            Errors = new List<AuthorisationFailure>()
        };
    }

    private static bool GeenAutorisatieOfNietGeautoriseerdVoorAdHocGegevensverstrekking(Data.Autorisatie? autorisatie)
    {
        return autorisatie == null || !new[] { 'A', 'N' }.Contains(autorisatie.AdHocMedium);
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanZoekParameters(JObject input)
    {
        return from property in input.Properties()
               where !new[] { "type", "fields", "inclusiefOverledenPersonen" }.Contains(property.Name)
               select (property.Name, Value: FieldElementNrDictionary[property.Name].Split(' '));
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFields(JObject input)
    {
        var retval = new List<(string Name, string[] Value)>();

        var zoekType = input.Value<string>("type");
        var gevraagdeFields = from field in input.Value<JArray>("fields")!
                              let v = field.Value<string>()
                              where v != null
                              select v;

        foreach (var gevraagdField in gevraagdeFields)
        {
            var key = zoekType != "RaadpleegMetBurgerservicenummer"
                ? $"{gevraagdField}-beperkt"
                : gevraagdField;

            var fieldElementNrs = FieldElementNrDictionary.ContainsKey(key)
                ? FieldElementNrDictionary[key]
                : FieldElementNrDictionary[gevraagdField];

            retval.Add(new(gevraagdField, fieldElementNrs.Split(' ')));
        }
        return retval;
    }

    private static IEnumerable<(string Name, string[] Value)> BepaalElementNrVanFieldsVoorProtocollering(JObject input)
    {
        var retval = new List<(string Name, string[] Value)>();

        var zoekType = input.Value<string>("type");
        var gevraagdeFields = from field in input.Value<JArray>("fields")!
                              let v = field.Value<string>()
                              where v != null
                              select v;

        foreach (var gevraagdField in gevraagdeFields)
        {
            var key = zoekType != "RaadpleegMetBurgerservicenummer"
                ? $"{gevraagdField}-beperkt"
                : $"{gevraagdField}-protocollering";

            var fieldElementNrs = FieldElementNrDictionary.ContainsKey(key)
                ? FieldElementNrDictionary[key]
                : FieldElementNrDictionary[gevraagdField];

            retval.Add(new(gevraagdField, !string.IsNullOrWhiteSpace(fieldElementNrs) ? fieldElementNrs.Split(' ') : Array.Empty<string>()));
        }
        return retval;
    }

    private static IEnumerable<string> BepaalNietGeautoriseerdeElementNamen(IEnumerable<string> geautoriseerdeElementen,
                                                                            IEnumerable<(string Name, string[] Value)> gevraagdeElementen)
    {
        var retval = new List<string>();

        foreach (var (Name, Value) in gevraagdeElementen)
        {
            foreach (var gevraagdElementNr in Value)
            {
                if (gevraagdElementNr == string.Empty && Name == "ouders.ouderAanduiding")
                {
                    if (!IsGeautoriseerdVoorOuderAanduidingVraag(geautoriseerdeElementen))
                    {
                        retval.Add(Name);
                    }
                }
                else if (!geautoriseerdeElementen.Any(x => gevraagdElementNr == x.PrefixWithZero()))
                {
                    retval.Add(Name);
                }
            }
        }

        return retval;
    }

    private static bool IsGeautoriseerdVoorOuderAanduidingVraag(IEnumerable<string> geautoriseerdeElementen)
    {
        var ouder1Regex = new Regex(@"^(02(01|02|03|04|62)\d{2}|PAOU01)$");
        var ouder2Regex = new Regex(@"^(03(01|02|03|04|62)\d{2}|PAOU01)$");

        var isGeautoriseerdVoorOuder1 = false;
        var isGeautoriseerdVoorOuder2 = false;

        foreach (var elementNr in geautoriseerdeElementen)
        {
            var prefixedElementNr = elementNr.PrefixWithZero();
            if (ouder1Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder1 = true;
            }
            if (ouder2Regex.IsMatch(prefixedElementNr))
            {
                isGeautoriseerdVoorOuder2 = true;
            }
        }

        return isGeautoriseerdVoorOuder1 && isGeautoriseerdVoorOuder2;
    }

    private static readonly Dictionary<string, string> FieldElementNrDictionary = new()
    {
        { "adressering", "081310 081350 PANM03 PANM04 PANM05 PANM06 PAVP03 PAVP04" },
        { "adressering-beperkt", "081310 081350 PAVP03 PAVP04" },
        { "adressering.aanhef", "PANM03" },
        { "adressering.aanschrijfwijze", "PANM04 PANM05" },
        { "adressering.aanschrijfwijze.aanspreekvorm", "PANM04" },
        { "adressering.aanschrijfwijze.naam", "PANM05" },
        { "adressering.gebruikInLopendeTekst", "PANM06" },
        { "adressering.adresregel1", "PAVP03" },
        { "adressering.adresregel2", "PAVP04" },
        { "adressering.adresregel3", "081350" },
        { "adressering.land", "081310" },
        { "adressering.land.code", "081310" },
        { "adressering.land.omschrijving", "081310" },

        { "adresseringBinnenland", "PANM03 PANM04 PANM05 PANM06 PAVP03 PAVP04" },
        { "adresseringBinnenland-beperkt", "PAVP03 PAVP04" },
        { "adresseringBinnenland.aanhef", "PANM03" },
        { "adresseringBinnenland.aanschrijfwijze", "PANM04 PANM05" },
        { "adresseringBinnenland.aanschrijfwijze.aanspreekvorm", "PANM04" },
        { "adresseringBinnenland.aanschrijfwijze.naam", "PANM05" },
        { "adresseringBinnenland.gebruikInLopendeTekst", "PANM06" },
        { "adresseringBinnenland.adresregel1", "PAVP03" },
        { "adresseringBinnenland.adresregel2", "PAVP04" },

        { "aNummer", "010110" },
        { "burgerservicenummer", "010120" },
        { "datumEersteInschrijvingGBA", "076810" },
        { "datumEersteInschrijvingGBA.langFormaat", "076810" },
        { "datumEersteInschrijvingGBA.type", "076810" },
        { "datumEersteInschrijvingGBA.datum", "076810" },
        { "datumEersteInschrijvingGBA.onbekend", "076810" },
        { "datumEersteInschrijvingGBA.jaar", "076810" },
        { "datumEersteInschrijvingGBA.maand", "076810" },
        { "geboortedatum", "010310" },

        { "geslacht", "010410" },
        { "geslacht.code", "010410" },
        { "geslacht.omschrijving", "010410" },

        { "geslachtsnaam", "010240" },
        { "voornamen", "010210" },
        { "voorvoegsel", "010230" },

        { "nummeraanduidingIdentificatie", "081190" },

        { "europeesKiesrecht", "133110 133130" },
        { "europeesKiesrecht.aanduiding", "133110" },
        { "europeesKiesrecht.aanduiding.code", "133110" },
        { "europeesKiesrecht.aanduiding.omschrijving", "133110" },
        { "europeesKiesrecht.einddatumUitsluiting", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.langFormaat", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.type", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.datum", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.onbekend", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.jaar", "133130" },
        { "europeesKiesrecht.einddatumUitsluiting.maand", "133130" },

        { "geboorte", "010310 010320 010330" },
        { "geboorte-beperkt", "010310" },
        { "geboorte.datum", "010310" },
        { "geboorte.datum.langFormaat", "010310" },
        { "geboorte.datum.type", "010310" },
        { "geboorte.datum.datum", "010310" },
        { "geboorte.datum.onbekend", "010310" },
        { "geboorte.datum.jaar", "010310" },
        { "geboorte.datum.maand", "010310" },
        { "geboorte.plaats", "010320" },
        { "geboorte.plaats.code", "010320" },
        { "geboorte.plaats.omschrijving", "010320" },
        { "geboorte.land", "010330" },
        { "geboorte.land.code", "010330" },
        { "geboorte.land.omschrijving", "010330" },

        { "gemeenteVanInschrijving", "080910" },
        { "gemeenteVanInschrijving.code", "080910" },
        { "gemeenteVanInschrijving.omschrijving", "080910" },
        { "datumInschrijvingInGemeente", "080920" },
        { "datumInschrijvingInGemeente.langFormaat", "080920" },
        { "datumInschrijvingInGemeente.type", "080920" },
        { "datumInschrijvingInGemeente.datum", "080920" },
        { "datumInschrijvingInGemeente.onbekend", "080920" },
        { "datumInschrijvingInGemeente.jaar", "080920" },
        { "datumInschrijvingInGemeente.maand", "080920" },

        { "gezag", "PAGZ01" },
        { "gezag.type", "PAGZ01" },
        { "gezag.minderjarige", "PAGZ01" },
        { "gezag.ouders", "PAGZ01" },
        { "gezag.ouder", "PAGZ01" },
        { "gezag.derde", "PAGZ01" },
        { "gezag.derden", "PAGZ01" },
        { "gezag.minderjarige.burgerservicenummer", "PAGZ01" },
        { "gezag.ouders.burgerservicenummer", "PAGZ01" },
        { "gezag.ouder.burgerservicenummer", "PAGZ01" },
        { "gezag.derde.burgerservicenummer", "PAGZ01" },
        { "gezag.derden.burgerservicenummer", "PAGZ01" },

        { "indicatieGezagMinderjarige", "113210" },
        { "indicatieGezagMinderjarige.code", "113210" },
        { "indicatieGezagMinderjarige.omschrijving", "113210" },
        { "indicatieCurateleRegister", "113310" },

        { "immigratie", "081410 081420 PAVP05 PAVP06" },
        { "immigratie.datumVestigingInNederland", "081420" },
        { "immigratie.datumVestigingInNederland.langFormaat", "081420" },
        { "immigratie.datumVestigingInNederland.type", "081420" },
        { "immigratie.datumVestigingInNederland.datum", "081420" },
        { "immigratie.datumVestigingInNederland.onbekend", "081420" },
        { "immigratie.datumVestigingInNederland.jaar", "081420" },
        { "immigratie.datumVestigingInNederland.maand", "081420" },
        { "immigratie.indicatieVestigingVanuitBuitenland", "PAVP05" },
        { "immigratie.landVanwaarIngeschreven", "081410" },
        { "immigratie.landVanwaarIngeschreven.code", "081410" },
        { "immigratie.landVanwaarIngeschreven.omschrijving", "081410" },
        { "immigratie.vanuitVerblijfplaatsOnbekend", "PAVP06" },

        { "kinderen", "090120 090210 090220 090230 090240 090310 090320 090330 PAKD01" },
        { "kinderen.burgerservicenummer", "090120" },
        { "kinderen.geboorte", "090310 090320 090330" },
        { "kinderen.geboorte.datum", "090310" },
        { "kinderen.geboorte.datum.langFormaat", "090310" },
        { "kinderen.geboorte.datum.type", "090310" },
        { "kinderen.geboorte.datum.datum", "090310" },
        { "kinderen.geboorte.datum.onbekend", "090310" },
        { "kinderen.geboorte.datum.jaar", "090310" },
        { "kinderen.geboorte.datum.maand", "090310" },
        { "kinderen.geboorte.land", "090330" },
        { "kinderen.geboorte.land.code", "090330" },
        { "kinderen.geboorte.land.omschrijving", "090330" },
        { "kinderen.geboorte.plaats", "090320" },
        { "kinderen.geboorte.plaats.code", "090320" },
        { "kinderen.geboorte.plaats.omschrijving", "090320" },
        { "kinderen.naam", "090210 090220 090230 090240 PAKD01" },
        { "kinderen.naam.adellijkeTitelPredicaat", "090220" },
        { "kinderen.naam.adellijkeTitelPredicaat.code", "090220" },
        { "kinderen.naam.adellijkeTitelPredicaat.omschrijving", "090220" },
        { "kinderen.naam.adellijkeTitelPredicaat.soort", "090220" },
        { "kinderen.naam.geslachtsnaam", "090240" },
        { "kinderen.naam.voorletters", "PAKD01" },
        { "kinderen.naam.voornamen", "090210" },
        { "kinderen.naam.voorvoegsel", "090230" },

        { "leeftijd", "PAGL01" },

        { "naam", "010210 010220 010230 010240 016110 PANM01 PANM02" },
        { "naam-beperkt", "010210 010220 010230 010240 PANM01 PANM02" },
        { "naam.voornamen", "010210" },
        { "naam.adellijkeTitelPredicaat", "010220" },
        { "naam.adellijkeTitelPredicaat.code", "010220" },
        { "naam.adellijkeTitelPredicaat.omschrijving", "010220" },
        { "naam.adellijkeTitelPredicaat.soort", "010220" },
        { "naam.voorvoegsel", "010230" },
        { "naam.geslachtsnaam", "010240" },
        { "naam.aanduidingNaamgebruik", "016110" },
        { "naam.aanduidingNaamgebruik.code", "016110" },
        { "naam.aanduidingNaamgebruik.omschrijving", "016110" },
        { "naam.voorletters", "PANM01" },
        { "naam.volledigeNaam", "PANM02" },

        { "nationaliteiten", "040510 046310 048510" },
        { "nationaliteiten-protocollering", "040510 046310 048510 PANT01" },
        { "nationaliteiten.type", "040510" },
        { "nationaliteiten.type-protocollering", "PANT01" },
        { "nationaliteiten.nationaliteit", "040510" },
        { "nationaliteiten.nationaliteit.code", "040510" },
        { "nationaliteiten.nationaliteit.omschrijving", "040510" },
        { "nationaliteiten.redenOpname", "046310" },
        { "nationaliteiten.redenOpname.code", "046310" },
        { "nationaliteiten.redenOpname.omschrijving", "046310" },
        { "nationaliteiten.datumIngangGeldigheid", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.langFormaat", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.type", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.datum", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.onbekend", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.jaar", "048510" },
        { "nationaliteiten.datumIngangGeldigheid.maand", "048510" },

        { "ouders", "020120 020210 020220 020230 020240 020310 020320 020330 020410 026210 " +
                    "030120 030210 030220 030230 030240 030310 030320 030330 030410 036210 PAOU01" },
        { "ouders.ouderAanduiding", "" },
        { "ouders.burgerservicenummer", "020120 030120" },
        { "ouders.naam", "020210 020220 020230 020240 " +
                         "030210 030220 030230 030240 PAOU01" },
        { "ouders.naam.voornamen", "020210 030210" },
        { "ouders.naam.adellijkeTitelPredicaat", "020220 030220" },
        { "ouders.naam.adellijkeTitelPredicaat.code", "020220 030220" },
        { "ouders.naam.adellijkeTitelPredicaat.omschrijving", "020220 030220" },
        { "ouders.naam.adellijkeTitelPredicaat.soort", "020220 030220" },
        { "ouders.naam.voorvoegsel", "020230 030230" },
        { "ouders.naam.geslachtsnaam", "020240 030240" },
        { "ouders.naam.voorletters", "PAOU01" },
        { "ouders.geboorte", "020310 020320 020330 " +
                             "030310 030320 030330" },
        { "ouders.geboorte.datum", "020310 030310" },
        { "ouders.geboorte.datum.type", "020310 030310" },
        { "ouders.geboorte.datum.datum", "020310 030310" },
        { "ouders.geboorte.datum.langFormaat", "020310 030310" },
        { "ouders.geboorte.datum.jaar", "020310 030310" },
        { "ouders.geboorte.datum.maand", "020310 030310" },
        { "ouders.geboorte.datum.onbekend", "020310 030310" },
        { "ouders.geboorte.plaats", "020320 030320" },
        { "ouders.geboorte.plaats.code", "020320 030320" },
        { "ouders.geboorte.plaats.omschrijving", "020320 030320" },
        { "ouders.geboorte.land", "020330 030330" },
        { "ouders.geboorte.land.code", "020330 030330" },
        { "ouders.geboorte.land.omschrijving", "020330 030330" },
        { "ouders.geslacht", "020410 030410" },
        { "ouders.geslacht.code", "020410 030410" },
        { "ouders.geslacht.omschrijving", "020410 030410" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.type", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.datum", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.langFormaat", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.jaar", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.maand", "026210 036210" },
        { "ouders.datumIngangFamilierechtelijkeBetrekking.onbekend", "026210 036210" },

        { "overlijden", "060810 060820 060830" },
        { "overlijden.datum", "060810" },
        { "overlijden.datum.langFormaat", "060810" },
        { "overlijden.datum.type", "060810" },
        { "overlijden.datum.datum", "060810" },
        { "overlijden.datum.onbekend", "060810" },
        { "overlijden.datum.jaar", "060810" },
        { "overlijden.datum.maand", "060810" },
        { "overlijden.land", "060830" },
        { "overlijden.land.code", "060830" },
        { "overlijden.land.omschrijving", "060830" },
        { "overlijden.plaats", "060820" },
        { "overlijden.plaats.code", "060820" },
        { "overlijden.plaats.omschrijving", "060820" },

        { "partners", "050120 050210 050220 050230 050240 PAHP01 050310 050320 050330 050410 050610 050620 050630 050710 051510" },
        { "partners.burgerservicenummer", "050120" },
        { "partners.naam", "050210 050220 050230 050240 PAHP01" },
        { "partners.naam.voornamen", "050210" },
        { "partners.naam.adellijkeTitelPredicaat", "050220" },
        { "partners.naam.adellijkeTitelPredicaat.code", "050220" },
        { "partners.naam.adellijkeTitelPredicaat.omschrijving", "050220" },
        { "partners.naam.adellijkeTitelPredicaat.soort", "050220" },
        { "partners.naam.voorvoegsel", "050230" },
        { "partners.naam.geslachtsnaam", "050240" },
        { "partners.naam.voorletters", "PAHP01" },
        { "partners.geboorte", "050310 050320 050330" },
        { "partners.geboorte.datum", "050310" },
        { "partners.geboorte.datum.type", "050310" },
        { "partners.geboorte.datum.datum", "050310" },
        { "partners.geboorte.datum.langFormaat", "050310" },
        { "partners.geboorte.datum.jaar", "050310" },
        { "partners.geboorte.datum.maand", "050310" },
        { "partners.geboorte.datum.onbekend", "050310" },
        { "partners.geboorte.plaats", "050320" },
        { "partners.geboorte.plaats.code", "050320" },
        { "partners.geboorte.plaats.omschrijving", "050320" },
        { "partners.geboorte.land", "050330" },
        { "partners.geboorte.land.code", "050330" },
        { "partners.geboorte.land.omschrijving", "050330" },
        { "partners.geslacht", "050410" },
        { "partners.geslacht.code", "050410" },
        { "partners.geslacht.omschrijving", "050410" },
        { "partners.aangaanHuwelijkPartnerschap", "050610 050620 050630" },
        { "partners.aangaanHuwelijkPartnerschap.datum", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.type", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.datum", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.langFormaat", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.jaar", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.maand", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.datum.onbekend", "050610" },
        { "partners.aangaanHuwelijkPartnerschap.plaats", "050620" },
        { "partners.aangaanHuwelijkPartnerschap.plaats.code", "050620" },
        { "partners.aangaanHuwelijkPartnerschap.plaats.omschrijving", "050620" },
        { "partners.aangaanHuwelijkPartnerschap.land", "050630" },
        { "partners.aangaanHuwelijkPartnerschap.land.code", "050630" },
        { "partners.aangaanHuwelijkPartnerschap.land.omschrijving", "050630" },
        { "partners.ontbindingHuwelijkPartnerschap", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.type", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.datum", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.langFormaat", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.jaar", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.maand", "050710" },
        { "partners.ontbindingHuwelijkPartnerschap.datum.onbekend", "050710" },
        { "partners.soortVerbintenis", "051510" },
        { "partners.soortVerbintenis.code", "051510" },
        { "partners.soortVerbintenis.omschrijving", "051510" },

        { "postcode", "081160" },
        { "straat", "081110" },
        { "huisnummer", "081120" },
        { "huisletter", "081130" },
        { "huisnummertoevoeging", "081140" },

        { "uitsluitingKiesrecht", "133810 133820" },
        { "uitsluitingKiesrecht.uitgeslotenVanKiesrecht", "133810" },
        { "uitsluitingKiesrecht.einddatum", "133820" },
        { "uitsluitingKiesrecht.einddatum.langFormaat", "133820" },
        { "uitsluitingKiesrecht.einddatum.type", "133820" },
        { "uitsluitingKiesrecht.einddatum.datum", "133820" },
        { "uitsluitingKiesrecht.einddatum.onbekend", "133820" },
        { "uitsluitingKiesrecht.einddatum.jaar", "133820" },
        { "uitsluitingKiesrecht.einddatum.maand", "133820" },

        { "verblijfplaats.type", "081110 081210 081310" },
        { "verblijfplaats.type-protocollering", "PAVP02" },
        { "verblijfplaats.functieAdres", "081010" },
        { "verblijfplaats.functieAdres.code", "081010" },
        { "verblijfplaats.functieAdres.omschrijving", "081010" },
        { "verblijfplaats.datumVan", "PAVP01" },
        { "verblijfplaats.datumVan.type", "PAVP01" },
        { "verblijfplaats.datumVan.datum", "PAVP01" },
        { "verblijfplaats.datumVan.langFormaat", "PAVP01" },
        { "verblijfplaats.datumVan.jaar", "PAVP01" },
        { "verblijfplaats.datumVan.maand", "PAVP01" },
        { "verblijfplaats.datumVan.onbekend", "PAVP01" },
        { "verblijfplaats.verblijfadres.korteStraatnaam", "081110" },
        { "verblijfplaats.verblijfadres.officieleStraatnaam", "081115" },
        { "verblijfplaats.verblijfadres.huisnummer", "081120" },
        { "verblijfplaats.verblijfadres.huisletter", "081130" },
        { "verblijfplaats.verblijfadres.huisnummertoevoeging", "081140" },
        { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer", "081150" },
        { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer.code", "081150" },
        { "verblijfplaats.verblijfadres.aanduidingBijHuisnummer.omschrijving", "081150" },
        { "verblijfplaats.verblijfadres.postcode", "081160" },
        { "verblijfplaats.verblijfadres.woonplaats", "081170" },
        { "verblijfplaats.verblijfadres.locatiebeschrijving", "081210" },
        { "verblijfplaats.verblijfadres.land", "081310" },
        { "verblijfplaats.verblijfadres.land.code", "081310" },
        { "verblijfplaats.verblijfadres.land.omschrijving", "081310" },
        { "verblijfplaats.verblijfadres.regel1", "081330" },
        { "verblijfplaats.verblijfadres.regel2", "081340" },
        { "verblijfplaats.verblijfadres.regel3", "081350" },
        { "verblijfplaats.adresseerbaarObjectIdentificatie", "081180" },
        { "verblijfplaats.nummeraanduidingIdentificatie", "081190" },
        { "verblijfplaats.datumIngangGeldigheid", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.type", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.datum", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.langFormaat", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.jaar", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.maand", "088510" },
        { "verblijfplaats.datumIngangGeldigheid.onbekend", "088510" },
        { "verblijfplaats.verblijfadres", "081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350" },
        { "verblijfplaats", "081010 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081330 081340 081350 088510 PAVP01" },
        { "verblijfplaats-protocollering", "081010 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081330 081340 081350 088510 PAVP01 PAVP02" },

        { "verblijfplaatsBinnenland.type", "081110 081210" },
        { "verblijfplaatsBinnenland.type-protocollering", "PAVP02" },
        { "verblijfplaatsBinnenland.functieAdres", "081010" },
        { "verblijfplaatsBinnenland.datumVan", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.type", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.datum", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.langFormaat", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.jaar", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.maand", "PAVP01" },
        { "verblijfplaatsBinnenland.datumVan.onbekend", "PAVP01" },
        { "verblijfplaatsBinnenland.verblijfadres.korteStraatnaam", "081110" },
        { "verblijfplaatsBinnenland.verblijfadres.officieleStraatnaam", "081115" },
        { "verblijfplaatsBinnenland.verblijfadres.huisnummer", "081120" },
        { "verblijfplaatsBinnenland.verblijfadres.huisletter", "081130" },
        { "verblijfplaatsBinnenland.verblijfadres.huisnummertoevoeging", "081140" },
        { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer", "081150" },
        { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.code", "081150" },
        { "verblijfplaatsBinnenland.verblijfadres.aanduidingBijHuisnummer.omschrijving", "081150" },
        { "verblijfplaatsBinnenland.verblijfadres.postcode", "081160" },
        { "verblijfplaatsBinnenland.verblijfadres.woonplaats", "081170" },
        { "verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving", "081210" },
        { "verblijfplaatsBinnenland.adresseerbaarObjectIdentificatie", "081180" },
        { "verblijfplaatsBinnenland.nummeraanduidingIdentificatie", "081190" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.type", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.datum", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.langFormaat", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.jaar", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.maand", "088510" },
        { "verblijfplaatsBinnenland.datumIngangGeldigheid.onbekend", "088510" },
        { "verblijfplaatsBinnenland.verblijfadres", "081110 081115 081120 081130 081140 081150 081160 081170 081210" },
        { "verblijfplaatsBinnenland", "081010 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510 PAVP01" },
        { "verblijfplaatsBinnenland-protocollering", "081010 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510 PAVP01 PAVP02" },

        { "verblijfstitel", "103910 103920 103930" },
        { "verblijfstitel.aanduiding", "103910" },
        { "verblijfstitel.aanduiding.code", "103910" },
        { "verblijfstitel.aanduiding.omschrijving", "103910" },
        { "verblijfstitel.datumEinde", "103920" },
        { "verblijfstitel.datumEinde.langFormaat", "103920" },
        { "verblijfstitel.datumEinde.type", "103920" },
        { "verblijfstitel.datumEinde.datum", "103920" },
        { "verblijfstitel.datumEinde.onbekend", "103920" },
        { "verblijfstitel.datumEinde.jaar", "103920" },
        { "verblijfstitel.datumEinde.maand", "103920" },
        { "verblijfstitel.datumIngang", "103930" },
        { "verblijfstitel.datumIngang.langFormaat", "103930" },
        { "verblijfstitel.datumIngang.type", "103930" },
        { "verblijfstitel.datumIngang.datum", "103930" },
        { "verblijfstitel.datumIngang.onbekend", "103930" },
        { "verblijfstitel.datumIngang.jaar", "103930" },
        { "verblijfstitel.datumIngang.maand", "103930" },

    };
}

internal static class AppDbContextExtensions
{
    internal static Data.Autorisatie? GetActueleAutorisatieFor(this AppDbContext appDbContext, int afnemerCode)
    {
        return appDbContext.Autorisaties
                           .FirstOrDefault(a => a.AfnemerCode == afnemerCode &&
                                                a.TabelRegelStartDatum <= Vandaag() &&
                                                (a.TabelRegelEindDatum == null || a.TabelRegelEindDatum > Vandaag()));
    }

    private static long Vandaag()
    {
        return int.Parse(DateTime.Today.ToString("yyyyMMdd"));
    }
}

internal static class AutorisationServiceHelpers
{
    public static string PrefixWithZero(this string str)
    {
        return str.Length == 6
            ? str
            : $"0{str}";
    }
}
