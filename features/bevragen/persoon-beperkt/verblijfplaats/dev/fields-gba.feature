#language: nl

Functionaliteit: GBA verblijfplaats - vragen van velden met fields

  Om het type van een verblijfplaats af te kunnen leiden moet ook het identificerende gegeven van de verblijfplaats type worden geleverd

Rule: wanneer één of meerdere velden van een adres wordt gevraagd, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Abstract Scenario: alle velden of één of meerdere velden van een adres wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | straat                    | Spui      |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats                           |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |

  Scenario: adres wordt gevraagd met field pad 'verblijfplaats.type'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats.type                 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde |
    | straat | Spui   |

Rule: wanneer één of meerdere velden van een locatie wordt gevraagd, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Abstract Scenario: alle velden of één of meerdere velden van een locatie wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde                      |
    | locatiebeschrijving       | Woonboot bij de Grote Sloot |
    | functieAdres.code         | W                           |
    | functieAdres.omschrijving | woonadres                   |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats                           |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |

  Scenario: locatie wordt gevraagd met field pad 'verblijfplaats.type'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats.type                 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |

Rule: wanneer één of meerdere velden van een verblijfplaats buitenland wordt gevraagd, dan wordt ook de waarde van 'land adres buitenland (13.10)' geleverd

  Scenario: alle velden van een verblijfplaats buitenland wordt gevraagd met field pad 'verblijfplaats'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats                      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

  Scenario: verblijfplaats buitenland wordt gevraagd met field pad 'verblijfplaats.type'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaats.type                 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

Rule: wanneer één of meerdere velden van een adres wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Abstract Scenario: één of meerdere velden van een adres wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde    |
    | straat                    | Spui      |
    | functieAdres.code         | W         |
    | functieAdres.omschrijving | woonadres |

    Voorbeelden:
    | fields                                             |
    | verblijfplaatsBinnenland                           |
    | verblijfplaatsBinnenland.functieAdres              |
    | verblijfplaatsBinnenland.functieAdres.code         |
    | verblijfplaatsBinnenland.functieAdres.omschrijving |

  Scenario: adres wordt gevraagd met field pad 'verblijfplaatsBinnenland.type'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | Spui   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaatsBinnenland.type       |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde |
    | straat | Spui   |

Rule: wanneer één of meerdere velden van een locatie wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Abstract Scenario: één of meerdere velden van een locatie wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                      | waarde                      |
    | locatiebeschrijving       | Woonboot bij de Grote Sloot |
    | functieAdres.code         | W                           |
    | functieAdres.omschrijving | woonadres                   |

    Voorbeelden:
    | fields                                             |
    | verblijfplaatsBinnenland                           |
    | verblijfplaatsBinnenland.functieAdres              |
    | verblijfplaatsBinnenland.functieAdres.code         |
    | verblijfplaatsBinnenland.functieAdres.omschrijving |

  Scenario: locatie wordt gevraagd met field pad 'verblijfplaatsBinnenland.type'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | verblijfplaatsBinnenland.type       |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |

Rule: Een persoon heeft een verblijfplaats zonder gegevens/leeg verblijfplaats object wanneer de verblijfplaatsBinnenland field alias wordt gebruikt en de persoon heeft een verblijfplaats buitenland of verblijfplaats onbekend

  Abstract Scenario: de persoon heeft een verblijfplaats buitenland en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | 6014   |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon zonder 'verblijfplaats' gegevens

    Voorbeelden:
    | fields                                |
    | verblijfplaatsBinnenland              |
    | verblijfplaatsBinnenland.functieAdres |
    | verblijfplaatsBinnenland.type         |

Rule: als één of meerdere (gegevensgroep) velden van een verblijfplaats wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

  Abstract Scenario: '<type>' van een adres is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
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
    | aanduiding in onderzoek | fields                                                 | type                          |
    | 080000                  | verblijfplaats                                         | hele categorie verblijfplaats |
    | 081100                  | verblijfplaats.functieAdres                            | hele groep adres              |
    | 081150                  | verblijfplaats.type                                    | aanduiding bij huisnummer     |
    | 081130                  | verblijfplaats.functieAdres,verblijfplaats.inOnderzoek | huisletter                    |
    | 081160                  | verblijfplaats                                         | postcode                      |
    | 081020                  | verblijfplaats.type                                    | gemeentedeel                  |
    | 080910                  | verblijfplaats                                         | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.functieAdres                            | land vanwaar ingeschreven     |

  Abstract Scenario: '<type>' van een locatie is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                      |
    | locatiebeschrijving                       | Woonboot bij de Grote Sloot |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek>   |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                    |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                                 | type                          |
    | 080000                  | verblijfplaats                                         | hele categorie verblijfplaats |
    | 081200                  | verblijfplaats.type                                    | hele groep locatie            |
    | 081210                  | verblijfplaats.functieAdres                            | locatiebeschrijving           |
    | 088510                  | verblijfplaats                                         | datum ingang geldigheid       |
    | 081020                  | verblijfplaats.type                                    | gemeentedeel                  |
    | 080910                  | verblijfplaats                                         | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.functieAdres,verblijfplaats.inOnderzoek | land vanwaar ingeschreven     |

  Abstract Scenario: '<type>' van een verblijfplaats buitenland is in onderzoek en één of meerdere velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | land adres buitenland (13.10)   | 6014                      |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                      | waarde                       |
    | land.code                                 | 6014                         |
    | land.omschrijving                         | Verenigde Staten van Amerika |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek>    |
    | inOnderzoek.datumIngangOnderzoek          | 20020701                     |

    Voorbeelden:
    | aanduiding in onderzoek | fields                                         | type                          |
    | 080000                  | verblijfplaats                                 | hele categorie verblijfplaats |
    | 081300                  | verblijfplaats.type                            | hele groep adres buitenland   |
    | 081310                  | verblijfplaats                                 | land adres buitenland         |
    | 081340                  | verblijfplaats.type                            | regel 2 adres buitenland      |
    | 081020                  | verblijfplaats                                 | gemeentedeel                  |
    | 080910                  | verblijfplaats                                 | gemeente van inschrijving     |
    | 081410                  | verblijfplaats.type,verblijfplaats.inOnderzoek | land vanwaar ingeschreven     |
