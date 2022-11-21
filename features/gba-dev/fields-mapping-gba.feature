#language: nl

Functionaliteit: Fields vertalen van proxy naar gba
  In de fields parameter worden velden gebruikt zoals die aan de eindgebruiker worden geleverd.

  Sommige velden zijn afgeleid uit één of meerdere velden in de GbaPersoon. De GbaPersoon moet alle velden leveren die nodig zijn om de gevraagde velden te bepalen.

  Achtergrond:

    Gegeven landelijke tabel "Landen" heeft de volgende waarden
    | code | omschrijving         |
    | 5077 | Wallis en Futuna     |
    | 5084 | Mayotte              |
    | 5109 | Sint Eustatius       |
    | 6059 | São Tomé en Principe |

    Gegeven landelijke tabel "Functie_adres" heeft de volgende waarden
    # Functie_adres is geen landelijke tabel maar een lijst mogelijke waarden uit het LO-gba
    # De automation-code ondersteunt nu de step "Gegeven tabel "Functie_Adres" heeft de volgende waarden" nog niet.
    | code | omschrijving |
    | B    | briefadres   |
    | W    | woonadres    |

    Gegeven landelijke tabel "Gemeenten" heeft de volgende waarden
    | code | omschrijving                   |
    | 0518 | 's-Gravenhage                  |

    Gegeven landelijke tabel "Landen" heeft de volgende waarden
    | code | omschrijving         |
    | 5107 | Curaçao              |

    Gegeven landelijke tabel "Adellijke_Titel_Predicaat" heeft de volgende waarden
    # Adellijke_Titel_Predicaat is geen landelijke tabel maar een lijst mogelijke waarden uit het LO-gba
    # De automation-code ondersteunt nu de step "Gegeven tabel "Adellijke_Titel_Predicaat" heeft de volgende waarden" nog niet.
    | code | omschrijving | soort     |
    | JH   | Jonkheer     | predicaat |
    | BS   | Barones      | titel     |

    Gegeven landelijke tabel "Naamgebruik" heeft de volgende waarden
    # Naamgebruik is geen landelijke tabel maar een lijst mogelijke waarden uit het LO-gba
    # De automation-code ondersteunt nu de step "Gegeven tabel "Naamgebruik" heeft de volgende waarden" nog niet.
    | code | omschrijving        |
    | E    | eigen geslachtsnaam |

    Gegeven landelijke tabel "Geslacht" heeft de volgende waarden
    # Geslacht is geen landelijke tabel maar een lijst mogelijke waarden uit het LO-gba
    # De automation-code ondersteunt nu de step "Gegeven tabel "Geslacht" heeft de volgende waarden" nog niet.
    | code | omschrijving        |
    | M    | man                 |

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

    Scenario: verblijfplaats binnenlands adres
    Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | functie adres (10.10)                      | W                          |
      | datum aanvang adreshouding (10.30)         | 20170423                   |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                               | waarde                     |
      | woonplaatsnaam (11.70)             | 's-Gravenhage              |
      | straatnaam (11.10)                 | Jonkheer van Riemsdijkln   |
      | gemeente_code                      | 0518                       |
      | naam openbare ruimte (11.15)       | Jonkheer van Riemsdijklaan |
      | huisnummer (11.20)                 | 88                         |
      | huisletter (11.30)                 | a                          |
      | huisnummertoevoeging (11.40)       | 2                          |
      | aanduiding bij huisnummer (11.50)  | to                         |
      | postcode (11.60)                   | 2497BV                     |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579           |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000103                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde                     |
      | functieAdres.code                    | W                          |
      | functieAdres.omschrijving            | woonadres                  |
      | straat                               | Jonkheer van Riemsdijkln   |
      | naamOpenbareRuimte                   | Jonkheer van Riemsdijklaan |
      | huisnummer                           | 88                         |
      | huisletter                           | a                          |
      | huisnummertoevoeging                 | 2                          |
      | aanduidingBijHuisnummer.code         | to                         |
      | aanduidingBijHuisnummer.omschrijving | tegenover                  |
      | postcode                             | 2497BV                     |
      | woonplaats                           | 's-Gravenhage              |
      | adresseerbaarObjectIdentificatie     | 0599010000208579           |
      | nummeraanduidingIdentificatie        | 0599200000219678           |

    Scenario: verblijfplaats binnenlandse locatie
    Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | functie adres (10.10)                      | W                          |
      | datum aanvang adreshouding (10.30)         | 20170423                   |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                               | waarde                     |
      | gemeente_code                      | 0518                       |
      | locatiebeschrijving (12.10)        | Woonboot tegenover de Grote Sloot |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000140                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde                            |
      | functieAdres.code         | W                                 |
      | functieAdres.omschrijving | woonadres                         |
      | locatiebeschrijving       | Woonboot tegenover de Grote Sloot |
      | datumAanvangAdreshouding  | 20170423                          |

    Scenario: verblijfplaats buitenland
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde          |
      | functie adres (10.10)                  | W               |
      | datum aanvang adres buitenland (13.20) | 20191104        |
      | land (13.10)                           | 5107            |
      | regel 1 adres buitenland (13.30)       | z/n Bapor Kibrá |
      | regel 2 adres buitenland (13.40)       | 1000            |
      | regel 3 adres buitenland (13.50)       | Willemstad      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats.functieAdres     |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                      | waarde          |
      | functieAdres.code         | W               |
      | functieAdres.omschrijving | woonadres       |
      | land.code                 | 5107            |
      | land.omschrijving         | Curaçao         |
      | regel1                    | z/n Bapor Kibrá |
      | regel2                    | 1000            |
      | regel3                    | Willemstad      |
      | datumAanvangAdreshouding  | 20191104        |


  Rule: Voor sommige gevraagde velden in fields moeten (aanvullend) andere velden worden geleverd
    De vertaling van in fields gevraagde veld(paden) en in GbaPersoon te leveren velden staat in fields-mapping-proxy-gba.csv.
    Het in fields gevraagde pad staat in kolom "volledig pad". De bijbehorende waarde in kolom "gba pad" beschrijft de waarde van te leveren velden in GbaPersoon.
    Wanneer 1 veld in fields meer dan 1 veld in GbaPersoon vraagt, staan de verschillende GbaPersoon paden gescheiden met een |.

    Abstract Scenario: <fields> is gevraagd van persoon met ex-partner
    Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
      | naam                                 | waarde    |
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
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000164                       |
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

    Scenario: datumVan vragen moet datumAanvangAdreshouding plus wat nodig is voor type leveren
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | functie adres (10.10)                      | W                          |
      | datum aanvang adreshouding (10.30)         | 20170423                   |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                     |
      | straatnaam (11.10)                         | Jonkheer van Riemsdijkln   |
      | naam openbare ruimte (11.15)               | Jonkheer van Riemsdijklaan |
      | huisnummer (11.20)                         | 88                         |
      | huisletter (11.30)                         | a                          |
      | huisnummertoevoeging (11.40)               | 2                          |
      | aanduiding bij huisnummer (11.50)          | to                         |
      | postcode (11.60)                           | 2497BV                     |
      | gemeente_code                              | 0518                       |
      | woonplaatsnaam (11.70)                     | 's-Gravenhage              |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579           |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678           |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
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


      Scenario: Leeftijd wordt gevraagd
        Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende gegevens
        | naam                  | waarde   |
        | geboortedatum (03.10) | 19470425 |
        En de persoon heeft de volgende 'overlijden' gegevens
        | naam                     | waarde   |
        | datum overlijden (08.10) | 20160324 |
        Als gba personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000279                       |
        | fields              | burgerservicenummer,leeftijd    |
        Dan heeft de response een persoon met alleen de volgende gegevens
        | naam                | waarde    |
        | burgerservicenummer | 000000279 |
        | geboorte.datum      | 19470425  |
        | overlijden.datum    | 20160324  |
