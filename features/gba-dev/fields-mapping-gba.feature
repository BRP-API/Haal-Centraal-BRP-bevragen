#language: nl

@gba
Functionaliteit: Fields vertalen van proxy naar gba
  In de fields parameter worden velden gebruikt zoals die aan de eindgebruiker worden geleverd.

  Sommige velden zijn afgeleid uit één of meerdere velden in de GbaPersoon. De GbaPersoon moet alle velden leveren die nodig zijn om de gevraagde velden te bepalen.

  Rule: Wanneer een veld in verblijfplaats is gevraagd, moeten ook alle velden worden geleverd om het type van de verblijfplaats te bepalen
    Zie verblijfplaats.feature voor de regels om verblijfplaats.type te bepalen.
    Dit betreft de volgende velden van verblijfplaats:
    - straat
    - naamOpenbareRuimte
    - huisnummer
    - huisletter
    - huisnummertoevoeging
    - aanduidingBijHuisnummer
    - woonplaats
    - adresseerbaarObjectIdentificatie
    - nummeraanduidingIdentificatie
    - locatiebeschrijving
    - verblijfplaats.land
    - verblijfplaats.regel1
    - verblijfplaats.regel2
    - verblijfplaats.regel3

    @gba
    Scenario: verblijfplaats binnenlands adres
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | functieAdres (10.10)                       | W                          |
      | datum aanvang adreshouding (10.30)         | 20170423                   |
      | straatnaam (11.10)                         | Jonkheer van Riemsdijkln   |
      | naam openbare ruimte (11.15)               | Jonkheer van Riemsdijklaan |
      | huisnummer (11.20)                         | 88                         |
      | huisletter (11.30)                         | a                          |
      | huisnummertoevoeging (11.40)               | 2                          |
      | aanduiding bij huisnummer (11.50)          | to                         |
      | postcode (11.60)                           | 2497BV                     |
      | woonplaatsnaam (11.70)                     | 's-Gravenhage              |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579           |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                     |
      | functieAdres                     | W                          |
      | straat                           | Jonkheer van Riemsdijkln   |
      | naamOpenbareRuimte               | Jonkheer van Riemsdijklaan |
      | huisnummer                       | 88                         |
      | huisletter                       | a                          |
      | huisnummertoevoeging             | 2                          |
      | aanduiding bij huisnummer        | to                         |
      | postcode                         | 2497BV                     |
      | woonplaat                        | 's-Gravenhage              |
      | adresseerbaarObjectIdentificatie | 0599010000208579           |
      | nummeraanduidingIdentificatie    | 0599200000219678           |

    @gba
    Scenario: verblijfplaats binnenlandse locatie
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde                     |
      | functieAdres (10.10)               | W                          |
      | datum aanvang adreshouding (10.30) | 20170423                   |
      | locatiebeschrijving (12.10)        | Woonboot in de Grote Sloot |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                | waarde                     |
      | functieAdres        | W                          |
      | locatiebeschrijving | Woonboot in de Grote Sloot |

    @gba
    Scenario: verblijfplaats buitenland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde          |
      | datum aanvang adres buitenland (13.20) | 20191104        |
      | land adres buitenland (13.10)          | 5107            |
      | regel 1 adres buitenland (13.30)       | z/n Bapor Kibrá |
      | regel 2 adres buitenland (13.40)       | 1000            |
      | regel 3 adres buitenland (13.50)       | Willemstad      |
      En landelijke tabel "Landen" heeft de volgende waarde
      | code | omschrijving |
      | 5107 | Curaçao      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam              | waarde          |
      | land.code         | 5107            |
      | land.omschrijving | Curaçao         |
      | regel1            | z/n Bapor Kibrá |
      | regel2            | 1000            |
      | regel3            | Willemstad      |


  Rule: Voor sommige gevraagde velden in fields moeten (aanvullend) andere velden worden geleverd
    De vertaling van in fields gevraagde veld(paden) en in GbaPersoon te leveren velden staat in fields-mapping-proxy-gba.csv.
    Het in fields gevraagde pad staat in kolom "volledig pad". De bijbehorende waarde in kolom "gba pad" beschrijft de waarde van te leveren velden in GbaPersoon.
    Wanneer 1 veld in fields meer dan 1 veld in GbaPersoon vraagt, staan de verschillende GbaPersoon paden gescheiden met een |.

    Abstract Scenario: <fields> is gevraagd van persoon met ex-partner
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                 | waarde    |
      | burgerservicenummer                  | 555550001 |
      | geslachtsaanduiding (04.10)          | M         |
      | voornamen (02.10)                    | Jan Peter |
      | adellijke titel of predicaat (02.20) | JH        |
      | voorvoegsel (02.30)                  | te        |
      | geslachtsnaam (02.40)                | Hoogh     |
      | aanduiding naamgebruik (61.10)       | E         |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                                         | waarde         |
      | voornamen (02.10)                                            | Anna Catharina |
      | adellijke titel of predicaat (02.20)                         | BS             |
      | voorvoegsel (02.30)                                          | van den        |
      | geslachtsnaam (02.40)                                        | Aedel          |
      | datum ontbinding huwelijk/geregistreerd partnerschap (07.10) | 20211109       |
      En landelijke tabel "Adellijke_Titel_Predicaat" heeft de volgende waarde
      | code | omschrijving | soort     |
      | JH   | Jonkheer     | predicaat |
      | BS   | Barones      | titel     |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      En heeft de persoon de volgende 'naam' gegevens
      | naam                                 | waarde              |
      | voornamen                            | Jan Peter           |
      | adellijkeTitelPredicaat.code         | JH                  |
      | adellijkeTitelPredicaat.omschrijving | Jonkheer            |
      | adellijkeTitelPredicaat.soort        | predicaat           |
      | voorvoegsel                          | te                  |
      | geslachtsnaam                        | Hoogh               |
      | aanduidingNaamgebruik.code           | E                   |
      | aanduidingNaamgebruik.omschrijving   | eigen geslachtsnaam |
      En heeft de response een persoon met een 'partner' met de volgende 'naam' gegevens
      | naam                                 | waarde  |
      | adellijkeTitelPredicaat.code         | BS      |
      | adellijkeTitelPredicaat.omschrijving | Barones |
      | adellijkeTitelPredicaat.soort        | titel   |
      | voorvoegsel                          | van den |
      | geslachtsnaam                        | Aedel   |
      En heeft de 'partner' de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20211109 |

      Voorbeelden:
      | fields                            |
      | adressering.aanhef                |
      | aanhef                            |
      | adressering.aanschrijfwijze.naam  |
      | aanschrijfwijze.naam              |
      | adressering.aanschrijfwijze       |
      | aanschrijfwijze                   |
      | adressering.gebruikInLopendeTekst |
      | gebruikInLopendeTekst             |
      | aanhef,aanschrijfwijze            |

    @gba
    Scenario: datumVan vragen moet datumAanvangAdreshouding plus wat nodig is voor type leveren
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | functieAdres (10.10)                       | W                          |
      | datum aanvang adreshouding (10.30)         | 20170423                   |
      | straatnaam (11.10)                         | Jonkheer van Riemsdijkln   |
      | naam openbare ruimte (11.15)               | Jonkheer van Riemsdijklaan |
      | huisnummer (11.20)                         | 88                         |
      | huisletter (11.30)                         | a                          |
      | huisnummertoevoeging (11.40)               | 2                          |
      | aanduiding bij huisnummer (11.50)          | to                         |
      | postcode (11.60)                           | 2497BV                     |
      | woonplaatsnaam (11.70)                     | 's-Gravenhage              |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579           |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                     |
      | datumAanvangAdreshouding         | 20170423                   |
      | straat                           | Jonkheer van Riemsdijkln   |
      | naamOpenbareRuimte               | Jonkheer van Riemsdijklaan |
      | huisnummer                       | 88                         |
      | huisletter                       | a                          |
      | huisnummertoevoeging             | 2                          |
      | aanduiding bij huisnummer        | to                         |
      | postcode                         | 2497BV                     |
      | woonplaat                        | 's-Gravenhage              |
      | adresseerbaarObjectIdentificatie | 0599010000208579           |
      | nummeraanduidingIdentificatie    | 0599200000219678           |
