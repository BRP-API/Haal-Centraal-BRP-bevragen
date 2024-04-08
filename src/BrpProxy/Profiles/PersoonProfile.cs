using AutoMapper;
using BrpProxy.Mappers;
using HaalCentraal.BrpProxy.Generated;
using HaalCentraal.BrpProxy.Generated.Gba;

namespace BrpProxy.Profiles;

public class PersoonProfile : Profile
{
    public PersoonProfile()
    {
        CreateMap<GbaGezagPersoonBeperkt, GezagPersoonBeperkt>()
            .ForMember(dest => dest.Leeftijd, opt =>
            {
                opt.PreCondition(src => src.OpschortingBijhouding == null ||
                                        src.OpschortingBijhouding.Reden?.Code != "O");
                opt.MapFrom(src => src.Geboorte.Datum.Map().Leeftijd());
            })
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek()))
            .BeforeMap((src, dest) =>
            {
                if (src.Naam != null || src.PersoonInOnderzoek != null)
                {
                    src.Naam ??= new GbaNaamBasis();
                    if (src.Geslacht != null)
                    {
                        src.Naam.Geslacht = src.Geslacht;
                    }
                    src.Naam.InOnderzoek = src.PersoonInOnderzoek;
                }
                if (src.Geboorte != null || src.PersoonInOnderzoek != null)
                {
                    src.Geboorte ??= new GbaGeboorteBeperkt();
                    src.Geboorte.InOnderzoek = src.PersoonInOnderzoek;
                }
            })
            .AfterMap((src, dest) =>
            {
                if (src.Verblijfplaats != null)
                {
                    dest.Adressering = new AdresseringBeperkt
                    {
                        Adresregel1 = src.Verblijfplaats.Adresregel1(),
                        Adresregel2 = src.Verblijfplaats.Adresregel2(src.GemeenteVanInschrijving),
                        Adresregel3 = src.Verblijfplaats.Adresregel3(),
                        Land = src.Verblijfplaats.Land(),
                        InOnderzoek = src.AdresseringInOnderzoek(),
                        IndicatieVastgesteldVerblijftNietOpAdres = src.Verblijfplaats?.InOnderzoek?.AanduidingGegevensInOnderzoek == "089999"
                    };
                }
            })
            ;

        CreateMap<GbaPersoonBeperkt, PersoonBeperkt>()
            .ForMember(dest => dest.Leeftijd, opt =>
            {
                opt.PreCondition(src => src.OpschortingBijhouding == null ||
                                        src.OpschortingBijhouding.Reden?.Code != "O");
                opt.MapFrom(src => src.Geboorte.Datum.Map().Leeftijd());
            })
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek()))
            .BeforeMap((src, dest) =>
            {
                if(src.Naam != null || src.PersoonInOnderzoek != null)
                {
                    src.Naam ??= new GbaNaamBasis();
                    if (src.Geslacht != null)
                    {
                        src.Naam.Geslacht = src.Geslacht;
                    }
                    src.Naam.InOnderzoek = src.PersoonInOnderzoek;
                }
                if(src.Geboorte != null || src.PersoonInOnderzoek != null)
                {
                    src.Geboorte ??= new GbaGeboorteBeperkt();
                    src.Geboorte.InOnderzoek = src.PersoonInOnderzoek;
                }
            })
            .AfterMap((src, dest) =>
            {
                if (src.Verblijfplaats != null)
                {
                    dest.Adressering = new AdresseringBeperkt
                    {
                        Adresregel1 = src.Verblijfplaats.Adresregel1(),
                        Adresregel2 = src.Verblijfplaats.Adresregel2(src.GemeenteVanInschrijving),
                        Adresregel3 = src.Verblijfplaats.Adresregel3(),
                        Land = src.Verblijfplaats.Land(),
                        InOnderzoek = src.AdresseringInOnderzoek(),
                        IndicatieVastgesteldVerblijftNietOpAdres = src.Verblijfplaats?.InOnderzoek?.AanduidingGegevensInOnderzoek == "089999"
                    };
                }
            })
            ;

        CreateMap<GbaPersoon, Persoon>()
            .BeforeMap((src, dest) =>
            {
                if(src.Naam != null || src.PersoonInOnderzoek != null)
                {
                    src.Naam ??= new GbaNaamPersoon();
                    if(src.Geslacht != null)
                    {
                        src.Naam.Geslacht = src.Geslacht;
                    }
                    if(src.Partners != null)
                    {
                        src.Naam.Partners = src.Partners;
                    }
                    src.Naam.InOnderzoek = src.PersoonInOnderzoek;
                }
                if (src.Geboorte != null || src.PersoonInOnderzoek != null)
                {
                    src.Geboorte ??= new GbaGeboorte();
                    src.Geboorte.InOnderzoek = src.PersoonInOnderzoek;
                }
                if(src.Immigratie != null || src.Verblijfplaats != null)
                {
                    src.Immigratie ??= new GbaImmigratie();
                    src.Immigratie.InOnderzoek = src.Verblijfplaats?.InOnderzoek;
                }
            })
            .AfterMap((src, dest) =>
            {
                if(dest.Naam != null || src.Verblijfplaats != null)
                {
                    dest.Adressering = new Adressering
                    {
                        Aanhef = dest.Naam.Aanhef(),
                        Aanschrijfwijze = dest.Naam.Aanschrijfwijze(),
                        GebruikInLopendeTekst = dest.Naam.GebruikInLopendeTekst(),

                        Adresregel1 = src.Verblijfplaats.Adresregel1(),
                        Adresregel2 = src.Verblijfplaats.Adresregel2(src.GemeenteVanInschrijving),
                        Adresregel3 = src.Verblijfplaats.Adresregel3(),
                        Land = src.Verblijfplaats.Land()
                    };
                }
                if (src.PersoonInOnderzoek != null ||
                    (src.Partners != null && src.Partners.Any(p => p.InOnderzoek != null))||
                    src.Verblijfplaats?.InOnderzoek != null)
                {
                    dest.Adressering ??= new Adressering();

                    dest.Adressering.InOnderzoek = src.AdresseringInOnderzoek();
                    dest.Adressering.IndicatieVastgesteldVerblijftNietOpAdres = src.Verblijfplaats?.InOnderzoek?.AanduidingGegevensInOnderzoek == "089999";
                }
            })
            .ForMember(dest => dest.DatumEersteInschrijvingGBA, opt => opt.MapFrom(src => src.DatumEersteInschrijvingGBA.Map()))
            .ForMember(dest => dest.GeheimhoudingPersoonsgegevens, opt => opt.MapFrom(src => src.Geheimhouding()))
            .ForMember(dest => dest.Leeftijd, opt =>
            {
                opt.PreCondition(src => src.OpschortingBijhouding == null ||
                                        src.OpschortingBijhouding.Reden?.Code != "O");
                opt.MapFrom(src => src.Geboorte.Datum.Map().Leeftijd());
            })
            .ForMember(dest => dest.DatumInschrijvingInGemeente, opt => opt.MapFrom(src => src.DatumInschrijvingInGemeente.Map()))
            .ForMember(dest => dest.GemeenteVanInschrijving, opt =>
            {
                opt.Condition(src => src.GemeenteVanInschrijving?.Code != "0000");
            })
            .ForMember(dest => dest.InOnderzoek, opt => opt.MapFrom(src => src.InOnderzoek()))
            .ForMember(dest => dest.IndicatieGezagMinderjarige, opt => opt.MapFrom(src => src.IndicatieGezagMinderjarige))
            .ForMember(dest => dest.Gezag, opt => {
                opt.PreCondition(src => src.Gezag != null);
                opt.MapFrom(src => src.Gezag);
            })
            ;
    }
}
