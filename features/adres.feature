# language: nl

@post-assert
Functionaliteit: Adresvelden vullen


  Rule: Voor een binnenlands adres wordt adresregel1 samengesteld conform NEN 5825:2002
    - Veld adresregel1 wordt samengesteld uit straatnaam + aanduidingBijHuisnummer + huisnummer + huisletter + huisnummertoevoeging
    - De aanduidingBijHuisnummer (11.50) waarde "to" (tegenover) wordt in "adresregel1" opgenomen als "t/o", waarde "by" wordt in "adresregel1" opgenomen als "bij"
    - Tussen straatnaam en aanduidingBijHuisnummer of huisnummer wordt een spatie opgenomen
    - Tussen aanduidingBijHuisnummer en huisnummer wordt een spatie opgenomen
    - Tussen het huisnummer en de huisnummertoevoeging (wat in de NEN een samenstelling is van huisletter en huisnummertoevoeging, niet gescheiden van elkaar) moet een koppelteken ("-") worden geplaatst indien de huisnummertoevoeging met een cijfer begint, een spatie in alle andere gevallen

    Abstract Scenario: adresregel1 voor een binnenlands adres met <omschrijving>
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                  | waarde     |
      | functie adres (10.10) | W          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde                      |
      | straatnaam (11.10)                | <straatnaam>                |
      | naam openbare ruimte (11.15)      | <naam openbare ruimte>      |
      | huisnummer (11.20)                | <huisnummer>                |
      | huisletter (11.30)                | <huisletter>                |
      | huisnummertoevoeging (11.40)      | <huinummertoevoeging>       |
      | aanduiding bij huisnummer (11.50) | <aanduiding bij huisnummer> |
      | postcode (11.60)                  | 2497BV                      |
      | gemeente_code                     | 0518                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | adressering        |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde        |
      | adresregel1 | <adresregel1> |

      Voorbeelden:
      | omschrijving                                         | burgerservicenummer | straatnaam               | naam openbare ruimte       | huisnummer | huisletter | huinummertoevoeging | aanduiding bij huisnummer | adresregel1                  |
      | naam openbare ruimte langer dan straatnaam           | 000000188           | Jonkheer van Riemsdijkln | Jonkheer van Riemsdijklaan | 88         |            |                     |                           | Jonkheer van Riemsdijkln 88  |
      | huisletter en geen huisnummertoevoeging              | 000000206           | Borgesiusstraat          |                            | 103        | c          |                     |                           | Borgesiusstraat 103 c        |
      | huisnummertoevoeging die begint met een letter       | 000000218           | Daniël Stalpertstraat    |                            | 35         |            | III                 |                           | Daniël Stalpertstraat 35 III |
      | huisnummertoevoeging die begint met een cijfer       | 000000231           | Atatürkstraat            | Atatürkstraat              | 9          |            | 2                   |                           | Atatürkstraat 9-2            |
      | huisletter en huisnummertoevoeging begint met letter | 000000243           | St. Jacobsstraat         | St. Jacobsstraat           | 400        | L          | Toe                 |                           | St. Jacobsstraat 400 LToe    |
      | huisletter en huisnummertoevoeging begint met cijfer | 000000255           | Cronus                   |                            | 555        | B          | 73c                 |                           | Cronus 555 B73c              |
      | aanduiding bij huisnummer bij                        | 000000267           | Graan voor Visch         |                            | 15201      |            |                     | by                        | Graan voor Visch bij 15201   |
      | aanduiding bij huisnummer tegenover                  | 000000279           | 1e Exloërmond            | 1e Exloërmond              | 3          |            |                     | to                        | 1e Exloërmond t/o 3          |

  Rule: Voor een binnenlandse locatie wordt adresregel1 gevuld met de locatiebeschrijving

    Scenario: adresregel1 voor locatie
    Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
      | naam                  | waarde     |
      | functie adres (10.10) | W          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                            |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      | gemeente_code               | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000309                       |
      | fields              | adressering.adresregel1         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde                     |
      | adresregel1 | Woonboot tegenover de Grote Sloot |

  Rule: Voor een binnenlands adres of locatie wordt adresregel2 samengesteld conform NEN 5825:2002.
    - Veld adresregel2 wordt samengesteld uit postcode + woonplaats
    - Tussen postcode numeriek deel en postcode alfabetisch deel wordt een spatie geplaatst
    - Tussen postcode alfabetisch deel en woonplaatsnaam worden twee spaties geplaatst
    - De woonplaatsnaam wordt in hoofdletters geschreven
    - Wanneer de woonplaats geen waarde heeft, wordt de omschrijving van de gemeente van inschrijving als woonplaats gebruikt

    Abstract Scenario: adresregel2 voor een binnenlandse verblijfplaats <omschrijving>
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde                |
      | gemeente van inschrijving (09.10)    | 0518                  |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                   | waarde           |
      | straatnaam (11.10)     | een straat       |
      | huisnummer (11.20)     | 1                |
      | postcode (11.60)       | <postcode>       |
      | woonplaats (11.70)     | <woonplaatsnaam> |
      | gemeente_code          | 0518             |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | adressering.adresregel2         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde        |
      | adresregel2 | <adresregel2> |

      Voorbeelden:
      | omschrijving                               | burgerservicenummer | woonplaatsnaam | postcode | adresregel2            |
      | met woonplaatsnaam anders dan gemeentenaam | 000000310           | Scheveningen   | 2583XL   | 2583 XL  SCHEVENINGEN  |
      | zonder woonplaatsnaam                      | 000000322           |                | 2584BZ   | 2584 BZ  'S-GRAVENHAGE |

    Scenario: adresregel2 voor locatie
    Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde        |
      | gemeente van inschrijving (09.10)    | 0518          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                     |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      | gemeente_code               | 0518                              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000334                       |
      | fields              | adressering.adresregel2         |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam        | waarde        |
      | adresregel2 | 'S-GRAVENHAGE |

  Rule: Voor een buitenlands adres worden de adresregels en land gevuld uit de gegevens over verblijf buitenland (groep 13)

    Scenario: persoon verblijft in het buitenland
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde          |
      | gemeente van inschrijving (09.10) | 1999            |
      | land (13.10)                      | 5010            |
      | regel 1 adres buitenland (13.30)  | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40)  | Bruxelles       |
      | regel 3 adres buitenland (13.50)  | postcode 1000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000346                                                                                |
      | fields              | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
      | naam              | waarde          |
      | adresregel1       | Rue du pomme 25 |
      | adresregel2       | Bruxelles       |
      | adresregel3       | postcode 1000   |
      | land.code         | 5010            |
      | land.omschrijving | België          |

  Rule: Voor een buitenlands adres worden de adresregels en land in de adressering alleen opgenomen wanneer ten minste land en één van de regels adres buitenland een waarde hebben
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Scenario: land is onbekend
    Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                 |
      | gemeente van inschrijving (09.10)      | 1999                   |
      | land (13.10)                           | 0000                   |
      | datum aanvang adres buitenland (13.20) | 20191104               |
      | regel 2 adres buitenland (13.40)       | Pietermaai 19, Curaçao |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000346                                                                                |
      | fields              | burgerservicenummer,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000346 |
      En heeft de persoon een leeg 'adressering' object
      # personen: [{ adressering: {} }]

    Scenario: alleen land is bekend
    Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | gemeente van inschrijving (09.10)      | 1999     |
      | land (13.10)                           | 5107     |
      | datum aanvang adres buitenland (13.20) | 20191104 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | 000000358                                                                                |
      | fields              | burgerservicenummer,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 000000358 |
      En heeft de persoon een leeg 'adressering' object
      # personen: [{ adressering: {} }]

  Rule: Voor een binnenlands adres worden de adresregels in de adressering alleen opgenomen wanneer ten minste straatnaam (11.10) en huisnummer (11.20) een waarde hebben
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Abstract Scenario: adresregels worden niet opgenomen omdat <omschrijving>
    Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                  | waarde     |
      | functie adres (10.10) | W          |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam               | waarde       |
      | straatnaam (11.10) | <straatnaam> |
      | huisnummer (11.20) | <huisnummer> |
      | postcode (11.60)   | <postcode>   |
      |gemeente_code       | 0518         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                                                   |
      | type                | RaadpleegMetBurgerservicenummer                                                          |
      | burgerservicenummer | <burgerservicenummer>                                                                    |
      | fields              | burgerservicenummer,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft de persoon een leeg 'adressering' object
      # personen: [{ adressering: {} }]

      Voorbeelden:
      | omschrijving                     | burgerservicenummer | straatnaam               | huisnummer | postcode |
      | straatnaam is leeg               | 000000401           |                          | 88         | 2497BV   |
      | straatnaam heeft standaardwaarde | 000000413           | .                        | 88         | 2497BV   |
      | huisnummer heeft standaardwaarde | 000000425           | Jonkheer van Riemsdijkln | 0          | 2497BV   |
