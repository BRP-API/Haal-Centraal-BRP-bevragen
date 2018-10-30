# Functionele Specificaties Bevragingen ingeschreven natuurlijk personen

## Doel van dit document
Dit document beschrijft de API voor het bevragen van ingeschreven natuurlijk personen.

De werking van de API wordt functioneel beschreven in de volgende documenten:
* Functionele specificaties (dit document)
* [technische specificaties](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/openapi.yaml) (Open APO Specificaties 3).
* [Algemene werking van de API](algemene_werking_api.md)
* [Functionele specificaties van resources en endpoints](functionele_specificaties_resources_endpoints.md)

## Doel van de API
Het doel van de API is om op een eenvoudige en eenduidige manier persoonsgegevens te ontsluiten. Dit betreft het raadplegen van personen en het zoeken van personen die zijn ingeschreven in het GBA of in het andernatuurlijkpersonen.

## Visie
Uitgangspunt voor de API is bevragen bij de bron, waarbij de bron voor ingeschreven natuurlijk personen de GBA (BRP) is.
Gestreefd wordt naar een landelijke voorziening waar deze API op beschikbaar komt.
Tot dat moment kan de API worden gerealiseerd in de gemeentelijke GBA of een gegevensmagazijn.

Gegevens van natuurlijk personen die niet in het GBA (BRP) zitten, zoals gemeentelijke kerngegevens (bijvoorbeeld correspondentieadres, e-mailadres) zijn niet opgenomen in de API.

De gegevens in de API zijn zoveel mogelijk gemodelleerd zoals deze ook in de bron zitten, dus conform LO GBA.

De API is zodanig ontworpen dat deze zo eenvoudig mogelijk geïmplementeerd kan worden, het principe van 'developer first'. Developers van de API worden geschouwd als de primaire "gebruikers" van de API.
De API is geoptimaliseerd voor eenvoud van gebruik voor consumers van de API. Er zijn immers veel meer gebruikers (consumers) van de API dan providers van de API.

Bij het ontwerp van de API is gestreefd deze zoveel mogelijk RESTful te laten zijn.

De API wordt agile (door)ontwikkeld. Voor de eerste versie is de informatiebehoefte die is geïnventariseerd voor koppelvlakstandaard RSGB-bevragingen gebruikt. De standaard kan op basis van user stories, daadwerkelijke functionele vraag in processen en ketens, worden uitgebreid.

## User stories
De API implementeert de volgende user stories:

### Ik wil ingeschreven natuurlijk personen zoeken op de geslachtsnaam
Het is mogelijk ingeschreven natuurlijk personen te zoeken op de volgende eigenschappen van de persoon:
* geslachtsnaam
* geboortedatum
* voornamen
* voorvoegselGeslachtsnaam
* geslachtsaanduiding
* geboorteplaats
* gemeenteVanInschrijving

Wanneer gezocht wordt op naam moet minimaal de geslachtsnaam worden opgegeven.

Als resultaat van de zoekvraag wordt een lijst gegeven van de gevonden [ingeschreven natuurlijk personen](functionele_specificaties_resources_endpoints.md#ingeschreven-natuurlijk-personen).

Deze functionaliteit is te gebruiken via de endpoint [/ingeschrevennatuurlijkpersonen](functionele_specificaties_resources_endpoints.md#ingeschrevennatuurlijkpersonen).

#### Zoeken binnen eigen gemeente of landelijk
Default wordt gezocht onder alle ingeschreven personen in Nederlandse gemeenten. Dit zijn ingeschreven personen binnen en buiten de eigen gemeente.

Om alleen personen die zijn ingeschreven in de eigen gemeente in het antwoord te krijgen, kan zoekparameter **gemeenteVanInschrijving** worden gebruikt.

#### Zoeken met geboorteplaats
De zoekparameter geboorteplaats kan een Nederlandse of een niet-Nederlandse plaats betreffen. Gezocht wordt op de *naam* van de geboorteplaats, niet de gemeentecode.
  Bijvoorbeeld zoeken met geboorteplaats=Sas van Gent vindt alleen personen die zijn geboren in Sas van Gent.
  Bijvoorbeeld zoeken met geboorteplaats=0704 vindt geen personen.

Zoeken op geboorteplaats is case-insensitive.
  Bijvoorbeeld zoeken met geboorteplaats=sas van gent vindt alleen personen die zijn geboren in Sas van Gent.

Zie [Zoeken met diakrieten](algemene_werking_api.md#zoeken-met-diakrieten).
  Bijvoorbeeld zoeken met geboorteplaats=malmo vindt personen die zijn geboren in Malmo of Malmö.
  Bijvoorbeeld zoeken met geboorteplaats=malmö vindt personen die zijn geboren in Malmö, geen personen die geboren zijn in Malmo.

### Ik wil ingeschreven natuurlijk personen zoeken op de verblijfplaats
Het is mogelijk ingeschreven personen te zoeken die op een adres verblijven. Het gaat hier om ingeschreven natuurlijk personen die het opgegeven adres als actuele verblijfplaats hebben.

Als resultaat van de zoekvraag wordt een lijst gegeven van de gevonden [ingeschreven natuurlijk personen](functionele_specificaties_resources_endpoints.md#ingeschreven-natuurlijk-personen).

Deze functionaliteit is te gebruiken via de endpoint [/ingeschrevennatuurlijkpersonen](functionele_specificaties_resources_endpoints.md#ingeschrevennatuurlijkpersonen).

Er zijn drie manieren om te zoeken op verblijfsplaats:
1. Zoeken op postcode en huisnummer
2. Zoeken op woonplaatsnaam, naamOpenbareRuimte en huisnummer
3. Zoeken op identificatiecodeNummeraanduiding

#### Zoeken op postcode en huisnummer
Dit kan door te zoeken op de volgende eigenschappen van de verblijfsplaats:
* postcode
* huisnummer
* huisletter
* huisnummertoevoeging

Hier moeten postcode en huisnummer minimaal een waarde hebben en zijn huisletter en huisnummertoevoeging optioneel.

Bijvoorbeeld zoeken met postcode=1234AB&huisnummer=56 levert zoekresultaten terug.
Bijvoorbeeld zoeken met postcode=1234AB&huisnummer=56&huisletter=A levert zoekresultaten terug.
Bijvoorbeeld zoeken met postcode=1234AB&huisnummer=56&huisnummertoevoeging=tegenover levert zoekresultaten terug.
Bijvoorbeeld zoeken met postcode=1234AB&huisnummer=56&huisletter=A&huisnummertoevoeging=tegenover levert zoekresultaten terug.
Bijvoorbeeld zoeken met postcode=1234AB&huisnummertoevoeging=tegenover levert een foutmelding.
Bijvoorbeeld zoeken met huisnummer=56&huisletter=A&huisnummertoevoeging=tegenover levert een foutmelding.

#### Zoeken op woonplaatsnaam, naamOpenbareRuimte en huisnummer
Dit kan door te zoeken op de volgende eigenschappen van de verblijfsplaats:
* naamopenbareruimte
* huisnummer
* huisletter
* huisnummertoevoeging
* woonplaatsnaam

Hier moeten minimaal de woonplaatsnaam, naamopenbareruimte en huisnummer een waarde hebben. Zoekparameters huisletter en huisnummertoevoeging zijn optioneel.

Bijvoorbeeld zoeken met woonplaatsnaam=rotterdam&naamopenbareruimte=coolsingel&huisnummer=101 levert zoekresultaten terug.
Bijvoorbeeld zoeken met woonplaatsnaam=rotterdam&naamopenbareruimte=coolsingel&huisnummer=101&huisletter=B levert zoekresultaten terug.
Bijvoorbeeld zoeken met naamopenbareruimte=coolsingel&huisnummer=101&huisletter=B levert een foutmelding.

### Ik wil een ingeschreven natuurlijk persoon raadplegen
Het is mogelijk de gegevens van een ingeschreven natuurlijk persoon te raadplegen. De ingeschreven natuurlijk persoon wordt geïdentificeerd (uri) door het burgerservicenummer van de persoon.

Als resultaat worden de attributen van de ingeschreven natuurlijk persoon teruggegeven.

Het is mogelijk in de vraag aan te geven welke attributen moeten worden teruggegeven. Standaard worden alle attributen van de persoon in het antwoord teruggegeven.

Standaard worden in het antwoord relaties naar andere objecttypen (zoals kinderen, ouders, partner, adres) teruggegeven als hyperlink. De gegevens van de relatie (gerelateerde) kunnen dan in een extra aanroep worden opgevraagd. Het is ook mogelijk in de zoekvraag aan te geven welke relaties direct moeten worden gegeven met de persoon. Op deze manier is het bijvoorbeeld mogelijk in één vraag de gevonden persoon en diens partner te krijgen.

Deze functionaliteit is te gebruiken via de endpoint [/ingeschrevennatuurlijkpersonen/{burgerservicenummer}](functionele_specificaties_resources_endpoints.md#ingeschrevennatuurlijkpersonenburgerservicenummer).

Als resultaat worden de gegevens van resource [ingeschreven natuurlijk personen](functionele_specificaties_resources_endpoints.md#ingeschreven-natuurlijk-personen) gegeven.

### Ik wil de verblijfsplaatshistorie van een ingeschreven natuurlijk persoon raadplegen
Het is mogelijk te raadplegen welke verblijfsplaatsen een ingeschreven natuurlijk persoon heeft gehad. De ingeschreven natuurlijk persoon wordt geïdentificeerd (uri) door het burgerservicenummer van de persoon. De historie die wordt teruggegeven betreft de materiële historie.

Bij de vraag kan de periode (van en tot en met) worden opgegeven waarvoor de verblijfsplaatshistorie gewenst wordt. Ook kan een peildatum worden opgegeven, waarmee de verblijfsplaats wordt teruggegeven die geldig was op de opgegeven peildatum.

Als resultaat worden de attributen van de ingeschreven natuurlijk persoon teruggegeven, waarbij de historische voorkomens van de verblijfsplaats allemaal worden opgenomen. In elk historisch voorkomen van de verblijfsplaats bevat de begin- en einddatum van geldigheid van de verblijfsplaats.

**TODO: oplossing voor historie uitwerken**

### Ik wil de partnerhistorie van een ingeschreven natuurlijk persoon raadplegen
Het is mogelijk de historie van partners van een ingeschreven natuurlijk persoon te raadplegen. De historie die wordt teruggegeven betreft de materiële historie.

Bij de vraag kan de periode (van en tot en met) worden opgegeven waarvoor de partnerplaatshistorie gewenst wordt. Ook kan een peildatum worden opgegeven, waarmee de partner wordt teruggegeven die geldig was op de opgegeven peildatum.

Als resultaat wordt het burgerservicenummer van de ingeschreven natuurlijk persoon teruggegeven en een lijst met voor elk historisch partnerschap de link waarmee de details over het partnerschap kunnen worden opgehaald.
Het is mogelijk in de zoekvraag aan te geven dat de attributen van elk historisch voorkomen van partnerschap van de persoon in het antwoord moeten worden teruggegeven.

**TODO: oplossing voor historie uitwerken**

### Ik wil de verblijfstitelhistorie van een ingeschreven natuurlijk persoon raadplegen
Het is mogelijk de historie van de verblijfstitel van een ingeschreven natuurlijk persoon te raadplegen.

Bij de vraag kan de periode (van en tot en met) worden opgegeven waarvoor de verblijfstitelhistorie gewenst wordt. Ook kan een peildatum worden opgegeven, waarmee de verblijfstitel wordt teruggegeven die geldig was op de opgegeven peildatum.

Als resultaat wordt het burgerservicenummer van de ingeschreven natuurlijk persoon teruggegeven en een lijst met voor elk historisch voorkomen van verblijfstitel de Ingangsdatum verblijfstitel, Datum einde verblijfstitel en de aanduidingVerblijfstitel.

**TODO: oplossing voor historie uitwerken**

### Ik wil de bewoning van een verblijfsadres raadplegen, zodat ik kan zien welke personen gedurende welke periode op een verblijfsadres zijn/waren ingeschreven.
Het is mogelijk te raadplegen welke bewoners er op een adres verblijven of hebben verbleven. Hiermee worden alle ingeschreven natuurlijk personen gezocht die het opgegeven adres als verblijfsplaats hebben (gehad).

Dit kan door te zoeken op de volgende eigenschappen van de verblijfsplaats:
* postcode
* huisnummer
* huisletter
* huisnummertoevoeging
* identificatiecodenummeraanduiding

Bij de vraag kan de periode (van en tot en met) worden opgegeven waarvoor de bewoning gewenst wordt. Ook kan een peildatum worden opgegeven, waarmee de bewoners worden teruggegeven die geldig was op de opgegeven peildatum.

Als resultaat wordt een lijst met verblijfsplaatsen (adressen) gegeven, met per verblijfsplaats een lijst met bewoners (ingeschreven natuurlijk personen). Bij elke bewoner is de begin- en einddatum opgenomen van de bewoning.

**TODO: oplossing voor historie uitwerken**

## Migratie en doorontwikkeling van de standaard
De API is ontwikkeld met het oog op de ambitie van een landelijke voorziening voor het bevragen van de GBA gegevens, waarop kan worden aangesloten met de NLX voorziening die door de Common Ground beweging wordt gerealiseerd. Deze voorziening maakt het mogelijk om veilig te communiceren tussen partijen op een manier die AVG-compliant is. Implementatie van deze architectuur is mogelijk op het moment dat de landelijke voorziening beschikbaar is én NLX een productiestatus heeft gekregen.

Tot dat moment kan de API worden gerealiseerd door de locale BRP (GBA + RNI), of door een gegevensmagazijn.

### Samengestelde diensten
De API levert alleen gegevens uit de betreffende bron: BRP (GBA plus RNI). Dit betekent dat verschillende voor ingeschreven natuurlijk personen relevante gegevens niet door deze API worden geleverd. Dit betreft gemeentelijke kerngegevens (bijvoorbeeld correspondentieadres) en attributen van gerelateerde resources uit een andere bron (bijvoorbeeld de nummeraanduiding uit de BAG).

Om deze gegevens ter beschikking te krijgen zou er:
* Een API ontwikkeld moeten worden voor het ontsluiten van de gemeentelijke kerngegevens
* Een API ontwikkeld moeten worden voor het bevragen van de gerelateerde registratie (BAG)
* Een API ontwikkeld moeten worden voor de samengestelde vragen (BRP + kerngegevens + BAG-gegevens)
