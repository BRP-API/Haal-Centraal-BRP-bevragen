# Personen bevragen

De BRP bevragen API maakt het mogelijk om gegevens van actuele personen in de basisregistratie personen (BRP) te raadplegen. De personen worden opgezocht op basis van hun identificerende gegevens.

In de BRP worden personen uniek geïdentificeerd met behulp van hun burgerservicenummer. Is het burgerservicenummer van de te raadplegen persoon/personen bekend, dan moet de [Raadpleeg persoon met burgerservicenummer](#raadplegen-van-personen) operatie worden gebruikt om de betreffende persoon/personen te raadplegen.

Is het burgerservicenummer van de te raadplegen persoon/personen niet bekend, dan kan deze worden opgezocht met behulp van de [Zoek persoon](#zoeken-van-personen) operaties.

## Algemene Verordening Gegevensbescherming (AVG)

De BRP bevragen API is ontworpen conform de REST principes. Om ook aan de AVG te conformeren zijn er concessies gedaan met betrekking tot het toepassen van de REST principes. De belangrijkste concessie is dat de POST methode en niet de GET methode wordt gebruikt om personen te bevragen. Dit zorgt er voor dat er geen [persoonlijk identificeerbare informatie (PII)](https://piwikpro.nl/blog/pii-niet-pii-en-persoonsgegevens/) terecht komen in de url van een request en daardoor ook niet in server logs.

## Zoeken van personen

De volgende zoek operaties kunnen worden gebruikt om een persoon met niet-uniek identificerende persoonsgegevens te vinden:

- zoek met geslachtsnaam en geboortedatum
  - [overzicht](./zoek-met-geslachtsnaam-en-geboortedatum/overzicht.feature)
  - [fout cases](./zoek-met-geslachtsnaam-en-geboortedatum/fout-cases.feature)
- zoek met geslachtsnaam, voornamen en gemeente van inschrijving
  - [overzicht](./zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met postcode en huisnummer
  - [overzicht](./zoek-met-postcode-en-huisnummer/overzicht.feature)
  - [fout cases](./zoek-met-postcode-en-huisnummer/fout-cases.feature)
- zoek met straat, huisnummer en gemeente van inschrijving
  - [overzicht](./zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met nummeraanduiding identificatie
  - [overzicht](./zoek-met-nummeraanduiding-identificatie/overzicht.feature)
  - [fout cases](./zoek-met-nummeraanduiding-identificatie/fout-cases.feature)

Het resultaat van deze operaties is een PersoonBeperkt collectie/lijst. Standaard bevat deze lijst alleen personen die in leven zijn. Om een overleden persoon te zoeken, moet de inclusiefOverledenPersonen parameter op true worden gezet. 

Voor overleden personen wordt altijd het indicatieOverleden veld geleverd. Zie de [indicatie overleden](../overlijden-indicatie-overleden.feature) feature voor meer informatie over dit veld.


## Raadplegen van personen

Als de burgerservicenummer van de te bevragen personen wel bekend is, kan de volgende operatie worden gebruikt om gegevens van de persoon te raadplegen:

- raadpleeg met burgerservicenummer
  - [overzicht](./raadpleeg-met-burgerservicenummer/overzicht.feature)
  - [fout cases](./raadpleeg-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operatie is een Persoon collectie/lijst.

Bij een overleden persoon in het raadpleeg resultaat wordt altijd het indicatieOverleden veld geleverd.  Zie de [indicatie overleden](../overlijden-indicatie-overleden.feature) feature voor meer informatie over dit veld.

## Filteren van de velden van de gevonden personen

Bij elke bevraging moet de fields parameter worden gebruikt om aan te geven welke velden van een persoon geleverd moet worden. Dit is nodig ter bescherming van de privacy van de gevraagde personen en voor verduurzaming. Hoe minder velden er worden gevraagd, hoe minder de server en het netwerk worden belast.

De volgende velden hoeven niet met de fields parameter te worden gevraagd. Deze worden meegeleverd als de bijbehorende situatie van toepassing is

- geheimhoudingPersoonsgegevens
- indicatieOverleden
- inOnderzoek
- opschortingBijhouding
- rni

### Filteren van verblijfplaats velden en de adresregel velden van de adressering gegevensgroep

Voor verblijfplaats en adressering zijn er twee autorisatie profielen:

- geautoriseerd voor verblijfplaats binnenland (Adres en Locatie) en verblijfplaats buitenland gegevens
- geautoriseerd voor alleen verblijfplaats binnenland (Adres en Locatie) gegevens

Consumers die geautoriseerd zijn voor alleen verblijfplaats binnenland gegevens kunnen hierdoor de standaard veld paden van verblijfplaats en adresregels niet gebruiken om alleen verblijfplaats binnenland velden te vragen. Met deze veld paden worden zowel verblijfplaats binnenland als verblijfplaats buitenland gevraagd.
Om het mogelijk te maken voor consumers die niet geautoriseerd zijn voor het bevragen van verblijfplaats buitenland gegevens, zijn de volgende twee fields aliassen gedefinieerd waarmee kan worden aangegeven dat alleen verblijfplaats binnenland gegevens wordt opgevraagd: 

- verblijfplaatsBinnenland
- adresseringBinnenland

Voor de alias veld paden zijn er geen verkorte paden.

Het gebruik van de fields aliassen voor het opvragen van adresregels en verblijfplaats velden zijn beschreven in de volgende feature bestanden:
- [adresregels fields alias](./persoon/adressering/adres-regels/fields-alias.feature)
- [adresregels fields alias fout cases](./persoon/adressering/adres-regels/fields-alias-fout-cases.feature)
- [verblijfplaats fields alias](./persoon/verblijfplaats/fields-alias.feature)
- [verblijfplaats fields alias fout cases](./persoon/verblijfplaats/fields-alias-fout-cases.feature)

## Geen/null/false waarde, leeg object waarde en onbekend waarde

Om de payload van een response klein te houden, is er voor gekozen om onnodige waarden en hun veld niet te serialiseren. Deze waarden zijn:

- null. Voorbeeld: de gevraagde persoon heeft geen voorvoegsel en geen uitsluitingKiesrecht
- false. Voorbeeld: de gevraagde persoon heeft geen geheimhouding en de gevraagde velden zijn niet in onderzoek

Ook zorgen de json deserialisatie libraries er voor dat niet geleverde velden automatisch worden gezet naar de standaard waarde behorende bij het type (false bij boolean type, null bij string type).

## Gegevens in onderzoek

## Persoon extensies

- leeftijd
- adressering
  - aanhef (./persoon/adressering/aanhef)

## PersoonBeperkt velden overzicht

## Persoon velden overzicht
