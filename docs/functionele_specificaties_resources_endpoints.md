# Functionele specificaties van resources en endpoints
Dit document beschrijft de functionele werking van resources en endpoints in de api.
Naast dit document is er ook:
* [Resource- of endpointoverstijgende functionele specificaties](algemene_werking_api.md).
* [Functionele specificaties](functionele_specificaties.md)
* [technische specificaties](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/openapi.yaml) (Open APO Specificaties 3).

## Resources
### Ingeschreven natuurlijk personen
Deze resource bevat de gegevens van een ingeschreven natuurlijk persoon. Dit kan zowel een ingezetene als een niet-ingezetene zijn.

#### Aanschrijfwijze
Aan de resource is een attribuut aanschrijfwijze toegevoegd. Hierin wordt de naam samengesteld op basis van de aanduiding naamgebruik. Hiermee wordt een consistente aanschrijfwijze van personen in de verschillende gemeentelijke processen bevorderd.

Zie [Algoritme voor het samenstellen van de aanschrijfwijze](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/Aanschijfwijze%20opstellen.md).

#### Verblijfplaats
De verblijfplaats van een persoon is opgenomen in de resource, zodat bij een persoon direct de adresgegevens kunnen worden opgehaald. Ook kan hiermee het adres worden verkregen wanneer het geen BAG-adres is.
Daarnaast wordt, wanneer de verblijfplaats een BAG-adres is, een link naar de nummeraanduiding opgenomen.

Bij het samenstellen van het bericht *MAG* de API adresgegevens leveren zoals die in de eigen registratie staan. Dit wordt tijdelijk toegestaan ten behoeve van migratie.
Bij het samenstellen van het bericht *MAG* de API adresgegevens ophalen uit de BAG op basis van de nummeraanduiding. Dit heeft de voorkeur, aangezien dan de gegevens worden gehaald bij de bron.

De verblijfplaats kan verschillende soorten adres hebben:
1. Een binnenlands adres
2. Een briefadres
3. Een buitenlands adres

De resource ingeschrevennatuurlijkpersonen kent twee endpoints:
* [/ingeschrevennatuurlijkpersonen](#ingeschrevennatuurlijkpersonen)
* [/ingeschrevennatuurlijkpersonen/{burgerservicenummer}](#ingeschrevennatuurlijkpersonenburgerservicenummer)


## Endpoints

### /ingeschrevennatuurlijkpersonen
Dit endpoint kan gebruikt worden om één of meerdere [ingeschreven natuurlijk personen](#ingeschreven-natuurlijk-personen) te zoeken. Het levert een collectie van [ingeschreven natuurlijk personen](#Ingeschrevennatuurlijkpersonen).

Er kan gezocht worden met verschillende zoekpaden van zoekparameters:
* geslachtsnaam, geboortedatum, voornamen, voorvoegselGeslachtsnaam, geslachtsaanduiding, geboorteplaats, gemeenteVanInschrijving, [inclusiefnietingezetenen](#ingezetenen-en-niet-ingezetenen)
* postcode, huisnummer, huisletter, huisnummertoevoeging
* woonplaatsnaam, naamopenbareruimte, huisnummer, huisletter, huisnummertoevoeging
* identificatiecodeNummeraanduiding

Deze zoekpaden mogen *NIET* gecombineerd worden. Wanneer een combinatie van zoekparameters wordt gebruikt uit meerdere van de bovengenoemde zoekpaden, *MOET* een foutmelding worden gegeven.

Bijvoorbeeld zoeken op ?postcode=1234AA&geboortedatum=19750730 levert een foutmelding.

Aanvullend kunnen de volgende parameters worden gebruikt:
* [inclusiefoverledenpersonen](#overleden-personen)
* page: voor paginering
* sort: voor de sortering van het antwoord
* fields: voor het filteren van welke attributen in het antwoord moeten worden opgenomen
* expand: voor lazy loading van gerelateerde resources in het antwoord

#### Zoeken met wildcard
Bij het zoeken op **geslachtsnaam**, **voornamen** en **naamopenbareruimte** *mag* een wildcard worden gebruikt. Voor de overige zoek-parameters wordt zoeken met wildcard *NIET* ondersteund.

Zie [Zoeken met een wildcard](algemene_werking_api.md#zoeken-met-een-wildcard) voor de werking van zoeken met een wildcard.

#### Zoeken op onvolledige datum
Bij het zoeken op geboortedatum mag *GEEN* onvolledige datum worden gebruikt.
De datum waarop gezocht wordt moet een volledige en geldige datum zijn.
  Bijvoorbeeld zoeken op geboortedatum "2001-11" levert een foutmelding.
  Bijvoorbeeld zoeken op geboortedatum "2001-11-00" levert een foutmelding.
  Bijvoorbeeld zoeken op geboortedatum "2001-11-??" levert een foutmelding.
  Bijvoorbeeld zoeken op geboortedatum "2001-11-31" levert een foutmelding.

In het antwoord kunnen wel onvolledige datums worden teruggegeven. Zie [Algemene werking van de API | Onvolledige datums](algemene_werking_api.md#onvolledige-datums).

#### Overleden personen
Default levert een zoekvraag **alleen personen op die nog in leven zijn**.
Om ook overleden personen in het antwoord te krijgen, kan zoekparameter **inclusiefoverledenpersonen** worden gebruikt.

Wanneer parameter inclusiefoverledenpersonen niet is opgenomen in de zoekquery, worden *GEEN* overleden personen opgenomen in het antwoord.
Wanneer parameter inclusiefoverledenpersonen=false is opgenomen in de zoekquery, worden *GEEN* overleden personen opgenomen in het antwoord.
Wanneer parameter inclusiefoverledenpersonen=true is opgenomen in de zoekquery, worden *GEEN* overleden personen opgenomen in het antwoord.

#### Ingezetenen en niet-ingezetenen
Default wordt gezocht onder alle ingeschreven ingezeten personen. Dit zijn ingeschreven personen binnen en buiten de eigen gemeente.  Niet-ingezeten ingeschreven personen in het RNI worden niet gevonden.

Wanneer men alle ingeschreven personen wil vinden inclusief niet-ingezetenen kan de zoekparameter **inclusiefnietingezetenen** worden gebruikt.

Wanneer parameter inclusiefnietingezetenen niet is opgenomen in de zoekquery, worden *GEEN* niet-ingezetenen opgenomen in het antwoord.
Wanneer parameter inclusiefnietingezetenen=false is opgenomen in de zoekquery, worden *GEEN* niet-ingezetenen opgenomen in het antwoord.
Wanneer parameter inclusiefnietingezetenen=true is opgenomen in de zoekquery, worden ook niet-ingezetenen opgenomen in het antwoord.

### /ingeschrevennatuurlijkpersonen/{burgerservicenummer}
Dit endpoint kan gebruikt worden om de actuele status van één [ingeschreven natuurlijk persoon](#ingeschreven-natuurlijk-personen) op te halen.
De persoon wordt geselecteerd met het burgerservicenummer.

Mocht in de registratie blijken dat er meer dan één persoon voorkomt met dit burgerservicenummer, dan *MOET* de API een foutmelding teruggeven.
