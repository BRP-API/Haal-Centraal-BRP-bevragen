# language: nl

@skip-verify
Functionaliteit: Adresvelden vullen
  
  Rule: Voor een binnenlands adres wordt veld "straat" gevuld met de naam openbare ruimte (11.15) wanneer die bekend is, en anders met straatnaam (11.10). Veld "korteNaam" wordt gevuld met straatnaam (11.10).

    Abstract Scenario: opnemen straat bij een binnenlands adres
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | <burgerservicenummer>                |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                         | waarde                 |
      | straatnaam (11.10)           | <straatnaam>           |
      | naam openbare ruimte (11.15) | <naam openbare ruimte> |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                                         |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131           |
      | fields               | verblijfplaats.straat,verblijfplaats.korteNaam |
      Dan bevat de persoon met burgerservicenummer '<burgerservicenummer>' de volgende verblijfplaats gegevens
      | naam      | waarde      |
      | straat    | <straat>    |
      | korteNaam | <korteNaam> |

      Voorbeelden:
      | burgerservicenummer | straatnaam               | naam openbare ruimte                    | straat                                  | korteNaam                |
      | 999995492           | Kappeyne v d Cappellostr | Annelien Kappeyne van de Coppellostraat | Annelien Kappeyne van de Coppellostraat | Kappeyne v d Cappellostr |
      | 999991802           | Zomerdijkstrtaat         |                                         | Zomerdijkstrtaat                        | Zomerdijkstrtaat         |

  Rule: Voor een binnenlands adres wordt veld "woonplaats" gevuld met de woonplaatsnaam (11.70) wanneer die bekend is, en anders met de omschrijving van de gemeente van inschrijving (09.10 via tabel 33 Gemeententabel).

    Abstract Scenario: opnemen woonplaats binnenlands adres
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | <burgerservicenummer>                |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                              | waarde           |
      | gemeente van inschrijving (09.10) | 0518             |
      | woonplaatsnaam (11.70)            | <woonplaatsnaam> |
      En de waardetabel 'Gemeenten' heeft de volgende waarden
      | code | omschrijving  |
      | 0518 | 's-Gravenhage |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                                                           |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131                             |
      | fields               | verblijfplaats.woonplaats,verblijfplaats.gemeenteVanInschrijving |
      Dan bevat de persoon met burgerservicenummer '<burgerservicenummer>' de volgende verblijfplaats gegevens
      | naam                                 | waarde        |
      | gemeenteVanInschrijving.code         | 0518          |
      | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
      | woonplaats                           | <woonplaats>  |

      Voorbeelden:
      | burgerservicenummer | woonplaatsnaam | woonplaats    |
      | 999992922           | Scheveningen   | Scheveningen  |
      | 999990639           |                | 's-Gravenhage |

  Rule: Voor een binnenlands adres wordt adresregel1 samengesteld conform NEN 5825:2002.

    # Veld adresregel1 wordt samengesteld uit locatiebeschrijving + korteNaam + aanduidingBijHuisnummer + huisnummer + huisletter + huisnummertoevoeging
    # De aanduidingBijHuisnummer waarde "tegenover" (11.50="to") wordt in "adresregel1" opgenomen als "t/o", waarde "bij" (11.50="by") wordt in "adresregel1" opgenomen als "bij"
    # Tussen kortenaam en huisnummer wordt een spatie opgenomen
    # Tussen het huisnummer en de huisnummertoevoeging (wat in de NEN een samenstelling is van huisletter en huisnummertoevoeging, niet gecheiden van elkaar) moet een koppelteken ("-") worden geplaatst indien de huisnummertoevoeging met een cijfer begint, een spatie in alle andere gevallen

    Abstract Scenario: adresregel1 voor een binnenlands adres met <omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | <burgerservicenummer>                |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                              | waarde                      |
      | straatnaam (11.10)                | <straatnaam>                |
      | naam openbare ruimte (11.15)      | <naam openbare ruimte>      |
      | huisnummer (11.20)                | <huisnummer>                |
      | huisletter (11.30)                | <huisletter>                |
      | huisnummertoevoeging (11.40)      | <huinummertoevoeging>       |
      | aanduiding bij huisnummer (11.50) | <aanduiding bij huisnummer> |
      | locatiebeschrijving (12.10)       | <locatiebeschrijving>       |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                                                                    |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131                                      |
      | fields               | verblijfplaats.adresregel1,verblijfplaats.adresregel3,verblijfplaats.land |
      Dan bevat de persoon met burgerservicenummer '<burgerservicenummer>' de volgende verblijfplaats gegevens
      | naam        | waarde        |
      | adresregel1 | <adresregel1> |

      Voorbeelden:
      | omschrijving                                         | burgerservicenummer | straatnaam               | naam openbare ruimte       | huisnummer | huisletter | huinummertoevoeging | aanduiding bij huisnummer | locatiebeschrijving        | adresregel1                  |
      | naam openbare ruimte langer dan straatnaam           | 999994335           | Jonkheer van Riemsdijkln | Jonkheer van Riemsdijklaan | 88         |            |                     |                           |                            | Jonkheer van Riemsdijkln 88  |
      | huisletter en geen huisnummertoevoeging              | 999991930           | Borgesiusstraat          |                            | 103        | c          |                     |                           |                            | Borgesiusstraat 103 c        |
      | huisnummertoevoeging die begint met een letter       | 999993793           | Daniël Stalpertstraat    |                            | 35         |            | III                 |                           |                            | Daniël Stalpertstraat 35 III |
      | huisnummertoevoeging die begint met een cijfer       | 999990883           | Atatürkstraat            | Atatþrkstraat              | 9          |            | 2                   |                           |                            | Atatürkstraat 9-2            |
      | huisletter en huisnummertoevoeging begint met letter | 999990160           | St. Jacobsstraat         | St. Jacobsstraat           | 400        | L          | Toe                 |                           |                            | St. Jacobsstraat 400 LToe    |
      | huisletter en huisnummertoevoeging begint met cijfer | 999991693           | Cronus                   |                            | 555        | B          | 73c                 |                           |                            | Cronus 555 B73c              |
      | locatiebeschrijving                                  | 000009921           |                          |                            |            |            |                     |                           | Woonboot in de Grote Sloot | Woonboot in de Grote Sloot   |
      | aanduiding bij huisnummer bij                        | 999990913           | Graan voor Visch         |                            | 15201      |            |                     | by                        |                            | Graan voor Visch bij 15201   |
      | aanduiding bij huisnummer tegenover                  | 999990482           | 1e Exloërmond            | 1e Exloërmond              | 3          |            |                     | to                        |                            | 1e Exloërmond t/o 3          |

  Rule: Voor een binnenlands adres wordt adresregel2 samengesteld conform NEN 5825:2002.

    # Veld adresregel2 wordt samengesteld uit postcode + woonplaats
    # Tussen postcode numeriek deel en postcode alfabetisch deel moet een spatie worden geplaatst
    # Tussen postcode alfabetisch deel en woonplaatsnaam moeten twee spaties worden geplaatst
    # De woonplaatsnaam wordt in hoofdletters geschreven

    Abstract Scenario: adresregel2 voor een binnenlands <omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | <burgerservicenummer>                |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                              | waarde                |
      | gemeente van inschrijving (09.10) | 0518                  |
      | postcode (11.60)                  | <postcode>            |
      | woonplaatsnaam (11.70)            | <woonplaatsnaam>      |
      | locatiebeschrijving (12.10)       | <locatiebeschrijving> |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                                                                    |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131                                      |
      | fields               | verblijfplaats.adresregel2,verblijfplaats.adresregel3,verblijfplaats.land |
      Dan bevat de persoon met burgerservicenummer '<burgerservicenummer>' de volgende verblijfplaats gegevens
      | naam        | waarde        |
      | adresregel2 | <adresregel2> |

      Voorbeelden:
      | omschrijving                           | burgerservicenummer | woonplaatsnaam | postcode | locatiebeschrijving        | adresregel2            |
      | woonplaatsnaam anders dan gemeentenaam | 999992922           | Scheveningen   | 2583XL   |                            | 2583 XL  SCHEVENINGEN  |
      | geen woonplaatsnaam                    | 999990639           |                | 2584BZ   |                            | 2584 BZ  'S-GRAVENHAGE |
      | locatiebeschrijving                    | 000009921           |                |          | Woonboot in de Grote Sloot | 'S-GRAVENHAGE          |

  Rule: Voor een buitenlands adres worden de adresregels en land gevuld uit de gegevens over verblijf buitenland (groep 13)

    Scenario: persoon verblijft in het buitenland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | 999993483                            |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                              | waarde          |
      | gemeente van inschrijving (09.10) | 1999            | # kan dit ingevuld zijn voor een buitenlands adres?
      | land adres buitenland (13.10)     | 5010            |
      | regel 1 adres buitenland (13.30)  | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40)  | Bruxelles       |
      | regel 3 adres buitenland (13.50)  | postcode 1000   |
      | woonplaatsnaam (11.70)            |                 | # is dit een veld waarop moet worden gecheckt voor buitenlands adres? Is het gevuld zijn van één of meerdere groep 13 velden niet voldoende?
      En de waardetabel 'Landen' heeft de volgende waarden
      | code | omschrijving |
      | 5010 | België       |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                               |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | fields               | verblijfplaats                       |
      Dan bevat de persoon met burgerservicenummer '999993483' de volgende verblijfplaats gegevens
      | naam              | waarde                   |
      | type              | VerblijfplaatsBuitenland |
      | adresregel1       | Rue du pomme 25          |
      | adresregel2       | Bruxelles                |
      | adresregel3       | postcode 1000            |
      | land.code         | 5010                     |
      | land.omschrijving | België                   |

  Rule: Als het adres in het buitenland onbekend is (land adres buitenland 13.10 heeft de waarde "0000"), worden land en de adresregels niet opgenomen, en wordt vertrokkenOnbekendWaarheen opgenomen met de waarde true.

    Scenario: adres buitenland is onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | 999993586                            |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 0518   | # kan dit ingevuld zijn voor een buitenlands adres?
      | land adres buitenland (13.10)     | 0000   |
      | regel 1 adres buitenland (13.30)  |        |
      | regel 2 adres buitenland (13.40)  |        |
      | regel 3 adres buitenland (13.50)  |        |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                               |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | fields               | verblijfplaats                       |
      Dan bevat de persoon met burgerservicenummer '999993586' de volgende verblijfplaats gegevens
      | naam                       | waarde           |
      | type                       | VerblijfOnbekend |
      | vertrokkenOnbekendWaarheen | true             |

  Rule: Voor een binnenlandse verblijfplaats worden adresregel3 en land niet opgenomen

    Abstract Scenario: persoon verblijft met een <omschrijving> in Nederland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                               |
      | identificatie       | 4cbcf7fd-d788-4be5-8ebc-17decde26131 |
      | burgerservicenummer | <burgerservicenummer>                |
      En de persoon heeft de volgende verblijfplaats gegevens
      | naam                        | waarde                |
      | straatnaam (11.10)          | <straatnaam>          |
      | locatiebeschrijving (12.10) | <locatiebeschrijving> |
      Als personen wordt geraadpleegd met de volgende parameters
      | naam                 | waarde                                                                    |
      | persoonIdentificatie | 4cbcf7fd-d788-4be5-8ebc-17decde26131                                      |
      | fields               | verblijfplaats.adresregel1,verblijfplaats.adresregel3,verblijfplaats.land |
      Dan bevat de persoon met burgerservicenummer '<burgerservicenummer>' de volgende verblijfplaats gegevens NIET
      | naam                       |
      | adresregel3                |
      | land                       |
      | vertrokkenOnbekendWaarheen |

      Voorbeelden:
      | omschrijving        | burgerservicenummer | straatnaam               | locatiebeschrijving        |
      | adres               | 999994335           | Jonkheer van Riemsdijkln |                            |
      | locatiebeschrijving | 000009921           |                          | Woonboot in de Grote Sloot |
