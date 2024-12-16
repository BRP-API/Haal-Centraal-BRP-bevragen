---
layout: page-with-side-nav
title: Features
---

# {{ site.apiname }} Web API Features

Met de {{ site.apiname }} Web API kun je  gegevens van actuele personen in de basisregistratie personen (BRP) voor jouw applicatie zoeken en raadplegen met hun identificerende gegevens.

In de BRP worden personen uniek geïdentificeerd met behulp van hun burgerservicenummer. Is het burgerservicenummer van de te raadplegen persoon/personen bekend, dan moet jouw applicatie de [Raadpleeg persoon met burgerservicenummer](#raadplegen-van-personen) operatie gebruiken om de betreffende persoon/personen te raadplegen.

Is het burgerservicenummer van de te raadplegen persoon/personen niet bekend, dan kun je deze laten opzoeken met de [Zoek persoon](#zoeken-van-personen) operaties.

## Algemene Verordening Gegevensbescherming (AVG)

De BRP bevragen API is ontworpen conform de REST principes. Om ook aan de AVG te conformeren zijn er concessies gedaan aan het toepassen van de REST principes. De belangrijkste concessie is dat de POST methode en niet de GET methode wordt gebruikt om personen te bevragen. Dit zorgt er voor dat er geen [persoonlijk identificeerbare informatie (PII)](https://piwikpro.nl/blog/pii-niet-pii-en-persoonsgegevens/) terecht komen in de url van een request en daardoor ook niet in server logs.

## Zoeken van personen

Je kunt de volgende zoekoperaties gebruiken om een persoon met niet-uniek identificerende persoonsgegevens te vinden:

- zoek met geslachtsnaam en geboortedatum
  - [overzicht](./features/zoek-met-geslachtsnaam-en-geboortedatum/overzicht.feature)
  - [fout cases](./features/zoek-met-geslachtsnaam-en-geboortedatum/fout-cases.feature)
- zoek met geslachtsnaam, voornamen en gemeente van inschrijving
  - [overzicht](./features/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./features/zoek-met-geslachtsnaam-voornamen-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met postcode en huisnummer
  - [overzicht](./features/zoek-met-postcode-en-huisnummer/overzicht.feature)
  - [fout cases](./features/zoek-met-postcode-en-huisnummer/fout-cases.feature)
- zoek met straat, huisnummer en gemeente van inschrijving
  - [overzicht](./features/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/overzicht.feature)
  - [fout cases](./features/zoek-met-straatnaam-huisnummer-en-gemeente-van-inschrijving/fout-cases.feature)
- zoek met nummeraanduiding identificatie
  - [overzicht](./features/zoek-met-nummeraanduiding-identificatie/overzicht.feature)
  - [fout cases](./features/zoek-met-nummeraanduiding-identificatie/fout-cases.feature)
- zoek met adresseerbaar object identificatie

Het resultaat van de zoek operaties is een lijst van personen die voldoen aan de opgegeven parameters. Bij de "zoek met adresseerbaar object identificatie" operatie kunnen van de gevonden personen ook de gezagsrelaties worden gevraagd.

### Vinden van overleden personen
Standaard worden alleen personen gevonden die in leven zijn. Om ook overleden personen te kunnen vinden, moet de inclusiefOverleden parameter met waarde true worden opgegeven.
Voor overleden personen wordt altijd het opschortingBijhouding veld geleverd met reden code 'O' en omschrijving 'overlijden'. Zie de [overlijden overzicht](./features/persoon-beperkt/overlijden/overzicht.feature) feature voor meer informatie over dit veld.

## Raadplegen van personen

Als het burgerservicenummer van de te bevragen personen bekend is, kan de volgende operatie worden gebruikt om gegevens van de persoon te raadplegen:

- raadpleeg met burgerservicenummer
  - [overzicht](./features/raadpleeg-met-burgerservicenummer/overzicht.feature)
  - [fout cases](./features/raadpleeg-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operatie is een lijst van personen van wie het burgerservicenummer overeenkomen met de opgegeven burgerservicenummers.

### Raadplegen van overleden personen
De "raadpleeg met burgerservicenummer" operatie levert de personen van wie het burgerservicenummer overeenkomt met de opgegeven burgerservicenummers. Dit kunnen ook personen zijn die zijn overleden.
Voor overleden personen wordt altijd het opschortingBijhouding veld geleverd met reden code 'O' en omschrijving 'overlijden'.  Zie de [overlijden overzicht](./features/persoon/overlijden/overzicht.feature) feature voor meer informatie over dit veld.

## Filteren van de velden van de gevonden personen

Elke bevraging moet verplicht een fields parameter bevatten om aan te geven welke velden van de gevonden persoon/personen geleverd moet worden. Om de privacy van de gevraagde personen te beschermen mag een afnemer uitsluitend die velden vragen waarvoor hij doelbinding heeft en wat op dat moment nodig is voor de uit te voeren taak.
Bijkomend voordeel van deze data minimalisatie is dat er ook wordt bijgedragen aan verduurzaming. Hoe minder velden er worden gevraagd, hoe minder de server en het netwerk worden belast.

Een veld wordt gevraagd door het volledige pad van het betreffende veld op te geven in de fields parameter. Het volledige pad van een veld is de samenvoeging van de naam van het veld en de namen van zijn 'ouder' velden met een '.' karakter tussen de veld namen. Voorbeelden van volledige paden zijn:

- geboorte.datum (volledig pad van het geboortedatum veld van een persoon)
- kinderen.naam.voornamen (volledig pad van het voornamen veld van de kinderen van een persoon)

Zie de [fields](./features/fields.feature) en de [fields fout cases](./features/fields-fout-cases.feature) feature bestanden voor meer informatie en voorbeelden van het gebruik van veldpaden en de fields parameter. 

Het [fields-filtered-PersoonBeperkt.csv]({{ site.persoonBeperktFieldsCsvUrl }}){:target="_blank" rel="noopener"} bestand bevat een overzicht van de toegestane fields waarden voor de Zoek personen operaties. Voor de Raadpleeg persoon operatie is de overzicht van toegestane fields waarden te vinden in het [fields-filtered-Persoon.csv]({{ site.persoonFieldsCsvUrl }}){:target="_blank" rel="noopener"} bestand.

Wil je dit snel en foutloos doen? Stel dan je fields eenvoudig samen met de [fields tool](./fields){:target="_blank" rel="noopener"}.

### Filteren van datum en waardetabel velden

De {{ site.apiname }} Web API kent de volgende datum types:

- VolledigeDatum
- DatumOnbekend
- JaarDatum
- JaarMaandDatum

en de volgende waardetabel types:

- Waardetabel
- AdellijkeTitelPredicaatType

Bij het vragen van één of meerdere velden van deze types worden altijd alle velden van het gevraagde type geleverd. In het [fields](./features/fields.feature) feature bestand vind je voorbeelden hiervan onder de volgende rules:

- [Regel: Het vragen van één of meerdere velden van een 'waardetabel' veld levert alle velden van de 'waardetabel' veld](./features/fields.feature#rule-het-vragen-van-één-of-meerdere-velden-van-een-waardetabel-veld-levert-alle-velden-van-de-waardetabel-veld)
- [Regel: Het vragen van één of meerdere velden van een 'datum' veld levert alle velden van de 'datum' veld](./features/fields.feature#rule-het-vragen-van-één-of-meerdere-velden-van-een-datum-veld-levert-alle-velden-van-de-datum-veld)

### Standaard geleverde velden

De volgende velden worden indien van toepassing automatisch geleverd:

- geheimhoudingPersoonsgegevens
- inOnderzoek
- opschortingBijhouding
- rni
- verificatie
- indicatieVastgesteldVerblijftNietOpAdres

Automatisch geleverde velden mogen niet worden gevraagd met de fields parameter.

### Filteren van verblijfplaats velden

Voor verblijfplaats zijn er twee autorisatie profielen:

- geautoriseerd voor zowel verblijfplaats binnenland (Adres en Locatie) en verblijfplaats buitenland gegevens
- geautoriseerd voor alleen verblijfplaats binnenland (Adres en Locatie) gegevens

Afnemers die geautoriseerd zijn voor alleen verblijfplaats binnenland gegevens kunnen hierdoor de standaard veld paden van verblijfplaats niet gebruiken om alleen verblijfplaats binnenland velden te vragen. Met deze veld paden worden namelijk zowel verblijfplaats binnenland als verblijfplaats buitenland gevraagd.

Afnemers die niet geautoriseerd zijn voor verblijfplaats buitenland gegevens moeten daarom de __verblijfplaatsBinnenland__ fields alias gebruiken om aan te geven dat alleen verblijfplaats binnenland gegevens wordt gevraagd.

Het gebruik van de __verblijfplaatsBinnenland__ fields alias is beschreven in de volgende feature bestanden:

- [verblijfplaats fields alias](./features/persoon/verblijfplaats/fields-alias.feature)
- [verblijfplaats fields alias fout cases](./features/persoon/verblijfplaats/fields-alias-fout-cases.feature)

### Filteren van adresregels velden

De adresregelvelden van een persoon worden samengesteld uit de verblijfplaatsvelden van een persoon. Om de adresregelvelden te kunnen vragen moet de afnemer minimaal geautoriseerd zijn voor de verblijfplaatsvelden waarmee de adresregelvelden worden samengesteld.

Dit betekent dat de twee autorisatieprofielen van verblijfplaats ook gelden voor het vragen van adresregelvelden. Afnemers die niet geautoriseerd zijn voor het vragen van adresregels van een verblijfplaats buitenland moeten daarom de __adresseringBinnenland__ fields alias gebruiken om aan te geven dat alleen adresregels voor verblijfplaats binnenland worden gevraagd.

Het gebruik van de __adresseringBinnenland__ fields alias is beschreven in de volgende feature bestanden:

- [adresregels fields alias](./features/persoon/adressering/adres-regels/fields-alias.feature)
- [adresregels fields alias fout cases](./features/persoon/adressering/adres-regels/fields-alias-fout-cases.feature)

### Filteren van partner velden

Bij het vragen van de partners van een persoon worden de gevraagde gegevens van actuele partners (= niet ontbonden huwelijk/geregistreerd partnerschap) geleverd. Heeft de persoon alleen ontbonden huwelijk/geregistreerd partnerschappen, dan worden alleen de gevraagde gegevens van het meest recente ontbonden huwelijk/geregistreerd partnerschap geleverd.

In het volgende feature bestand zijn de bovenstaande regels geïllustreerd aan de hand van scenario's/voorbeelden:

- [partnervelden vragen met fields](./features/persoon/partner/overzicht.feature)

### Filteren van nationaliteitvelden

De {{ site.apiname }} Web API kent de volgende nationaliteit types:

- Nationaliteit
- Staatloos
- BehandeldAlsNederlander
- VastgesteldNietNederlander
- Onbekend

Er wordt alleen gegevens van actuele (= niet beëindigde) nationaliteiten geleverd.

In het volgend feature bestand zijn de bovenstaande regels geïllustreerd aan de hand van scenario's/voorbeelden:

- [nationaliteitvelden vragen met fields](./features/persoon/nationaliteit/overzicht.feature)

### Filteren van verblijfstitelvelden

Wanneer velden van de verblijfstitel wordt gevraagd, dan worden de gevraagde gegevens geleverd als de verblijfstitel niet is beëindigd. Gegevens van een verblijfstitel worden ook niet geleverd als de aanduiding gelijk is aan 'geen verblijfstitel (meer)'.

In het volgende feature bestand zijn de bovenstaande regels geïllustreerd aan de hand van scenario's/voorbeelden:

- [verblijfstitelvelden vragen met fields](./features/persoon/verblijfstitel/overzicht.feature)

## Vragen om gezag over een minderjarige

Je kan om het gezag over een minderjarige vragen met fields "gezag". Je kan hier niet vragen om alleen specifieke velden binnen gezag, zoals "gezag.minderjarige", je krijgt bij gezag alles of niets.

Gezag kan alleen gevraagd worden bij de zoekoperaties RaadpleegMetBurgerservicenummer en ZoekMetAdresseerbaarObjectIdentificatie. Gezag vragen met ZoekMetAdresseerbaarObjectIdentificatie kan gebruikt worden om de gezagsrelaties van alle bewoners van een adres (verblijfsobject) te krijgen.

Je kan gezag vragen van een minderjarige. Dan krijg je als antwoord wie er gezag heeft over deze minderjarige. Bijvoorbeeld de ouders van deze minderjarige.

Je kan ook gezag vragen van een meerderjarige. Dan krijg je als antwoord over wie deze meerderjarige gezag heeft. Bijvoorbeeld over de kinderen van deze meerderjarige. Je krijgt dan alleen informatie over het gezag dat deze persoon wel heeft. Er wordt geen informatie geleverd over kinderen van de persoon waar deze geen gezag (meer) over heeft.

Gezag geeft in de API een lijst. Hierin kunnen 0, 1 of meerdere gezagvoorkomens geleverd worden.

Wanneer je het gezag vraagt van een minderjarige heeft het antwoord altijd exact 1 item gezag, tenzij de minderjarige is overleden. Dan wordt geen informatie over gezag geleverd.

Wanneer je het gezag vraagt van een meerderjarige kan het antwoord 0 (de persoon heeft over niemand gezag), 1 of meerdere items krijgen. Bijvoorbeeld wanneer de persoon gezag heeft over meerdere kinderen. Elk gezagvoorkomen (elk item in de lijst gezag) geeft dan het gezag over één minderjarige.

Elk geleverd gezag kan één van de volgende types zijn:
- TweehoofdigOuderlijkGezag
- EenhoofdigOuderlijkGezag
- GezamenlijkGezag
- Voogdij
- TijdelijkGeenGezag
- GezagNietTeBepalen

### TweehoofdigOuderlijkGezag

Dit type gezag betekent dat beide juridische ouders het gezag hebben over de minderjarige. Het gezag bevat TweehoofdigOuderlijkGezag de burgerservicenummers van de minderjarige en van beide ouders.

Bijvoorbeeld
```
  "gezag": [
    {
      "type": "TweehoofdigOuderlijkGezag",
      "ouders": [
        {
          "burgerservicenummer": "999999357"
        },
        {
          "burgerservicenummer": "999999345"
        }
      ],
      "minderjarige": {
          "burgerservicenummer": "999999412"
      }
    }
  ]
```

### EenhoofdigOuderlijkGezag

Dit type gezag betekent dat één juridische ouder het gezag heeft over de minderjarige. Dit kan voorkomen wanneer er maar één ouder is, maar ook wanneer alleen één van beide ouders het gezag heeft. Het gezag bevat bij EenhoofdigOuderlijkGezag de burgerservicenummers van de minderjarige en van de ouder die het gezag heeft.

Bijvoorbeeld
```
  "gezag": [
    {
      "type": "EenhoofdigOuderlijkGezag",
      "ouder": {
        "burgerservicenummer": "999970124"
      },
      "minderjarige": {
        "burgerservicenummer": "999970185"
      }
    }
  ]
```

### GezamenlijkGezag

Dit type gezag betekent dat de juridische ouder en iemand anders - geen ouder - het gezag hebben over de minderjarige. 

Dit kan voorkomen wanneer de ouder en diens (ex) partner het gezag hebben. Het gezag bevat in dit geval de burgerservicenummers van de minderjarige, van de ouder en van de (ex)partner die het gezag hebben. De niet-ouder (partner) met gezag wordt een "derde" genoemd.

Dit type gezag kan ook voorkomen wanneer er een gerechtelijke uitspraak over is gedaan, waarbij het gezag aan de ouder en iemand anders is toegewezen. In dat geval weten we niet wie die andere persoon of instelling is die het gezag heeft. Het gezag bevat in dit geval de burgerservicenummers van de minderjarige en van de ouder die het gezag heeft.

Bijvoorbeeld bij gezamenlijk gezag van de ouder en diens partner
```
  "gezag": [
    {
      "type": "GezamenlijkGezag",
      "ouder": {
        "burgerservicenummer": "999970124"
      },
      "derde": {
        "burgerservicenummer": "999970136"
      },
      "minderjarige": {
        "burgerservicenummer": "999970161"
      }
    }
  ]
```

### Voogdij

Dit type gezag betekent dat een niet-ouder het gezag heeft over de minderjarige. Dit kan voorkomen wanneer er een gerechtelijke uitspraak is gedaan over het gezag. In dat geval weten we niet wie het gezag heeft. Dat kan een voogdijinstelling zijn of een of meerdere personen.

Voogdij kan ook voorkomen wanneer de ouder is overleden of onbevoegd is tot gezag. De (ex)partner van de ouder krijgt dan (onder bepaalde condities) van rechtswege het gezag. De niet-ouder (partner) met gezag wordt dan geleverd als "derde".

Bijvoorbeeld bij voogdij na gerechtelijke uitspraak
```
  "gezag": [
    {
      "type": "Voogdij",
      "derden": [],
      "minderjarige": {
        "burgerservicenummer": "999999515"
      }
    }
  ]
```

Bijvoorbeeld bij voogdij van rechtswege voor de (ex)partner
```
  "gezag": [
    {
      "type": "Voogdij",
      "derden": [
        {
          "burgerservicenummer": "999970203"
        }
      ],
      "minderjarige": {
        "burgerservicenummer": "999970215"
      }
    }
  ]
```

### TijdelijkGeenGezag

Dit type gezag betekent dat op dit moment niemand het gezag heeft over de minderjarige. Dit moet een zeer tijdelijke situatie zijn. Bijvoorbeeld direct na het overlijden van ouder zolang er nog geen voogdij is aangewezen. Het gezag bevat in dit geval het burgerservicenummer van de minderjarige.

Bijvoorbeeld
```
  "gezag": [
    {
      "type": "TijdelijkGeenGezag",
      "minderjarige": {
        "burgerservicenummer": "999970227"
      }
    }
  ]
```

### GezagNietTeBepalen

Dit type gezag betekent dat de API niet met zekerheid kan bepalen wie het gezag heeft over de minderjarige. Dit kan om veel verschillende redenen het geval zijn. Het gezag bevat in dit geval het burgerservicenummer van de minderjarige en een toelichting van de reden dat het gezag niet te bepalen is.

Bijvoorbeeld
```
  "gezag": [
    {
      "type": "GezagNietTeBepalen",
      "minderjarige": {
        "burgerservicenummer": "999995273"
      },
      "toelichting": "gezag is niet te bepalen omdat minderjarige in het buitenland is geboren."
    }
  ]
```

## Eén of meer gevraagde velden zijn in onderzoek

Om een afnemer te informeren dat één of meer gevraagde velden in onderzoek zijn, worden de bijbehorende inOnderzoek en datumIngangOnderzoek velden ook geleverd.
Wanneer één of meer velden waaruit een andere veld wordt afgeleid (bijv. de adressering velden) in onderzoek zijn, dan is het afgeleide veld ook in onderzoek en wordt het inOnderzoekveld van het afgeleide veld ook geleverd.
In het [in onderzoek](./features/in-onderzoek.feature) featurebestand zijn de regels beschreven wanneer de inOnderzoekvelden wel/niet worden geleverd.

### Vastgesteld verblijft niet op adres

Wanneer tijdens onderzoek is vastgesteld dat een persoon niet meer verblijft op het geregistreerde adres en verblijfplaatsgegevens en/of adresregels van de betreffende persoon worden gevraagd, dan wordt het **indicatieVastgesteldVerblijftNietOpAdres** veld met waarde true meegeleverd.

De functionaliteit van het **indicatieVastgesteldVerblijftNietOpAdres** veld is beschreven in de volgende feature bestanden:
- [vastgesteld verblijft niet op adres (verblijfplaats binnenland)](./features/persoon/verblijfplaats/adres/vastgesteld-verblijft-niet-op-adres.feature)
- [vastgesteld verblijft niet op adres (locatie)](./features/persoon/verblijfplaats/locatie/vastgesteld-verblijft-niet-op-adres.feature)
- [vastgesteld verblijft niet op adres (adresregels vragen bij personen raadplegen)](./features/persoon/adressering/adres-regels/vastgesteld-verblijft-niet-op-adres.feature)
- [vastgesteld verblijft niet op adres (adresregels vragen bij personen zoeken)](./features/persoon-beperkt/adressering/adres-regels/vastgesteld-verblijft-niet-op-adres.feature)

## Geen/null/false waarde, leeg object waarde en standaard waarde

Om de payload van een response klein te houden, is er voor gekozen om velden met de volgende waarden niet te leveren in de response:

- niet gevraagde velden. Deze velden hebben _null_ als waarde.
- gevraagde velden die de gevraagde persoon niet heeft. Deze velden hebben _null_ als waarde. Voorbeeld: naam.voorvoegsel veld wordt gevraagd voor een persoon die geen voorvoegsel in zijn naam heeft.
- gevraagde velden hebben de _false_ waarde. Voorbeeld: indicatieCurateleRegister veld wordt gevraagd voor een persoon die niet onder curatele is gesteld.
- gevraagde velden is een groep velden die de persoon niet heeft. Voorbeeld: verblijfstitel velden wordt gevraagd voor een persoon die geen verblijfstitel heeft
- gevraagde velden heeft de __standaard__ waarde. In de BRP wordt de standaard waarde gebruikt om aan te geven dat een gegeven onbekend is. Voorbeeld: geboorte.plaats veld wordt gevraagd voor een persoon waarvan de geboorteplaats onbekend is
- gevraagde velden hebben geen aanduiding "in onderzoek".
