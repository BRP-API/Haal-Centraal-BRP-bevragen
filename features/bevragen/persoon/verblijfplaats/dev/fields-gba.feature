#language: nl

Functionaliteit: GBA verblijfplaats - vragen van velden met fields

  Om het type van een verblijfplaats af te kunnen leiden moet ook het identificerende gegeven van de verblijfplaats type worden geleverd

Rule: wanneer één of meerdere velden van een adres wordt gevraagd, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

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
    | verblijfplaats.verblijfadres                                    | huisnummer               | 31            |                   |               |                           |               |
    | verblijfplaats.datumVan,verblijfplaats.verblijfadres.huisnummer | datumAanvangAdreshouding | 20150808      | huisnummer        | 31            |                           |               |
    | verblijfplaats.verblijfadres.regel1                             |                          |               |                   |               |                           |               |

Rule: wanneer één of meerdere velden van een locatie wordt gevraagd, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

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

Rule: wanneer één of meerdere velden van een verblijfplaats buitenland wordt gevraagd, dan wordt ook de waarde van 'land adres buitenland (13.10)' geleverd

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

Rule: wanneer één of meerdere velden van een adres wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

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
    | verblijfplaatsBinnenland.verblijfadres.regel1                                       |                          |               |                   |               |                           |               |

Rule: wanneer één of meerdere velden van een locatie wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

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
    | verblijfplaatsBinnenland.verblijfadres.regel1                                                |                          |               |                   |               |                           |               |

Rule: wanneer één of meerdere velden van een verblijfplaats buitenland wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt geen enkel verblijfplaats gegeven geleverd

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
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                                                                              |
    | verblijfplaatsBinnenland                                                            |
    | verblijfplaatsBinnenland.type                                                       |
    | verblijfplaatsBinnenland.datumVan                                                   |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.functieAdres             |
    | verblijfplaatsBinnenland.verblijfadres                                              |
    | verblijfplaatsBinnenland.datumVan,verblijfplaatsBinnenland.verblijfadres.huisnummer |
    | verblijfplaatsBinnenland.verblijfadres.regel1                                       |
