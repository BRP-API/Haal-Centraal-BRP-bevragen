# language: nl

@gba
Functionaliteit: vertalen van gevraagde samengestelde of afgeleide velden naar leveren van bron velden
  Wanneer met fields wordt gevraagd om een veld die wordt samengesteld uit verschillende andere velden in de GbaPersoon, dan worden deze benodigde velden geleverd.

  Achtergrond:
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999990160 |
      | geslachtsaanduiding (04.10) | M         |
      En de persoon heeft de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | voornamen (02.10)                    | Hendrik Jan |
      | adellijke titel of predicaat (02.20) | R           |
      | voorvoegsel (02.30)                  | de          |
      | geslachtsnaam (02.40)                | Brink       |
      | aanduiding naamgebruik (61.10)       | E           |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer         | 999994037 |
      | geslachtsaanduiding (04.10) | V         |
      En de 'partner' heeft de volgende 'naam' gegevens
      | naam                                 | waarde   |
      | voornamen (02.10)                    | Carolina |
      | adellijke titel of predicaat (02.20) | BS       |
      | voorvoegsel (02.30)                  | van der  |
      | geslachtsnaam (02.40)                | Horn     |

  Rule: wanneer gevraagd wordt om voorletters, wordt voornamen geleverd

    @gba
    Scenario: met fields is gevraagd om voorletters
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
      | fields              | naam.voorletters                |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam      | waarde      |
      | voornamen | Hendrik Jan |

    @gba
    Scenario: met fields is gevraagd om de voorletters van de partner
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
      | fields              | partners.naam.voorletters       |
      Dan heeft de response een persoon met de volgende 'partner' gegevens
      | naam           | waarde   |
      | naam.voornamen | Carolina |

  Rule: wanneer gevraagd wordt om volledigeNaam, wordt voornamen, adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam geleverd
    
    @gba
    Scenario: met fields is gevraagd om volledigeNaam
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
      | fields              | naam.volledigeNaam              |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | voornamen                            | Hendrik Jan |
      | adellijkeTitelPredicaat.code         | R           |
      | adellijkeTitelPredicaat.omschrijving | ridder      |
      | voorvoegsel                          | de          |
      | geslachtsnaam                        | Brink       |

  Rule: wanneer gevraagd wordt om aanhef, aanschrijfwijze of gebruikInLopendeTekst, dan worden geslacht, naam en naam van de partner geleverd
    - de partner worden adellijkeTitelPredicaat, voorvoegsel en geslachtsnaam geleverd
   
    @gba
    Abstract Scenario: met fields is gevraagd om <fields>
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende 'naam' gegevens
      | naam                                 | waarde      |
      | voornamen                            | Hendrik Jan |
      | adellijkeTitelPredicaat.code         | R           |
      | adellijkeTitelPredicaat.omschrijving | ridder      |
      | voorvoegsel                          | de          |
      | geslachtsnaam                        | Brink       |
      En heeft de response een persoon met de volgende gegevens
      | naam                  | waarde |
      | geslacht.code         | M      |
      | geslacht.omschrijving | man    |
      En heeft de response een persoon met de volgende 'partner' gegevens
      | naam                                 | waarde  |
      | adellijkeTitelPredicaat.code         | BS      |
      | adellijkeTitelPredicaat.omschrijving | barones |
      | voorvoegsel                          | van der |
      | geslachtsnaam                        | Horn    |

      Voorbeelden:
      | fields                           |
      | aanhef                           |
      | aanschrijfwijze                  |
      | gebruikInLopendeTekst            |
      | adressering.aanhef               |
      | aanschrijfwijze.naam             |
      | aanschrijfwijze.aanspreekvorm    |
      | adressering.aanschrijfwijze.naam |

  Rule: wanneer gevraagd wordt om leeftijd, wordt geboorte.datum en overlijden.datum geleverd

    @gba
    Abstract Scenario: met fields is gevraagd om leeftijd
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                  | waarde   |
      | geboortedatum (03.10) | 19960229 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam  | waarde          |
      | datum | <geboortedatum> |

      Voorbeelden:
      | burgerservicenummer | geboortedatum |
      | 999993653           | 19851201      |
      | 999990457           | 19950200      |
      | 999992806           | 19680000      |
      | 999995066           | 00000000      |

    @gba
    Scenario: met fields is gevraagd om leeftijd van een overleden persoon
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                  | waarde    |
      | geboortedatum (03.10) | 19960229  |
      | plaats.code           | 0599      |
      | plaats.omschrijving   | Rotterdam |
      | land.code             | 6030      |
      | land.omschrijving     | Nederland |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde       |
      | datum overlijden (08.10) | 20151001     |
      | plaats.code              |              |
      | plaats.omschrijving      | Buenos Aires |
      | land.code                | 7015         |
      | land.omschrijving        | Argentinië   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992077                       |
      | fields              | leeftijd                        |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam  | waarde   |
      | datum | 19960229 |
      En heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam  | waarde   |
      | datum | 20151001 |

  Rule: wanneer gevraagd wordt om indicatieOverleden, wordt overlijden.datum geleverd

    @gba
    Scenario: met fields is gevraagd om indicatieOverleden van een overleden persoon
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992077 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde       |
      | datum overlijden (08.10) | 20151001     |
      | plaats.code              |              |
      | plaats.omschrijving      | Buenos Aires |
      | land.code                | 7015         |
      | land.omschrijving        | Argentinië   |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999992077                       |
      | fields              | indicatieOverleden              |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam  | waarde   |
      | datum | 20151001 |

  Rule: wanneer een veld van verblijfplaats wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type verblijfplaats
    - dit betreft alle velden uit groepen 11 (adres), 12 (locatie) en land, regel 1, regel 2 en regel 3 van groep 13 (verblijf buitenland)

    @gba
    Abstract Scenario: Gevraagd veld zit in verblijfplaats
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                             |
      | functieAdres.code                          | <functieAdres>                     |
      | functieAdres.omschrijving                  | <functieAdres omschrijving>        |
      | datum aanvang adreshouding (10.20)         | <datumAanvangAdreshouding>         |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | land.code                                  | <land>                             |
      | land.omschrijving                          | <land omschrijving>                |
      | datum aanvang adres buitenland (13.20)     | <datumAanvangAdresBuitenland>      |
      | regel 1 adres buitenland (13.30)           | <regel1>                           |
      | regel 2 adres buitenland (13.40)           | <regel2>                           |
      | regel 3 adres buitenland (13.50)           | <regel3>                           |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                              |
      | type                | RaadpleegMetBurgerservicenummer     |
      | burgerservicenummer | <burgerservicenummer>               |
      | fields              | verblijfplaats.verblijfadres.straat |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                             |
      | verblijfadres.straat              | <straat>                           |
      | verblijfadres.naamOpenbareRuimte  | <straat>                           |
      | verblijfadres.huisnummer          | <huisnummer>                       |
      | verblijfadres.postcode            | <postcode>                         |
      | verblijfadres.woonplaats          | <woonplaats>                       |
      | verblijfadres.locatiebeschrijving | <locatiebeschrijving>              |
      | verblijfadres.land.code           | <land>                             |
      | verblijfadres.land.omschrijving   | <omschrijving>                     |
      | verblijfadres.regel1              | <regel1>                           |
      | verblijfadres.regel2              | <regel2>                           |
      | verblijfadres.regel3              | <regel3>                           |
      | adresseerbaarObjectIdentificatie  | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie     | <nummeraanduidingIdentificatie>    |

      Voorbeelden:
      | burgerservicenummer | functieAdres | functieAdres omschrijving | datumAanvangAdreshouding | straat    | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving        | land | land omschrijving | datumAanvangAdresBuitenland | regel1            | regel2       | regel 3 |
      | 999993653           | W            | woonadres                 | 20150808                 | Boterdiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                            |      |                   |                             |                   |              |         |
      | 000009921           |              |                           |                          |           |            |          |            |                                  |                               | Woonboot in de Grote Sloot |      |                   |                             | Locatie           |              |         |
      | 999995121           |              |                           |                          |           |            |          |            |                                  |                               |                            | 5002 | Frankrijk         |                             | 14 Rue Camulogene | 75015 Parijs |         |
      | 999993586           |              |                           |                          |           |            |          |            |                                  |                               |                            | 0000 | Onbekend          |                             |                   |              |         |

    @gba
    Abstract Scenario: met fields gevraagd om <fields>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993653 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde           |
      | functieAdres.code                          | W                |
      | functieAdres.omschrijving                  | woonadres        |
      | datum aanvang adreshouding (10.20)         | 20150808         |
      | straatnaam (11.10)                         | Boterdiep        |
      | naam openbare ruimte (11.15)               | Boterdiep        |
      | huisnummer (11.20)                         | 31               |
      | postcode (11.60)                           | 3077AW           |
      | woonplaats (11.70)                         | Rotterdam        |
      | identificatiecode verblijfplaats (11.80)   | 0599010000208579 |
      | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999993653                       |
      | fields              | <fields>                        |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                             | waarde           |
      | verblijfadres.straat             | Boterdiep        |
      | verblijfadres.naamOpenbareRuimte | Boterdiep        |
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
      | postcode                            |
      | nummeraanduidingIdentificatie       |
      | locatiebeschrijving                 |
      | woonplaats                          |
      | land                                |
      | regel1                              |

  Rule: wanneer gevraagd wordt om datumVan van de verblijfplaats, wordt datumAanvangAdreshouding of datumAanvangAdresBuitenland geleverd
    - deze datumvelden worden geleverd samen met de velden die automatisch geleverd worden omdat ze nodig zijn voor het bepalen van het type

    @gba
    Abstract Scenario: Vragen om datumVan
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                       | waarde                             |
      | functieAdres.code                          | <functieAdres>                     |
      | functieAdres.omschrijving                  | <functieAdres omschrijving>        |
      | datum aanvang adreshouding (10.20)         | <datumAanvangAdreshouding>         |
      | straatnaam (11.10)                         | <straat>                           |
      | naam openbare ruimte (11.15)               | <straat>                           |
      | huisnummer (11.20)                         | <huisnummer>                       |
      | postcode (11.60)                           | <postcode>                         |
      | woonplaats (11.70)                         | <woonplaats>                       |
      | identificatiecode verblijfplaats (11.80)   | <adresseerbaarObjectIdentificatie> |
      | identificatiecode nummeraanduiding (11.90) | <nummeraanduidingIdentificatie>    |
      | locatiebeschrijving (12.10)                | <locatiebeschrijving>              |
      | land.code                                  | <land>                             |
      | land.omschrijving                          | <land omschrijving>                |
      | datum aanvang adres buitenland (13.20)     | <datumAanvangAdresBuitenland>      |
      | regel 1 adres buitenland (13.30)           | <regel1>                           |
      | regel 2 adres buitenland (13.40)           | <regel2>                           |
      | regel 3 adres buitenland (13.50)           | <regel3>                           |
      | ingangsdatum geldigheid (85.10)            | datumIngangGeldigheid              |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | <burgerservicenummer>           |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                             |
      | verblijfadres.straat              | <straat>                           |
      | verblijfadres.naamOpenbareRuimte  | <straat>                           |
      | verblijfadres.huisnummer          | <huisnummer>                       |
      | verblijfadres.postcode            | <postcode>                         |
      | verblijfadres.woonplaats          | <woonplaats>                       |
      | verblijfadres.locatiebeschrijving | <locatiebeschrijving>              |
      | verblijfadres.land.code           | <land>                             |
      | verblijfadres.land.omschrijving   | <omschrijving>                     |
      | verblijfadres.regel1              | <regel1>                           |
      | verblijfadres.regel2              | <regel2>                           |
      | verblijfadres.regel3              | <regel3>                           |
      | adresseerbaarObjectIdentificatie  | <adresseerbaarObjectIdentificatie> |
      | nummeraanduidingIdentificatie     | <nummeraanduidingIdentificatie>    |
      | datumAanvangAdreshouding          | <datumAanvangAdreshouding>         |
      | datumAanvangAdresBuitenland       | <datumAanvangAdresBuitenland>      |

      Voorbeelden:
      | burgerservicenummer | functieAdres | functieAdres omschrijving | datumAanvangAdreshouding | straat    | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie | locatiebeschrijving        | land | land omschrijving | datumAanvangAdresBuitenland | regel1            | regel2       | regel 3 |
      | 999993653           | W            | woonadres                 | 20150808                 | Boterdiep | 31         | 3077AW   | Rotterdam  | 0599010000208579                 | 0599200000219678              |                            |      |                   |                             |                   |              |         |
      | 000009921           |              |                           |                          |           |            |          |            |                                  |                               | Woonboot in de Grote Sloot |      |                   |                             | Locatie           |              |         |
      | 999995121           |              |                           |                          |           |            |          |            |                                  |                               |                            | 5002 | Frankrijk         |                             | 14 Rue Camulogene | 75015 Parijs |         |
      | 999993586           |              |                           |                          |           |            |          |            |                                  |                               |                            | 0000 | Onbekend          |                             |                   |              |         |

  Rule: wanneer gevraagd wordt om vanuitVerblijfplaatsOnbekend, wordt landVanwaarIngeschreven geleverd

    @gba
    Abstract Scenario: met fields is gevraagd om vanuitVerblijfplaatsOnbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990160 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                 | waarde      |
      | land vanwaar ingeschreven (14.10)    | 5003        |
      | landVanwaarIngeschreven.omschrijving | Zwitserland |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
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

    @gba
    Abstract Scenario: met fields is gevraagd om indicatieVestigingVanuitBuitenland
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990160 |
      En de persoon heeft de volgende 'immigratie' gegevens
      | naam                                 | waarde      |
      | Land vanwaar ingeschreven (14.10)    | 5003        |
      | landVanwaarIngeschreven.omschrijving | Zwitserland |
      | datum vestiging in Nederland (14.20) | 19750101    |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 999990160                       |
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

    @gba
    Abstract Scenario: met fields is gevraagd om adresregel1
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
      | fields              | adresregel1                     |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                |
      | verblijfadres.straat              | <straat>              |
      | verblijfadres.huisnummer          | <huisnummer>          |
      | verblijfadres.postcode            | <postcode>            |
      | verblijfadres.locatiebeschrijving | <locatiebeschrijving> |
      | verblijfadres.regel1              | <regel1>              |

      Voorbeelden:
      | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | straat    | huisnummer | postcode | woonplaats | locatiebeschrijving        | land | land omschrijving | regel1            | regel2       | regel 3       |
      | 999993653           | 0599                    | Rotterdam                          | Boterdiep | 31         | 3077AW   | Rotterdam  |                            |      |                   |                   |              |               |
      | 000009921           | 0518                    | 's-Gravenhage                      |           |            |          |            | Woonboot in de Grote Sloot |      |                   | Locatie           |              |               |
      | 999995121           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5002 | Frankrijk         | 14 Rue Camulogene | 75015 Parijs |               |
      | 999993483           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5010 | België            | Rue du pomme 25   | Bruxelles    | postcode 1000 |
      | 999993586           |                         |                                    |           |            |          |            |                            | 0000 | Onbekend          |                   |              |               |

    @gba
    Abstract Scenario: met fields is gevraagd om adresregel2
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
      | fields              | adresregel2                     |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                 | waarde                    |
      | gemeenteVanInschrijving.code         | <gemeenteVanInschrijving> |
      | gemeenteVanInschrijving.omschrijving | <gemeente omschrijving>   |
      En heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                |
      | verblijfadres.postcode            | <postcode>            |
      | verblijfadres.woonplaats          | <woonplaats>          |
      | verblijfadres.locatiebeschrijving | <locatiebeschrijving> |
      | verblijfadres.regel2              | <regel2>              |

      Voorbeelden:
      | burgerservicenummer | gemeenteVanInschrijving | gemeente omschrijving              | straat    | huisnummer | postcode | woonplaats | locatiebeschrijving        | land | land omschrijving | regel1            | regel2       | regel 3       |
      | 999993653           | 0599                    | Rotterdam                          | Boterdiep | 31         | 3077AW   | Rotterdam  |                            |      |                   |                   |              |               |
      | 000009921           | 0518                    | 's-Gravenhage                      |           |            |          |            | Woonboot in de Grote Sloot |      |                   | Locatie           |              |               |
      | 999995121           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5002 | Frankrijk         | 14 Rue Camulogene | 75015 Parijs |               |
      | 999993483           | 1999                    | Registratie Niet Ingezetenen (RNI) |           |            |          |            |                            | 5010 | België            | Rue du pomme 25   | Bruxelles    | postcode 1000 |
      | 999993586           |                         |                                    |           |            |          |            |                            | 0000 | Onbekend          |                   |              |               |

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

  Rule: wanneer een veld van nationaliteiten wordt gevraagd, worden de velden geleverd die nodig zijn voor het bepalen van het type verblijfplaats
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
      | 999994748           |               |                            | V              | 310         | Vaststelling bijzonder Nederlanderschap         | 19750615              |                                                                                                     |
