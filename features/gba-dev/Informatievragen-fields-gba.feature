# language: nl

@gba
Functionaliteit: vertalen van gevraagde samengestelde of afgeleide velden naar leveren van bron velden
  Wanneer met fields wordt gevraagd om een veld dat wordt samengesteld uit verschillende andere velden in de GbaPersoon, dan worden deze benodigde velden geleverd.

  Achtergrond:
     Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende gegevens
      | naam                                 | waarde      |
      | geslachtsaanduiding (04.10)          | M           |
      | voornamen (02.10)                    | Hendrik Jan |
      | adellijke titel of predicaat (02.20) | R           |
      | voorvoegsel (02.30)                  | de          |
      | geslachtsnaam (02.40)                | Brink       |
      | aanduiding naamgebruik (61.10)       | E           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                                 | waarde    |
      | burgerservicenummer (01.20)          | 000000188 |
      | geslachtsaanduiding (04.10)          | V         |
      | voornamen (02.10)                    | Carolina  |
      | adellijke titel of predicaat (02.20) | BS        |
      | voorvoegsel (02.30)                  | van der   |
      | geslachtsnaam (02.40)                | Horn      |

  Rule: wanneer gevraagd wordt om voorletters, wordt voornamen geleverd

    Scenario: met fields is gevraagd om voorletters
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | naam.voorletters                |
      Dan heeft de response een persoon met de volgende gegevens
      | naam           | waarde      |
      | naam.voornamen | Hendrik Jan |

    Scenario: met fields is gevraagd om de voorletters van de partner
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | partners.naam.voorletters       |
      Dan heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam             | waarde |
      | naam.voornamen | Carolina |

  Rule: wanneer gevraagd wordt om volledigeNaam, wordt voornamen, adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam geleverd
    
    Scenario: met fields is gevraagd om volledigeNaam
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | naam.volledigeNaam              |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                 | waarde                        |
      | voornamen                            | Hendrik Jan                   |
      | adellijkeTitelPredicaat.code         | R                             |
      | adellijkeTitelPredicaat.omschrijving | Ridder                        |
      | adellijkeTitelPredicaat.soort        | titel                         |
      | voorvoegsel                          | de                            |
      | geslachtsnaam                        | Brink                         |
	  | aanduidingNaamgebruik.code           | E                             |
	  | aanduidingNaamgebruik.omschrijving   | gebruik alleen de eigen naam. |


  Rule: wanneer gevraagd wordt om aanhef, aanschrijfwijze of gebruikInLopendeTekst, dan worden geslacht, naam en naam van de partner geleverd
    - van de partner worden adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam geleverd
   
    Abstract Scenario: met fields is gevraagd om <fields>
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                      | waarde                        |
      | naam.voornamen                            | Hendrik Jan                   |
      | naam.adellijkeTitelPredicaat.code         | R                             |
      | naam.adellijkeTitelPredicaat.omschrijving | Ridder                        |
      | naam.adellijkeTitelPredicaat.soort        | titel                         |
      | naam.voorvoegsel                          | de                            |
      | naam.geslachtsnaam                        | Brink                         |
      | naam.aanduidingNaamgebruik.code           | E                             |
      | naam.aanduidingNaamgebruik.omschrijving   | gebruik alleen de eigen naam. |
      | geslacht.code                             | M                             |
      | geslacht.omschrijving                     | man                           |
      En heeft de response een persoon met een 'partner' met de volgende gegevens
      | naam                                      | waarde  |
      | naam.adellijkeTitelPredicaat.code         | BS      |
      | naam.adellijkeTitelPredicaat.omschrijving | Barones |
      | naam.adellijkeTitelPredicaat.soort        | titel   |
      | naam.voorvoegsel                          | van der |
      | naam.geslachtsnaam                        | Horn    |

      Voorbeelden:
      | fields                           |
      | aanhef                           |
      | aanschrijfwijze                  |
      | gebruikInLopendeTekst            |
      | adressering.aanhef               |
      | aanschrijfwijze.naam             |
	  # Het volgende voorbeeld leidt nog tot een assertion failure Blijkbaar levert de GBA API in dit geval niet de voornamen, voorvoegsel, geslachtsnaam, 
	  # aanduidingnaamgebruik van de gevraagde persoon en van de partner niet het voorvoegsel en geslachtsnaam.
      | aanschrijfwijze.aanspreekvorm    |
      | adressering.aanschrijfwijze.naam |

  Rule: wanneer gevraagd wordt om leeftijd, wordt geboorte.datum en overlijden.datum geleverd
    - overlijden.datum wordt alleen geleverd wanneer de persoon overleden is (wanneer er een waarde is voor overlijden.datum)

    Abstract Scenario: met fields is gevraagd om leeftijd van een persoon die niet overleden is
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende gegevens
      | naam                  | waarde          |
      | geboortedatum (03.10) | <geboortedatum> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam           | waarde          |
      | geboorte.datum | <geboortedatum> |

      Voorbeelden:
      | burgerservicenummer | geboortedatum |
      | 000000206           | 19851201      |
      | 000000218           | 19950200      |
      | 000000231           | 19680000      |
      | 000000243           | 00000000      |

    Scenario: met fields is gevraagd om leeftijd van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000255' heeft de volgende gegevens
      | naam                   | waarde    |
      | geboortedatum (03.10)  | 19960229  |
      | geboorteplaats (03.20) | 0599      |
      | geboorteland (03.30)  | 6030      |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                      | waarde       |
      | datum overlijden (08.10)  | 20151001     |
      | plaats overlijden (08.20) | Buenos Aires |
      | land overlijden (08.30)   | 7015         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000255                       |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met de volgende gegevens
      | naam             | waarde   |
      | geboorte.datum   | 19960229 |
      | overlijden.datum | 20151001 |

  Rule: wanneer gevraagd wordt om indicatieOverleden, wordt overlijden.datum geleverd

    Scenario: met fields is gevraagd om indicatieOverleden van een overleden persoon
      Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'overlijden' gegevens
      | naam                     | waarde        |
      | datum overlijden (08.10)  | 20151001     |
      | plaats overlijden (08.20) | Buenos Aires |
      | land overlijden (08.30)   | 7015         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | indicatieOverleden              |
      Dan heeft de response een persoon met de volgende gegevens
      | naam  | waarde   |
      | overlijden.datum | 20151001 |

  Rule: wanneer een veld van verblijfplaats wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type verblijfplaats
    - dit betreft alle velden uit groepen 11 (adres), 12 (locatie) en land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland)

    Abstract Scenario: Gevraagd veld zit in verblijfplaats
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                             |
      | functieAdres.code (10.10)              | <functieAdres>                     |
      | datum aanvang adreshouding (10.30)     | <datumAanvangAdreshouding>         |
      | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland>      |
      | land (13.10)                           | <land>                             |
      | regel 1 adres buitenland (13.30)       | <regel1>                           |
      | regel 2 adres buitenland (13.40)       | <regel2>                           |
      | regel 3 adres buitenland (13.50)       | <regel3>                           |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | gemeente van inschrijving (09.10)          | <gemeentecode>                     |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | <burgerservicenummer>               |
      | fields              | verblijfplaats.verblijfadres.straat |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | land.code                        | <land>                             |
      | land.omschrijving                | <land omschrijving>                |
      | regel1                           | <regel1>                           |
      | regel2                           | <regel2>                           |
      | regel3                           | <regel3>                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |

      Voorbeelden:
      | burgerservicenummer | functieAdres | functieAdres omschrijving | datumAanvangAdreshouding | straat    | huisnummer | postcode | woonplaats | gemeentecode | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving        | land | land omschrijving | datumAanvangAdresBuitenland | regel1            | regel2       | regel 3 |
      | 000000267           | W            | woonadres                 | 20150808                 | Boterdiep | 31         | 3077AW   | Rotterdam  | 0599         | 0599010000208579                 | 0599200000219678              |                            |      |                   |                             |                   |              |         |
      | 000000279           |              |                           |                          |           |            |          |            |              |                                  |                               | Woonboot in de Grote Sloot |      |                   |                             | Locatie           |              |         |
      | 000000280           |              |                           |                          |           |            |          |            |              |                                  |                               |                            | 5002 | Frankrijk         |                             | 14 Rue Camulogene | 75015 Parijs |         |
      | 000000292           |              |                           |                          |           |            |          |            |              |                                  |                               |                            | 0000 | Onbekend          |                             |                   |              |         |

    Abstract Scenario: met fields gevraagd om <fields>
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde           |
      | functieAdres.code (10.10)                  | W                |
      | datum aanvang adreshouding (10.30)         | 20150808         |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | straatnaam (11.10)                         | Boterdiep        |
      | naam openbare ruimte (11.15)               | Boterdiep        |
      | huisnummer (11.20)                         | 31               |
      | postcode (11.60)                           | 3077AW           |
      | woonplaats (11.70)                         | Rotterdam        |
      | gemeente van inschrijving (09.10)          | 0599             |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000309                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde           |
      | verblijfadres.straat             | Boterdiep        |
      | verblijfadres.huisnummer         | 31               |
      | verblijfadres.postcode           | 3077AW           |
      | verblijfadres.woonplaats         | Rotterdam        |
      | adresseerbaarObjectIdentificatie | 0599010000208579 |
      | nummeraanduidingIdentificatie    | 0599200000219678 |

      Voorbeelden:
      | fields                              |
      | verblijfplaats.verblijfadres.straat |
      | verblijfadres.straat                |
      | straat                              |
      | korteNaam                           |
      | postcode                            |
      | nummeraanduidingIdentificatie       |
      | locatiebeschrijving                 |
      | woonplaats                          |
      | land                                |
      | regel1                              |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats, wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type

    Abstract Scenario: Vragen om datumVan
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                             |
      | functieAdres.code (10.10)                  | <functieAdres>                     |
      | datum aanvang adreshouding (10.20)         | <datumAanvangAdreshouding>         |
      | datum aanvang adres buitenland (13.20)     | <datumAanvangAdresBuitenland>      |
      | land (13.10)                               | <land>                             |
      | regel 1 adres buitenland (13.30)           | <regel1>                           |
      | regel 2 adres buitenland (13.40)           | <regel2>                           |
      | regel 3 adres buitenland (13.50)           | <regel3>                           |
      | ingangsdatum geldigheid (85.10)            | <datumIngangGeldigheid>            |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | gemeente van inschrijving (09.10)          | 0599                               |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | land.code                        | <land>                             |
      | land.omschrijving                | <omschrijving>                     |
      | regel1                           | <regel1>                           |
      | regel2                           | <regel2>                           |
      | regel3                           | <regel3>                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding>         |
      | datumAanvangAdresBuitenland      | <datumAanvangAdresBuitenland>      |

      Voorbeelden:
      | burgerservicenummer | functieAdres | functieAdres omschrijving | datumAanvangAdreshouding | straat    | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving        | land | land omschrijving | datumAanvangAdresBuitenland | regel1            | regel2       | regel 3 | datumIngangGeldigheid |
      | 000000310           | W            | woonadres                 | 20150808                 | Boterdiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                            |      |                   |                             |                   |              |         | 20150808              |
      | 000000322           |              |                           | 20000310                 |           |            |          |            |                                  |                               | Woonboot in de Grote Sloot |      |                   |                             | Locatie           |              |         | 20000310              |
      | 000000334           |              |                           |                          |           |            |          |            |                                  |                               |                            | 5002 | Frankrijk         | 20200223                    | 14 Rue Camulogene | 75015 Parijs |         | 20200223              |
      | 000000346           |              |                           |                          |           |            |          |            |                                  |                               |                            | 0000 | Onbekend          | 20080402                    |                   |              |         | 20080402              |

  Rule: wanneer gevraagd wordt om vanuitVerblijfplaatsOnbekend, wordt landVanwaarIngeschreven geleverd

    Abstract Scenario: met fields is gevraagd om vanuitVerblijfplaatsOnbekend
      Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde      |
      | land vanwaar ingeschreven (14.10)    | 5003        |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000358                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                                 | waarde      |
      | landVanwaarIngeschreven.code         | 5003        |
      | landVanwaarIngeschreven.omschrijving | Zwitserland |

      Voorbeelden:
      | fields                                  |
      | vanuitVerblijfplaatsOnbekend            |
      | immigratie.vanuitVerblijfplaatsOnbekend |

  Rule: wanneer gevraagd wordt om indicatieVestigingVanuitBuitenland, wordt datumVestigingInNederland geleverd

    Abstract Scenario: met fields is gevraagd om indicatieVestigingVanuitBuitenland
      Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde      |
      | land vanwaar ingeschreven (14.10)    | 5003        |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000371                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                      | waarde   |
      | datumVestigingInNederland | 19750101 |

      Voorbeelden:
      | fields                                        |
      | indicatieVestigingVanuitBuitenland            |
      | immigratie.indicatieVestigingVanuitBuitenland |

  Rule: wanneer gevraagd wordt om een adresregel in de adressering, dan worden de velden geleverd die nodig zijn voor het samenstellen daarvan
    - Veld adresregel1 wordt samengesteld uit straat + aanduidingBijHuisnummer + huisnummer + huisletter + huisnummertoevoeging + locatiebeschrijving + regel 1 adres buitenland
    - Veld adresregel2 wordt samengesteld uit postcode + woonplaats + gemeente van inschrijving + regel 2 adres buitenland
    - veld adresregel3 wordt gevuld met regel 3 adres buitenland
    - veld adressering.land wordt gevuld met verblijfplaats.verblijfadres.land

    @gba
    Abstract Scenario: met fields is gevraagd om adresregel1
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) | <gemeenteVanInschrijving> |
      | locatiebeschrijving (12.10)       | <locatiebeschrijving>     |
      | land.code                         | <land>                    |
      | land.omschrijving                 | <land omschrijving>       |
      | regel 1 adres buitenland (13.30)  | <regel1>                  |
      | regel 2 adres buitenland (13.40)  | <regel2>                  |
      | regel 3 adres buitenland (13.50)  | <regel3>                  |
      En de 'verblijfplaats heeft de volgende 'adres' gegevens
      | naam                              | waarde                    |
      | straatnaam (11.10)                | <straat>                  |
      | naam openbare ruimte (11.15)      | <straat>                  |
      | huisnummer (11.20)                | <huisnummer>              |
      | huisletter (11.30)                | <huisletter>              |
      | huisnummertoevoeging (11.40)      | <huisnummertoevoeging>    |
      | aanduiding bij huisnummer (11.50) | <aanduidingBijHuisnummer> |
      | postcode (11.60)                  | <postcode>                |
      | woonplaats (11.70)                | <woonplaats>              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | adresregel1                     |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde                    |
      | straat                               | <straat>                  |
      | huisnummer                           | <huisnummer>              |
      | huisletter                           | <huisletter>              |
      | huisnummertoevoeging                 | <huisnummertoevoeging>    |
      | aanduidingBijHuisnummer.code         | <aanduidingBijHuisnummer> |
      | aanduidingBijHuisnummer.omschrijving | <aanduiding omschrijving> |
      | postcode                             | <postcode>                |
      | locatiebeschrijving                  | <locatiebeschrijving>     |
      | regel1                               | <regel1>                  |

      Voorbeelden:
      | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | straat           | huisnummer | huisletter | huisnummertoevoeging | aanduidingBijHuisnummer | aanduiding omschrijving | postcode | woonplaats | locatiebeschrijving        | land | land omschrijving | regel1            | regel2       | regel 3       |
      | 999993653           | 0599                    | Rotterdam                          | Boterdiep        | 31         |            |                      |                         |                         | 3077AW   | Rotterdam  |                            |      |                   |                   |              |               |
      | 999991693           | 0530                    | Hellevoetsluis                     | Cronus           | 555        | B          | 73c                  |                         |                         | 3225TD   |            |                            |      |                   |                   |              |               |
      | 999990913           | 0394                    | Haarlemmermeer                     | Graan voor Visch | 15201      |            |                      | by                      | bij                     |          | 2132EA     |                            |      |                   |                   |              |               |
      | 000009921           | 0518                    | 's-Gravenhage                      |                  |            |            |                      |                         |                         |          |            | Woonboot in de Grote Sloot |      |                   | Locatie           |              |               |
      | 999995121           | 1999                    | Registratie Niet Ingezetenen (RNI) |                  |            |            |                      |                         |                         |          |            |                            | 5002 | Frankrijk         | 14 Rue Camulogene | 75015 Parijs |               |
      | 999993483           | 1999                    | Registratie Niet Ingezetenen (RNI) |                  |            |            |                      |                         |                         |          |            |                            | 5010 | België            | Rue du pomme 25   | Bruxelles    | postcode 1000 |
      | 999993586           |                         |                                    |                  |            |            |                      |                         |                         |          |            |                            | 0000 | Onbekend          |                   |              |               |

    @gba
    Abstract Scenario: met fields is gevraagd om adresregel2
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                 | waarde                    |
      | burgerservicenummer                  | <burgerservicenummer>     |
      | gemeente van inschrijving (09.10)    | <gemeenteVanInschrijving> |
      | gemeenteVanInschrijving.omschrijving | <gemeente omschrijving>   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                    |
      | straatnaam (11.10)                | <straat>                  |
      | naam openbare ruimte (11.15)      | <straat>                  |
      | huisnummer (11.20)                | <huisnummer>              |
      | huisletter (11.30)                | <huisletter>              |
      | huisnummertoevoeging (11.40)      | <huisnummertoevoeging>    |
      | aanduiding bij huisnummer (11.50) | <aanduidingBijHuisnummer> |
      | postcode (11.60)                  | <postcode>                |
      | woonplaats (11.70)                | <woonplaats>              |
      | locatiebeschrijving (12.10)       | <locatiebeschrijving>     |
      | land.code                         | <land>                    |
      | land.omschrijving                 | <land omschrijving>       |
      | regel 1 adres buitenland (13.30)  | <regel1>                  |
      | regel 2 adres buitenland (13.40)  | <regel2>                  |
      | regel 3 adres buitenland (13.50)  | <regel3>                  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | adresregel2                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                 | waarde                    |
      | gemeenteVanInschrijving.code         | <gemeenteVanInschrijving> |
      | gemeenteVanInschrijving.omschrijving | <gemeente omschrijving>   |
      En heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                |
      | verblijfadres.postcode            | <postcode>            |
      | verblijfadres.woonplaats          | <woonplaats>          |
      | verblijfadres.regel2              | <regel2>              |

      Voorbeelden:
      | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | straat           | huisnummer | huisletter | huisnummertoevoeging | aanduidingBijHuisnummer | aanduiding omschrijving | postcode | woonplaats | locatiebeschrijving        | land | land omschrijving | regel1            | regel2       | regel 3       |
      | 999993653           | 0599                    | Rotterdam                          | Boterdiep        | 31         |            |                      |                         |                         | 3077AW   | Rotterdam  |                            |      |                   |                   |              |               |
      | 999991693           | 0530                    | Hellevoetsluis                     | Cronus           | 555        | B          | 73c                  |                         |                         | 3225TD   |            |                            |      |                   |                   |              |               |
      | 999990913           | 0394                    | Haarlemmermeer                     | Graan voor Visch | 15201      |            |                      | by                      | bij                     |          | 2132EA     |                            |      |                   |                   |              |               |
      | 000009921           | 0518                    | 's-Gravenhage                      |                  |            |            |                      |                         |                         |          |            | Woonboot in de Grote Sloot |      |                   | Locatie           |              |               |
      | 999995121           | 1999                    | Registratie Niet Ingezetenen (RNI) |                  |            |            |                      |                         |                         |          |            |                            | 5002 | Frankrijk         | 14 Rue Camulogene | 75015 Parijs |               |
      | 999993483           | 1999                    | Registratie Niet Ingezetenen (RNI) |                  |            |            |                      |                         |                         |          |            |                            | 5010 | België            | Rue du pomme 25   | Bruxelles    | postcode 1000 |
      | 999993586           |                         |                                    |                  |            |            |                      |                         |                         |          |            |                            | 0000 | Onbekend          |                   |              |               |

    @gba
    Abstract Scenario: met fields is gevraagd om adresregel3
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                 | waarde                    |
      | burgerservicenummer                  | <burgerservicenummer>     |
      | gemeente van inschrijving (09.10)    | <gemeenteVanInschrijving> |
      | gemeenteVanInschrijving.omschrijving | <gemeente omschrijving>   |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                |
      | straatnaam (11.10)               | <straat>              |
      | naam openbare ruimte (11.15)     | <straat>              |
      | huisnummer (11.20)               | <huisnummer>          |
      | postcode (11.60)                 | <postcode>            |
      | woonplaats (11.70)               | <woonplaats>          |
      | locatiebeschrijving (12.10)      | <locatiebeschrijving> |
      | land.code                        | <land>                |
      | land.omschrijving                | <land omschrijving>   |
      | regel 1 adres buitenland (13.30) | <regel1>              |
      | regel 2 adres buitenland (13.40) | <regel2>              |
      | regel 3 adres buitenland (13.50) | <regel3>              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | adresregel3                     |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                 | waarde   |
      | verblijfadres.regel3 | <regel3> |

      Voorbeelden:
      | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | straat    | huisnummer | postcode | woonplaats | locatiebeschrijving        | land | land omschrijving | regel1            | regel2       | regel 3       |
      | 999993653           | 0599                    | Rotterdam                          | Boterdiep | 31         | 3077AW   | Rotterdam  |                            |      |                   |                   |              |               |
      | 000009921           | 0518                    | 's-Gravenhage                      |           |            |          |            | Woonboot in de Grote Sloot |      |                   | Locatie           |              |               |
      | 999995121           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5002 | Frankrijk         | 14 Rue Camulogene | 75015 Parijs |               |
      | 999993483           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5010 | België            | Rue du pomme 25   | Bruxelles    | postcode 1000 |
      | 999993586           |                         |                                    |           |            |          |            |                            | 0000 | Onbekend          |                   |              |               |

    @gba
    Scenario: met fields is gevraagd om adressering.land
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                 | waarde                             |
      | burgerservicenummer                  | 999993483                          |
      | gemeente van inschrijving (09.10)    | 1999                               |
      | gemeenteVanInschrijving.omschrijving | Registratie Niet Ingezetenen (RNI) |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                             | waarde          |
      | land.code                        | 5010            |
      | land.omschrijving                | België          |
      | regel 1 adres buitenland (13.30) | Rue du pomme 25 |
      | regel 2 adres buitenland (13.40) | Bruxelles       |
      | regel 3 adres buitenland (13.50) | postcode 1000   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993483                       |
      | fields              | adressering.land                |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                            | waarde |
      | verblijfadres.land.code         | 5010   |
      | verblijfadres.land.omschrijving | België |

  Rule: wanneer een veld van nationaliteiten wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type nationaliteit
    - dit betreft de velden nationaliteit en aanduidingBijzonderNederlanderschap

    Abstract Scenario: vragen om een gegeven van nationaliteiten
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En de persoon heeft een 'nationaliteit' met de volgende gegevens
      | naam                                             | waarde                        |
      | nationaliteit (05.10)                            | <nationaliteit>               |
      | nationaliteit.omschrijving                       | <nationaliteit omschrijving>  |
      | aanduiding bijzonder Nederlanderschap (65.10)    | <bijz. NL-schap>              |
      | aanduidingBijzonderNederlanderschap.omschrijving | <bijz. NL-schap omschrijving> |
      | redenOpname.code                                 | <redenOpname>                 |
      | redenOpname.omschrijving                         | <redenOpname omschrijving>    |
      | datumIngangGeldigheid                            | <datumIngangGeldigheid>       |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetBurgerservicenummer       |
      | burgerservicenummer | <burgerservicenummer>                 |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
      | naam                                | waarde                       |
      | nationaliteit.code                  | <nationaliteit>              |
      | nationaliteit.omschrijving          | <nationaliteit omschrijving> |
      | aanduidingBijzonderNederlanderschap | <bijz. NL-schap>             |
      | datumIngangGeldigheid               | <datumIngangGeldigheid>      |

      Voorbeelden:
      | burgerservicenummer | nationaliteit | nationaliteit omschrijving | bijz. NL-schap | redenOpname | redenOpname omschrijving                        | datumIngangGeldigheid |
      | 000009830           | 0001          | Nederlandse                |                | 001         | Wet op het Nederlanderschap 1892, art.1, lid 1a | 19750707              |
      | 999993045           | 0263          | Surinaamse                 |                | 301         | Vaststelling bezit vreemde nationaliteit        | 00000000              |
      | 999993367           | 0000          | Onbekend                   |                | 311         | Vaststelling onbekende nationaliteit            | 00000000              |
      | 000009866           |               |                            | B              | 310         | Vaststelling bijzonder Nederlanderschap         | 19570115              |
      | 999994748           |               |                            | V              | 310         | Vaststelling bijzonder Nederlanderschap         | 19750615              |

  Rule: wanneer een veld van een datum wordt gevraagd, wordt de datum geleverd

    @gba
    Abstract Scenario: met fields is gevraagd om <veld>.<datumveld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993653 |
      | <GBA veld>          | 20131102  |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993653                       |
      | fields              | <veld>.<datumveld>              |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam   | waarde   |
      | <veld> | 20131102 |

      Voorbeelden:
      | datumveld   | GBA veld                                  | veld                        |
      | type        | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | langFormaat | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | datum       | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | jaar        | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | maand       | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | onbekend    | datum eerste inschrijving GBA/RNI (68.10) | datumEersteInschrijvingGBA  |
      | type        | datum inschrijving (09.20)                | datumInschrijvingInGemeente |
      | langFormaat | datum inschrijving (09.20)                | datumInschrijvingInGemeente |
      | datum       | datum inschrijving (09.20)                | datumInschrijvingInGemeente |
      | jaar        | datum inschrijving (09.20)                | datumInschrijvingInGemeente |
      | maand       | datum inschrijving (09.20)                | datumInschrijvingInGemeente |
      | onbekend    | datum inschrijving (09.20)                | datumInschrijvingInGemeente |

    @gba
    Abstract Scenario: met fields is gevraagd om <groep>.<veld>.<datumveld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende '<groep>' gegevens
      | naam       | waarde   |
      | <GBA veld> | 20131102 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>.<datumveld>      |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam   | waarde   |
      | <veld> | 20131102 |

      Voorbeelden:
      | datumveld   | GBA veld                                         | groep                 | veld                      |
      | type        | geboortedatum (03.10)                            | geboorte              | datum                     |
      | datum       | datum vestiging in Nederland (14.20)             | immigratie            | datumVestigingInNederland |
      | jaar        | einddatum uitsluiting Europees kiesrecht (31.30) | europeesKiesrecht     | einddatumUitsluiting      |
      | maand       | einddatum uitsluiting kiesrecht (38.20)          | uitsluitingKiesrecht  | einddatum                 |
      | langFormaat | datum opschorting bijhouding (67.10)             | opschortingBijhouding | datum                     |
      | onbekend    | datum overlijden (08.10)                         | overlijden            | datum                     |
      | langFormaat | datum einde verblijfstitel (39.20)               | verblijfstitel        | datumEinde                |
      | datum       | ingangsdatum verblijfstitel (39.30)              | verblijfstitel        | datumIngang               |

  Rule: geheimhoudingPersoonsgegevens wordt altijd geleverd

    @gba
    Abstract Scenario: Persoon heeft <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                  | waarde                |
      | burgerservicenummer                   | <burgerservicenummer> |
      | geheimhoudingPersoonsgegevens (70.10) | <gba geheimhouding>   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | burgerservicenummer             |
      Dan heeft de persoon met burgerservicenummer '<burgerservicenummer>' alleen de volgende gegevens
      | naam                          | waarde                |
      | burgerservicenummer           | <burgerservicenummer> |
      | geheimhoudingPersoonsgegevens | <geheimhouding>       |

      Voorbeelden:
      | burgerservicenummer | titel              | geheimhouding |
      | 999994608           | wel geheimhouding  | 7             |
      | 999995492           | wel geheimhouding  | 6             |
      | 999995480           | wel geheimhouding  | 5             |
      | 555550001           | wel geheimhouding  | 4             |
      | 999993872           | wel geheimhouding  | 3             |
      | 999992715           | wel geheimhouding  | 2             |
      | 999991802           | wel geheimhouding  | 1             |
      | 999991929           | geen geheimhouding | 0             |

  Rule: opschorting bijhouding reden wordt altijd geleverd wanneer die een waarde heeft

    @gba
    Scenario: Persoon heeft opschorting bijhouding
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                              | waarde    |
      | burgerservicenummer                               | 999993483 |
      | Datum opschorting bijhouding (67.10)              | 20140702  |
      | Omschrijving reden opschorting bijhouding (67.20) | E         |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993483                       |
      | fields              | burgerservicenummer             |
      Dan heeft de persoon met burgerservicenummer '999993483' alleen de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 999993483 |
      | opschortingBijhouding.reden.code         | E         |
      | opschortingBijhouding.reden.omschrijving | emigratie |

    @gba
    Scenario: Persoon heeft geen opschorting bijhouding
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                              | waarde    |
      | burgerservicenummer                               | 999993653 |
      | Datum opschorting bijhouding (67.10)              |           |
      | Omschrijving reden opschorting bijhouding (67.20) |           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993653                       |
      | fields              | burgerservicenummer             |
      Dan heeft de persoon met burgerservicenummer '999993653' alleen de volgende gegevens
      | naam                                     | waarde    |
      | burgerservicenummer                      | 999993653 |
