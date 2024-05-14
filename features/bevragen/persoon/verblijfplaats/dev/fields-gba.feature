#language: nl

@gba
Functionaliteit: verblijfplaats velden vragen met fields (persoon)

  Om het type van een verblijfplaats af te kunnen leiden moet ook het identificerende gegeven van de verblijfplaats type worden geleverd

Regel: wanneer één of meerdere velden van een adres wordt gevraagd, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Scenario: alle velden van een adres wordt gevraagd met field pad 'verblijfplaats'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde   |
    | datumAanvangAdreshouding | 20150808 |
    | straat                   | Spui     |

  Abstract Scenario: één of meerdere velden van een adres wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    | huisnummer (11.20)   | 31     |
    | huisletter (11.30)   | a      |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam          | waarde          |
    | straat        | Spui            |
    | <naam veld 1> | <waarde veld 1> |
    | <naam veld 2> | <waarde veld 2> |
    | <naam veld 3> | <waarde veld 3> |

    Voorbeelden:
    | fields                                                          | naam veld 1              | waarde veld 1 | naam veld 2       | waarde veld 2 | naam veld 3               | waarde veld 3 |
    | verblijfplaats.type                                             |                          |               |                   |               |                           |               |
    | verblijfplaats.datumVan                                         | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |
    | verblijfplaats.datumVan,verblijfplaats.functieAdres             | datumAanvangAdreshouding | 20150808      | functieAdres.code | W             | functieAdres.omschrijving | woonadres     |
    | verblijfplaats.verblijfadres                                    | huisnummer               | 31            | huisletter        | a             |                           |               |
    | verblijfplaats.datumVan,verblijfplaats.verblijfadres.huisnummer | datumAanvangAdreshouding | 20150808      | huisnummer        | 31            |                           |               |
    | verblijfplaats.verblijfadres.regel1                             |                          |               |                   |               |                           |               |
    | verblijfplaats.verblijfadres.huisletter                         | huisletter               | a             |                   |               |                           |               |
    
Regel: wanneer één of meerdere velden van een locatie wordt gevraagd, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Scenario: alle velden van een locatie wordt gevraagd met field pad 'verblijfplaats'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0519                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde                      |
    | datumAanvangAdreshouding | 20150808                    |
    | locatiebeschrijving      | Woonboot bij de Grote Sloot |

  Abstract Scenario: één of meerdere velden van een locatie wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0519                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |
    | <naam veld 1>       | <waarde veld 1>             |
    | <naam veld 2>       | <waarde veld 2>             |
    | <naam veld 3>       | <waarde veld 3>             |

    Voorbeelden:
    | fields                                                                   | naam veld 1              | waarde veld 1 | naam veld 2       | waarde veld 2 | naam veld 3               | waarde veld 3 |
    | verblijfplaats.type                                                      |                          |               |                   |               |                           |               |
    | verblijfplaats.datumVan                                                  | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |
    | verblijfplaats.datumVan,verblijfplaats.functieAdres                      | datumAanvangAdreshouding | 20150808      | functieAdres.code | W             | functieAdres.omschrijving | woonadres     |
    | verblijfplaats.verblijfadres                                             |                          |               |                   |               |                           |               |
    | verblijfplaats.datumVan,verblijfplaats.verblijfadres.locatiebeschrijving | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |
    | verblijfplaats.verblijfadres.regel1                                      |                          |               |                   |               |                           |               |

Regel: wanneer één of meerdere velden van een verblijfplaats buitenland wordt gevraagd, dan wordt ook de waarde van 'land adres buitenland (13.10)' geleverd

  Scenario: alle velden van een verblijfplaats buitenland wordt gevraagd met field pad 'verblijfplaats'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde   |
    | datum aanvang adres buitenland (13.20) | 20150808 |
    | land adres buitenland (13.10)          | 6014     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                       |
    | datumAanvangAdresBuitenland | 20150808                     |
    | land.code                   | 6014                         |
    | land.omschrijving           | Verenigde Staten van Amerika |

  Abstract Scenario: één of meerdere velden van een verblijfplaats buitenland wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                      |
    | datum aanvang adres buitenland (13.20) | 20150808                    |
    | land adres buitenland (13.10)          | 6014                        |
    | regel 1 adres buitenland (13.30)       | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40)       | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50)       | Selangor                    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |
    | <naam veld 1>     | <waarde veld 1>              |
    | <naam veld 2>     | <waarde veld 2>              |
    | <naam veld 3>     | <waarde veld 3>              |

    Voorbeelden:
    | fields                                                          | naam veld 1                 | waarde veld 1               | naam veld 2 | waarde veld 2        | naam veld 3 | waarde veld 3 |
    | verblijfplaats.type                                             |                             |                             |             |                      |             |               |
    | verblijfplaats.datumVan                                         | datumAanvangAdresBuitenland | 20150808                    |             |                      |             |               |
    | verblijfplaats.datumVan,verblijfplaats.functieAdres             | datumAanvangAdresBuitenland | 20150808                    |             |                      |             |               |
    | verblijfplaats.verblijfadres                                    | regel1                      | 1600 Pennsylvania Avenue NW | regel2      | Washington, DC 20500 | regel3      | Selangor      |
    | verblijfplaats.datumVan,verblijfplaats.verblijfadres.huisnummer | datumAanvangAdresBuitenland | 20150808                    |             |                      |             |               |
    | verblijfplaats.verblijfadres.regel1                             | regel1                      | 1600 Pennsylvania Avenue NW |             |                      |             |               |

Regel: wanneer één of meerdere velden van een adres wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Scenario: alle velden van een adres wordt gevraagd met field pad 'verblijfplaatsBinnenland'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaatsBinnenland        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde   |
    | datumAanvangAdreshouding | 20150808 |
    | straat                   | Spui     |

  Abstract Scenario: één of meerdere velden van een adres wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    | huisnummer (11.20)   | 31     |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam          | waarde          |
    | straat        | Spui            |
    | <naam veld 1> | <waarde veld 1> |
    | <naam veld 2> | <waarde veld 2> |
    | <naam veld 3> | <waarde veld 3> |

    Voorbeelden:
    | fields                                                                              | naam veld 1              | waarde veld 1 | naam veld 2       | waarde veld 2 | naam veld 3               | waarde veld 3 |
    | verblijfplaatsBinnenland.type                                                       |                          |               |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan                                                   | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.functieAdres             | datumAanvangAdreshouding | 20150808      | functieAdres.code | W             | functieAdres.omschrijving | woonadres     |
    | verblijfplaatsBinnenland.verblijfadres                                              | huisnummer               | 31            |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres.huisnummer | datumAanvangAdreshouding | 20150808      | huisnummer        | 31            |                           |               |

  Abstract Scenario: <fields> wordt gevraagd en levert alle verblijfadres velden met een waarde
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    | datum ingang geldigheid (85.10)    | 20150808 |
    | gemeente van inschrijving (09.10)  | 0519     |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                                       | waarde                    |
    | gemeentecode (92.10)                       | 0519                      |
    | straatnaam (11.10)                         | Spui                      |
    | naam openbare ruimte (11.15)               | Burgemeester aan het Spui |
    | huisnummer (11.20)                         | 70                        |
    | huisletter (11.30)                         | A                         |
    | huisnummertoevoeging (11.40)               | 2                         |
    | aanduiding bij huisnummer (11.50)          | to                        |
    | postcode (11.60)                           | 1234AB                    |
    | woonplaats (11.70)                         | Den Haag                  |
    | identificatiecode verblijfplaats (11.80)   | 0519020000012345          |
    | identificatiecode nummeraanduiding (11.90) | 0519200000012345          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                 | waarde                    |
    | straat                               | Spui                      |
    | naamOpenbareRuimte                   | Burgemeester aan het Spui |
    | huisnummer                           | 70                        |
    | huisletter                           | A                         |
    | huisnummertoevoeging                 | 2                         |
    | aanduidingBijHuisnummer.code         | to                        |
    | aanduidingBijHuisnummer.omschrijving | tegenover                 |
    | postcode                             | 1234AB                    |
    | woonplaats                           | Den Haag                  |

    Voorbeelden:
    | fields                                 |
    | verblijfplaats.verblijfadres           |
    | verblijfplaatsBinnenland.verblijfadres |

Regel: wanneer één of meerdere velden van een locatie wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Scenario: alle velden van een locatie wordt gevraagd met field pad 'verblijfplaatsBinnenland'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0519                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaatsBinnenland        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                     | waarde                      |
    | datumAanvangAdreshouding | 20150808                    |
    | locatiebeschrijving      | Woonboot bij de Grote Sloot |

  Abstract Scenario: één of meerdere velden van een locatie wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0519                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |
    | <naam veld 1>       | <waarde veld 1>             |
    | <naam veld 2>       | <waarde veld 2>             |
    | <naam veld 3>       | <waarde veld 3>             |

    Voorbeelden:
    | fields                                                                                       | naam veld 1              | waarde veld 1 | naam veld 2       | waarde veld 2 | naam veld 3               | waarde veld 3 |
    | verblijfplaatsBinnenland.type                                                                |                          |               |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan                                                            | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.functieAdres                      | datumAanvangAdreshouding | 20150808      | functieAdres.code | W             | functieAdres.omschrijving | woonadres     |
    | verblijfplaatsBinnenland.verblijfadres                                                       |                          |               |                   |               |                           |               |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving | datumAanvangAdreshouding | 20150808      |                   |               |                           |               |

Regel: Een persoon heeft een verblijfplaats zonder gegevens/leeg verblijfplaats object wanneer de verblijfplaatsBinnenland field alias wordt gebruikt en de persoon heeft een verblijfplaats buitenland of verblijfplaats onbekend

  Abstract Scenario: de persoon heeft een verblijfplaats buitenland en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                      |
    | datum aanvang adres buitenland (13.20) | 20150808                    |
    | land adres buitenland (13.10)          | 6014                        |
    | regel 1 adres buitenland (13.30)       | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40)       | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50)       | Selangor                    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder 'verblijfplaats' gegevens

    Voorbeelden:
    | fields                                                                              |
    | verblijfplaatsBinnenland                                                            |
    | verblijfplaatsBinnenland.type                                                       |
    | verblijfplaatsBinnenland.datumVan                                                   |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.functieAdres             |
    | verblijfplaatsBinnenland.verblijfadres                                              |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres.huisnummer |

Regel: als één of meerdere (gegevensgroep) velden van een verblijfplaats wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' van een adres is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                    |
    | straat                                    | Spui                      |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                                        | type                          |
    | 080000                  | verblijfplaats                                                                | hele categorie verblijfplaats |
    | 081100                  | verblijfplaats                                                                | hele groep adres              |
    | 081150                  | verblijfplaats.verblijfadres                                                  | aanduiding bij huisnummer     |
    | 081130                  | verblijfplaats.datumVan                                                       | huisletter                    |
    | 081160                  | verblijfplaats.verblijfadres.postcode,verblijfplaats.verblijfadres.huisnummer | postcode                      |
    | 081020                  | verblijfplaats.nummeraanduidingIdentificatie                                  | gemeentedeel                  |
    | 080910                  | verblijfplaats                                                                | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.verblijfadres                                                  | land vanwaar ingeschreven     |

  Abstract Scenario: '<type>' van een locatie is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0519                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                      |
    | locatiebeschrijving                       | Woonboot bij de Grote Sloot |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                    |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                                                | type                          |
    | 080000                  | verblijfplaats                                                                        | hele categorie verblijfplaats |
    | 081200                  | verblijfplaats                                                                        | hele groep locatie            |
    | 081210                  | verblijfplaats.verblijfadres                                                          | locatiebeschrijving           |
    | 088510                  | verblijfplaats.verblijfadres.locatiebeschrijving,verblijfplaats.datumIngangGeldigheid | datum ingang geldigheid       |
    | 081020                  | verblijfplaats.verblijfadres.locatiebeschrijving                                      | gemeentedeel                  |
    | 080910                  | verblijfplaats                                                                        | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.verblijfadres                                                          | land vanwaar ingeschreven     |

  Abstract Scenario: '<type>' van een verblijfplaats buitenland is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                       |
    | land.code                                 | 6014                         |
    | land.omschrijving                         | Verenigde Staten van Amerika |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek>    |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                     |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                                  | type                          |
    | 080000                  | verblijfplaats                                                          | hele categorie verblijfplaats |
    | 081300                  | verblijfplaats                                                          | hele groep adres buitenland   |
    | 081310                  | verblijfplaats.verblijfadres                                            | land adres buitenland         |
    | 081340                  | verblijfplaats.verblijfadres.regel1,verblijfplaats.verblijfadres.regel2 | regel 2 adres buitenland      |
    | 081020                  | verblijfplaats.verblijfadres.regel3                                     | gemeentedeel                  |
    | 080910                  | verblijfplaats                                                          | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.verblijfadres                                            | land vanwaar ingeschreven     |
