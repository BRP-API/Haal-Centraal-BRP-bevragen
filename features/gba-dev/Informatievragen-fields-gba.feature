# language: nl

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
      | naam           | waarde   |
      | naam.voornamen | Carolina |

  Rule: wanneer gevraagd wordt om volledigeNaam, wordt voornamen, adellijkeTitelPredicaat, voorvoegsel, geslachtsnaam en aanduidingNaamgebruik geleverd
    
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


  Rule: wanneer gevraagd wordt om aanhef, aanschrijfwijze of gebruikInLopendeTekst, dan worden naast het geslacht en de naamgegevens van de persoon ook de naamgegevens van de partner geleverd
    - van de partner worden adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam geleverd
   
    Abstract Scenario: met fields is gevraagd om <veld>
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000176                       |
      | fields              | <veld>                          |
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
      | veld                             |
      | aanhef                           |
      | aanschrijfwijze                  |
      | gebruikInLopendeTekst            |
      | adressering.aanhef               |
      | aanschrijfwijze.naam             |
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
      | geboorteland (03.30)   | 6030      |
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
      | naam                      | waarde       |
      | datum overlijden (08.10)  | 20151001     |
      | plaats overlijden (08.20) | Buenos Aires |
      | land overlijden (08.30)   | 7015         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | indicatieOverleden              |
      Dan heeft de response een persoon met de volgende gegevens
      | naam             | waarde   |
      | overlijden.datum | 20151001 |

  Rule: wanneer een veld van verblijfplaats wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type verblijfplaats
    - dit betreft alle velden uit groepen 11 (adres), 12 (locatie) en land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland)

    Abstract Scenario: met fields wordt gevraagd naar een in een <adressoort> <beschikbaarheid> veld 
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | gemeente van inschrijving (09.10)      | 0599     |
      | functieAdres.code (10.10)              | W        |
      | datum aanvang adreshouding (10.30)     | 20150808 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | <burgerservicenummer>               |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde                             |
      | straat                           | <straat>                           |
      | huisnummer                       | <huisnummer>                       |
      | postcode                         | <postcode>                         |
      | woonplaats                       | <woonplaats>                       |
      | locatiebeschrijving              | <locatiebeschrijving>              |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |

      Voorbeelden:
      | burgerservicenummer | adressoort          | veld                | beschikbaarheid  | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          |
      | 000000267           | binnenlands adres   | straat              | beschikbaar      | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      | 000000267           | binnenlands adres   | locatiebeschrijving | niet beschikbaar | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              |
      | 000000279           | locatiebeschrijving | locatiebeschrijving | beschikbaar      |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |
      | 000000279           | locatiebeschrijving | regel1              | niet beschikbaar |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot |

    Abstract Scenario: met fields wordt gevraagd naar een in een buitenlandsadres <beschikbaarheid> veld
      Gegeven de persoon met burgerservicenummer '000000280' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde            |
      | land (13.10)                           | 5002              |
      | datum aanvang adres buitenland (13.20) | 20150808          |
      | regel 1 adres buitenland (13.30)       | 14 Rue Camulogene |
      | regel 2 adres buitenland (13.40)       | 75015 Parijs      |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000280                           |
      | fields              | verblijfplaats.verblijfadres.<veld> |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam              | waarde            |
      | land.code         | 5002              |
      | land.omschrijving | Frankrijk         |
      | regel1            | 14 Rue Camulogene |
      | regel2            | 75015 Parijs      |

      Voorbeelden:
      | veld                | beschikbaarheid  |
      | regel1              | beschikbaar      |
      | locatiebeschrijving | niet beschikbaar |

    Scenario: met fields wordt gevraagd naar een adresveld bij een onbekend adres
      Gegeven de persoon met burgerservicenummer '000000292' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | land (13.10)                           | 0000     |
      | datum aanvang adres buitenland (13.20) | 20150808 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | 000000292                           |
      | fields              | verblijfplaats.verblijfadres.straat |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam              | waarde   |
      | land.code         | 0000     |
      | land.omschrijving | Onbekend |

    Abstract Scenario: met fields gevraagd om <veld>
      Gegeven de persoon met burgerservicenummer '000000309' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde           |
      | functieAdres.code (10.10)                  | W                |
      | datum aanvang adreshouding (10.30)         | 20150808         |
      | gemeente van inschrijving (09.10)          | 0599             |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | straatnaam (11.10)                         | Boterondiep      |
      | naam openbare ruimte (11.15)               | Boterondiep      |
      | huisnummer (11.20)                         | 31               |
      | postcode (11.60)                           | 3077AW           |
      | woonplaats (11.70)                         | Rotterdam        |
      | gemeente_code                              | 0599             |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000309                       |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde           |
      | straat                           | Boterondiep      |
      | huisnummer                       | 31               |
      | postcode                         | 3077AW           |
      | woonplaats                       | Rotterdam        |
      | adresseerbaarObjectIdentificatie | 0599010000208579 |
      | nummeraanduidingIdentificatie    | 0599200000219678 |

      Voorbeelden:
      | veld                                |
      | verblijfplaats.verblijfadres.straat |
      | verblijfadres.straat                |
      | straat                              |
      | korteNaam                           |
      | postcode                            |
      | nummeraanduidingIdentificatie       |
      | locatiebeschrijving                 |
      | woonplaats                          |
      | verblijfadres.land                  |
      | regel1                              |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats, wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type

   Abstract Scenario: Vragen om datumVan van een <adressoort>
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                     |
      | gemeente van inschrijving (09.10)          | 0599                       |
      | functieAdres.code (10.10)                  | W                          |
      | datum aanvang adreshouding (10.30)         | <datumAanvangAdreshouding> |
      | ingangsdatum geldigheid (85.10)            | <datumIngangGeldigheid>    |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde                             |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | gemeente_code                              | 0599                               |
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
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie>    |
      | datumAanvangAdreshouding         | <datumAanvangAdreshouding>         |

      Voorbeelden:
      | burgerservicenummer | adressoort          | datumAanvangAdreshouding | straat      | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving          | datumIngangGeldigheid |
      | 000000310           | binnenlands adres   | 20150808                 | Boterondiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                              | 20150808              |
      | 000000322           | locatiebeschrijving | 20000310                 |             |            |          |            |                                  |                               | Woonboot in de Grotere Sloot | 20000310              |

    Scenario: Vragen om datumVan van een buitenlandse adres
      Gegeven de persoon met burgerservicenummer '000000334' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde            |
      | land (13.10)                               | 5002              |
      | datum aanvang adres buitenland (13.20)     | 20200223          |
      | regel 1 adres buitenland (13.30)           | 14 Rue Camulogene |
      | regel 2 adres buitenland (13.40)           | 75015 Parijs      |
      | ingangsdatum geldigheid (85.10)            | 20200223          |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000334                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde            |
      | land.code                        | 5002              |
      | land.omschrijving                | Frankrijk         |
      | regel1                           | 14 Rue Camulogene |
      | regel2                           | 75015 Parijs      |
      | datumAanvangAdresBuitenland      | 20200223          |

    Scenario: Vragen om datumVan van een onbekend adres
      Gegeven de persoon met burgerservicenummer '000000346' heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde   |
      | datum aanvang adres buitenland (13.20)     | 20080402 |
      | land (13.10)                               | 0000     |
      | ingangsdatum geldigheid (85.10)            | 20080402 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000346                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde   |
      | land.code                   | 0000     |
      | land.omschrijving           | Onbekend |
      | datumAanvangAdresBuitenland | 20080402 |

  Rule: wanneer gevraagd wordt om vanuitVerblijfplaatsOnbekend, wordt landVanwaarIngeschreven geleverd

    Scenario: met fields is gevraagd om vanuitVerblijfplaatsOnbekend
      Gegeven de persoon met burgerservicenummer '000000358' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde      |
      | land vanwaar ingeschreven (14.10)    | 5003        |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000358                       |
      | fields              | vanuitVerblijfplaatsOnbekend    |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                                 | waarde      |
      | landVanwaarIngeschreven.code         | 5003        |
      | landVanwaarIngeschreven.omschrijving | Zwitserland |

  Rule: wanneer gevraagd wordt om indicatieVestigingVanuitBuitenland, wordt datumVestigingInNederland geleverd

    Scenario: met fields is gevraagd om indicatieVestigingVanuitBuitenland
      Gegeven de persoon met burgerservicenummer '000000371' heeft de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde      |
      | land vanwaar ingeschreven (14.10)    | 5003        |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 000000371                          |
      | fields              | indicatieVestigingVanuitBuitenland |
      Dan heeft de response een persoon met de volgende 'immigratie' gegevens
      | naam                      | waarde   |
      | datumVestigingInNederland | 19750101 |

  Rule: wanneer gevraagd wordt om een adresregel1, adresregel2, adresregel3 of land in de adressering, dan worden de verblijfplaats velden geleverd die nodig zijn voor het samenstellen daarvan
    - Veld adresregel1 wordt samengesteld uit straat + aanduidingBijHuisnummer + huisnummer + huisletter + huisnummertoevoeging + locatiebeschrijving + regel 1 adres buitenland
    - Veld adresregel2 wordt samengesteld uit postcode + woonplaats + gemeente van inschrijving + regel 2 adres buitenland
    - veld adresregel3 wordt gevuld met regel 3 adres buitenland
    - veld land wordt gevuld met land

    Abstract Scenario: met fields is gevraagd om <veld> van een <adressoort>
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                    |
      | gemeente van inschrijving (09.10) | <gemeentecode>            |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
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
      | gemeente_code                     | <gemeenteVanInschrijving> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | burgerservicenummer,<veld>      |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                 | waarde                    |
      | burgerservicenummer                  | <burgerservicenummer>     |
      | gemeenteVanInschrijving.code         | <gemeenteVanInschrijving> |
      | gemeenteVanInschrijving.omschrijving | <gemeente omschrijving>   |
      En heeft de persoon alleen de volgende 'verblijfplaats' gegevens
      | naam                                 | waarde                    |
      | straat                               | <straat>                  |
      | huisnummer                           | <huisnummer>              |
      | huisletter                           | <huisletter>              |
      | huisnummertoevoeging                 | <huisnummertoevoeging>    |
      | aanduidingBijHuisnummer.code         | <aanduidingBijHuisnummer> |
      | aanduidingBijHuisnummer.omschrijving | <aanduiding omschrijving> |
      | verblijfadres.postcode               | <postcode>                |
      | verblijfadres.woonplaats             | <woonplaats>              |
      | locatiebeschrijving                  | <locatiebeschrijving>     |

      Voorbeelden:
      | burgerservicenummer | veld        | adressoort                  | gemeentecode | gemeenteVanInschrijving | gemeente omschrijving | straat             | huisnummer | huisletter | huisnummertoevoeging | aanduidingBijHuisnummer | aanduiding omschrijving | postcode | woonplaats | locatiebeschrijving          |
      | 000000383           | adresregel1 | binnenlandse verblijfplaats | 0599         |                         |                       | Boterondiep        | 31         |            |                      |                         |                         |          |            |                              |
      | 000000395           | adresregel1 | binnenlandse verblijfplaats | 0530         |                         |                       | Cronus             | 555        | B          | 73c                  |                         |                         |          |            |                              |
      | 000000401           | adresregel1 | binnenlandse verblijfplaats | 0394         |                         |                       | Graan voor Visch   | 15201      |            |                      | by                      | bij                     |          |            |                              |
      | 000000383           | adresregel2 | binnenlandse verblijfplaats | 0599         | 0599                    | Rotterdam             |                    |            |            |                      |                         |                         | 3077AW   | Rotterdam  |                              |
      | 000000413           | adresregel1 | locatiebeschrijving         | 0518         |                         |                       |                    |            |            |                      |                         |                         |          |            | Woonboot in de Grotere Sloot |
      | 000000413           | adresregel2 | locatiebeschrijving         | 0518         | 0518                    | 's-Gravenhage         |                    |            |            |                      |                         |                         |          |            |                              |

    Abstract Scenario: met fields is gevraagd om <veld> van een buitenlandsadres
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | land (13.10)                           | <land>   |
      | datum aanvang adres buitenland (13.20) | 20150808 |
      | regel 1 adres buitenland (13.30)       | <regel1> |
      | regel 2 adres buitenland (13.40)       | <regel2> |
      | regel 3 adres buitenland (13.50)       | <regel3> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam              | waarde              |
      | land.code         | <land>              |
      | land.omschrijving | <land omschrijving> |
      | regel1            | <regel1>            |
      | regel2            | <regel2>            | 
      | regel3            | <regel3>            |

      Voorbeelden:
      | veld             | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | land | land omschrijving | regel1            | regel2       | regel3        |
      | adresregel1      | 000000425           | 1999                    | Registratie Niet Ingezetenen (RNI) |      |                   | 14 Rue Camulogene |              |               |
      | adresregel2      | 000000425           | 1999                    | Registratie Niet Ingezetenen (RNI) |      |                   |                   | 75015 Parijs |               |
      | adressering.land | 000000425           | 1999                    | Registratie Niet Ingezetenen (RNI) | 5002 | Frankrijk         |                   |              |               |
      | adresregel1      | 000000437           | 1999                    | Registratie Niet Ingezetenen (RNI) |      |                   | Rue du pomme 25   |              |               |
      | adresregel2      | 000000437           | 1999                    | Registratie Niet Ingezetenen (RNI) |      |                   |                   | Bruxelles    |               |
      | adresregel3      | 000000437           | 1999                    | Registratie Niet Ingezetenen (RNI) |      |                   |                   |              | postcode 1000 |
      | adressering.land | 000000437           | 1999                    | Registratie Niet Ingezetenen (RNI) | 5010 | België            |                   |              |               |

    Scenario: met fields is gevraagd om adresregel1 van een onbekend adres
      Gegeven de persoon met burgerservicenummer '000000449' heeft de volgende 'verblijfplaats' gegevens
      | naam                              | waarde |
      | gemeente van inschrijving (09.10) | 1999   |
      | land (13.10)                      | 0000   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000449                       |
      | fields              | adresregel1                     |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                        | waarde   |
      | land.code                   | 0000     |
      | land.omschrijving           | Onbekend |

  Rule: wanneer een veld van nationaliteiten wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type nationaliteit
    - dit betreft de velden nationaliteit en aanduidingBijzonderNederlanderschap

    Abstract Scenario: vragen om een gegeven van nationaliteiten
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft een 'nationaliteit' met de volgende gegevens
      | naam                               | waarde                  |
      | nationaliteit (05.10)              | <nationaliteit>         |
      | bijzonder Nederlanderschap (65.10) | <bijz. NL-schap>        |
      | reden opname (63.10)               | <redenOpname>           |
      | datum ingang geldigheid (85.10)    | <datumIngangGeldigheid> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetBurgerservicenummer       |
      | burgerservicenummer | <burgerservicenummer>                 |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response een persoon met alleen de volgende 'nationaliteit' gegevens
      | naam                                | waarde                       |
      | nationaliteit.code                  | <nationaliteit>              |
      | nationaliteit.omschrijving          | <nationaliteit omschrijving> |
      | aanduidingBijzonderNederlanderschap | <bijz. NL-schap>             |
      | datumIngangGeldigheid               | <datumIngangGeldigheid>      |

      Voorbeelden:
      | burgerservicenummer | nationaliteit | nationaliteit omschrijving | bijz. NL-schap | redenOpname | redenOpname omschrijving                        | datumIngangGeldigheid |
      | 000000450           | 0001          | Nederlandse                |                | 001         | Wet op het Nederlanderschap 1892, art.1, lid 1a | 19750707              |
      | 000000462           | 0263          | Surinaamse                 |                | 301         | Vaststelling bezit vreemde nationaliteit        | 00000000              |
      | 000000474           | 0000          | Onbekend                   |                | 311         | Vaststelling onbekende nationaliteit            | 00000000              |
      | 000000486           |               |                            | B              | 310         | Vaststelling bijzonder Nederlanderschap         | 19570115              |
      | 000000498           |               |                            | V              | 310         | Vaststelling bijzonder Nederlanderschap         | 19750615              |

  Rule: wanneer een veld van een datum wordt gevraagd, wordt de datum geleverd

    Abstract Scenario: met fields is gevraagd om <veld>.<datumveld>
      Gegeven de persoon met burgerservicenummer '000000504' heeft de volgende 'inschrijving' gegevens
      | naam                | waarde    |
      | <GBA veld>          | 20131102  |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000504                       |
      | fields              | <veld>.<datumveld>              |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam   | waarde   |
      | <veld> | 20131102 |

      Voorbeelden:
      | datumveld   | GBA veld                                  | veld                        |
      | type        | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | langFormaat | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | datum       | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | jaar        | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | maand       | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | onbekend    | datum eerste inschrijving GBA (68.10)     | datumEersteInschrijvingGBA  |
      | type        | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
      | langFormaat | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
      | datum       | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
      | jaar        | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
      | maand       | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |
      | onbekend    | datum inschrijving in de gemeente (09.20) | datumInschrijvingInGemeente |

    Abstract Scenario: met fields is gevraagd om <groep>.<veld>.<datumveld>
      Gegeven de persoon met burgerservicenummer '000000516' heeft de volgende <categorie> 
      | naam       | waarde   |
      | <GBA veld> | 20131102 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000516                       |
      | fields              | <groep>.<veld>.<datumveld>      |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam   | waarde   |
      | <veld> | 20131102 |

      Voorbeelden:
      | datumveld   | GBA veld                                         | categorie                 | groep                 | veld                      |
      | type        | geboortedatum (03.10)                            | gegevens                  | geboorte              | datum                     |
      | datum       | datum vestiging in Nederland (14.20)             | 'verblijfplaats' gegevens | immigratie            | datumVestigingInNederland |
      | jaar        | einddatum uitsluiting Europees kiesrecht (31.30) | 'inschrijving' gegevens   | europeesKiesrecht     | einddatumUitsluiting      |
      | maand       | einddatum uitsluiting kiesrecht (38.20)          | 'inschrijving' gegevens   | uitsluitingKiesrecht  | einddatum                 |
      | langFormaat | datum opschorting bijhouding (67.10)             | 'inschrijving' gegevens   | opschortingBijhouding | datum                     |
      | onbekend    | datum overlijden (08.10)                         | 'overlijden' gegevens     | overlijden            | datum                     |
      | langFormaat | datum einde verblijfstitel (39.20)               | 'verblijfstitel' gegevens | verblijfstitel        | datumEinde                |
      | datum       | ingangsdatum verblijfstitel (39.30)              | 'verblijfstitel' gegevens | verblijfstitel        | datumIngang               |

  Rule: geheimhoudingPersoonsgegevens wordt altijd geleverd

    Abstract Scenario: Persoon heeft <titel>
      Gegeven de persoon met burgerservicenummer '<burgerservicenummer>' heeft de volgende 'inschrijving' gegevens 
      | naam                     | waarde          |
      | indicatie geheim (70.10) | <geheimhouding> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                          | waarde                |
      | burgerservicenummer           | <burgerservicenummer> |
      | geheimhoudingPersoonsgegevens | <geheimhouding>       |

      Voorbeelden:
      | burgerservicenummer | titel              | geheimhouding |
      | 000000528           | wel geheimhouding  | 7             |
      | 000000541           | wel geheimhouding  | 6             |
      | 000000553           | wel geheimhouding  | 5             |
      | 000000565           | wel geheimhouding  | 4             |
      | 000000577           | wel geheimhouding  | 3             |
      | 000000589           | wel geheimhouding  | 2             |
      | 000000590           | wel geheimhouding  | 1             |
      | 000000607           | geen geheimhouding | 0             |

  Rule: opschorting bijhouding reden wordt altijd geleverd wanneer die een waarde heeft

    Abstract Scenario: Persoon heeft <variant> opschorting bijhouding
      Gegeven de persoon met burgerservicenummer '000000619' heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde                         |
      | datum opschorting bijhouding (67.10) | <datum opschorting bijhouding> |
      | reden opschorting bijhouding (67.20) | <reden opschorting bijhouding> |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000619                       |
      | fields              | burgerservicenummer             |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                     | waarde                                      |
      | burgerservicenummer                      | 000000619                                   |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>              |
      | opschortingBijhouding.reden.omschrijving | <omschrijving reden opschorting bijhouding> |
	  
      Voorbeelden:
      | variant | datum opschorting bijhouding | reden opschorting bijhouding | omschrijving reden opschorting bijhouding |
      | een     | 20140702                     | E                            | emigratie                                 |
      | geen    |                              |                              |                                           |
