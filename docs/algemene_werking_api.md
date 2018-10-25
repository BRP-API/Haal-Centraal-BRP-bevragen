# Algemene werking van de API
Dit document bevat de functionele specificaties van de werking van de api op resource- of endpointoverstijgende onderwerpen.

De functionaliteit van de api wordt beschreven in:
* [Functionele specificaties](functionele_specificaties.md)
* [technische specificaties](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/openapi.yaml) (Open APO Specificaties 3).
* [Algemene werking van de API](algemene_werking_api.md)
* [Functionele specificaties van resources en endpoints](functionele_specificaties_resources_endpoints.md)

## API Strategie
Deze API volgt de [DSO API strategie](https://github.com/Geonovum/KP-APIs/blob/master/Werkgroep%20API%20strategie/API%20strategie%20voorbeelden/dso-api-strategie_-_12_maart_2018.pdf), tenzij expliciet anders aangegeven.
In deze API gebruiken we onder anderen de in de DSO API Strategie beschreven functionaliteit onder andere voor:

* Versionering
* Filteren en sorteren
* Tijdreizen
* Paginering
* Beperken van het aantal verzoeken per tijdsperiode
* Foutafhandeling

## JSON HAL
In deze API wordt alleen JSON HAL ondersteund. Andere uitvoerformaten worden *niet* ondersteund.

We gebruiken JSON HAL voor:

* Paginering en weergave van collecties
* Links naar relaties (JSON HAL)
* Automatische laden van gelinkte resources (embedded van resources vanuit de expand parameter)

Deze API ondersteunt (vooralsnog) geen vrije tekst zoeken.

## Mogelijk onvolledige datums
Voor elke mogelijk onvolledige datum in het antwoordbericht zijn er 4 attributen gedefinieerd:
* jaar: date-fullyear
* maand: date-month
* dag: date-mday
* datum: date

Bijvoorbeeld voor de geboortedatum: geboortejaar, geboortemaand, geboortedag en geboortedatum.

Deze velden zijn gedefinieerd in ISO8601-typen.

Als er een volledige geboortedatum is, worden alle 4 velden ingevuld.
Bijvoorbeeld geboortedatum is 26 mei 2004:
  * geboortejaar: 2004
  * geboortemaand: 5
  * geboortedag: 26
  * geboortedatum: "2004-05-26"

Als alleen geboortejaar en geboortemaand bekend zijn, worden alleen geboortejaar en geboortedag ingevuld. Geboortedatum en geboortedag worden dan weggelaten of hebben waarde null.
Bijvoorbeeld bekend is geboortemaand september 1973:
  * geboortejaar: 1973
  * geboortemaand: 9
  * geboortedag: null
  * geboortedatum: null

Als alleen geboortejaar bekend is, wordt alleen geboortejaar ingevuld. Geboortedatum, geboortedag en geboortemaand worden dan weggelaten of hebben waarde null.

Bijvoorbeeld bekend is geboortejaar 1956:
  * geboortejaar: 1956
  * geboortemaand: null
  * geboortedag: null
  * geboortedatum: null

## Zoeken met een wildcard
Bij het zoeken op enkele zoekparameters mag een wildcard worden gebruikt. Voor de overige zoek-parameters wordt zoeken met wildcard *niet* ondersteund.

Het wildcard karakter is "%". De wildcard mag vooraan, achteraan of beide worden gezet.
  Bijvoorbeeld zoeken op geslachtsnaam "groen%" vindt geslachtsnamen die beginnen met "groen", zoals "Groen", "Groenlo" en "Groenink".
  Bijvoorbeeld zoeken op voornamen "jan%" vindt o.a. "Jan", "Jan Willem" en "Jan Piet Joris".
  Bijvoorbeeld zoeken op geslachtsnaam "%Man" vindt geslachtsnamen die eindigen op "man", zoals "Hofman" en "Bosman", maar niet "Hermans".
  Bijvoorbeeld zoeken op geslachtsnaam "%man%" vindt geslachtsnamen waarin "man" voorkomt, zoals "Hofman", "Bosman", "Hermans" en "Timmermans".

Bij het zoeken op de parameters die een wildcard ondersteunen, moeten er minimaal 2 karakters exclusief de wildcard(s) worden opgegeven.
  Bijvoorbeeld zoeken op geslachtsnaam "a%" levert een foutmelding.
  Bijvoorbeeld zoeken op geslachtsnaam "%a%" levert een foutmelding.
  Bijvoorbeeld zoeken op geslachtsnaam "a" levert een foutmelding.
  Bijvoorbeeld zoeken op geslachtsnaam "os" vindt *geen* foutmelding.

## Valideren van zoekparameters
Wanneer de waarde bij een zoekparameter niet voldoet aan de specificatie voor de parameter, **MOET** een fout worden teruggegeven.

Bijvoorbeeld zoeken met geslachtsaanduiding=A levert een foutmelding (is geen geldige enumeratiewaarde).
Bijvoorbeeld zoeken met geboortedatum="2001-11-00" levert een foutmelding (is geen geldige datum).
Bijvoorbeeld zoeken met huisnummer=A levert een foutmelding (is geen integer).
Bijvoorbeeld zoeken met huisletter=AB levert een foutmelding (is langer dan de maximale lengte).
Bijvoorbeeld zoeken met postcode=AZ levert een foutmelding (voldoet niet aan de reguliere expressie).

### Zoeken op parameter met referentielijst (tabel)
Verschillende zoekparameters accepteren alleen waarden uit een gedefinieerde referentielijst. Bijvoorbeeld:
* **voorvoegselGeslachtsnaam**: Voorvoegseltabel (tabel 36)
* **gemeenteVanInschrijving**: Gemeententabel (tabel 33)

**TODO: zoeken we op code of op omschrijving? Bijvoorbeeld gemeentecode of gemeentenaam?**

Bijvoorbeeld zoeken op voorvoegselGeslachtsnaam=bestaatniet levert een foutmelding (komt niet voor in Voorvoegseltabel (tabel 36).

Bijvoorbeeld zoeken met gemeenteVanInschrijving=3000 levert een foutmelding (code komt niet voor in Gemeententabel (tabel 33)).

### Zoeken op parameter met enumeratie
Wanneer een zoekparameter is gedefinieerd als enumeratie, **MOET** er een foutmelding worden gegeven wanneer de parameterwaarde niet in de enumeratie voorkomt.
Bijvoorbeeld zoekparameter *geslachtsaanduiding* verwacht de geslachtsaanduiding code in de enumeratiewaardenlijst.

Bijvoorbeeld zoeken met geslachtsaanduiding=V vindt alleen vrouwen.
Bijvoorbeeld zoeken met geslachtsaanduiding=Vrouw levert een foutmelding.
Bijvoorbeeld zoeken met geslachtsaanduiding=v levert een foutmelding.
Bijvoorbeeld zoeken met geslachtsaanduiding=A levert een foutmelding.

## Zoeken is case-insensitive
Bij het zoeken op tekstvelden wordt case-insensitive gezocht.
  Bijvoorbeeld zoeken op geslachtsnaam "groen" vindt ook "Groen".
  Bijvoorbeeld zoeken voorvoegselGeslachtsnaam "van der" vindt ook "Van der".
  Bijvoorbeeld zoeken voorvoegselGeslachtsnaam "Van der" vindt ook "van der".

Het zoeken op een enumeratie is wél case-sensitive.
  Bijvoorbeeld zoeken op geslachtsaanduiding=v levert een foutmelding.

## Zoeken met diakrieten
Wanneer een diakriet wordt opgegeven, wordt deze ook gebruikt.
  Bijvoorbeeld zoeken op "Stöcker" vindt wel "Stöcker", maar niet "Stocker".

Wanneer geen diakriet wordt opgegeven, worden equivalente diakrieten ook gevonden.
  Bijvoorbeeld zoeken op "Stocker" vindt "Stocker" én "Stöcker".

## Pagineren
Het maximaal aantal zoekresultaten per zoekvraag op zoekvragen wordt beperkt. Voor alle zoekvragen in deze API wordt daarom paginering toegepast.
De provider van de API kan bepalen wat dit maximaal aantal zoekresultaten pagina.

Om paginering te ondersteunen wordt bij het antwoord conform JSON HAL en de [DSO API strategie](https://github.com/Geonovum/KP-APIs/blob/master/Werkgroep%20API%20strategie/API%20strategie%20voorbeelden/dso-api-strategie_-_12_maart_2018.pdf) (§2.6.9) een aantal links meegegeven om te navigeren door het resultaat:
* Eerste pagina (first)
* Vorige pagina (previous)
* Volgende pagina (next)

Er is *GEEN* link naar de laatste pagina (last). Response headers X-Total-Count en X-Pagination-Count worden in deze API *NIET* ondersteund.

## Foutafhandeling
Foutmeldingen in JSON worden teruggegeven in het application/problem+json formaat ([RFC 78-7](https://tools.ietf.org/html/rfc7807)).
Zie de [API-strategie](https://github.com/Geonovum/KP-APIs/blob/master/Werkgroep%20API%20strategie/design-principles/errors.md)

## Autorisatie
De API levert alleen gegevens terug waar de vragende organisatie voor geautoriseerd is. De vragende applicatie is verantwoordelijk voor het filteren van het antwoord op autorisatie van de gebruiker.
