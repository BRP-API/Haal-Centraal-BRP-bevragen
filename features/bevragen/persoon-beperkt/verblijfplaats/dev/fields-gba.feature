#language: nl

Functionaliteit: GBA verblijfplaats - vragen van velden met fields

  Om het type van een verblijfplaats af te kunnen leiden moet ook het identificerende gegeven van de verblijfplaats type worden geleverd

Rule: wanneer één of meerdere te bevragen velden van adres beperkt wordt gevraagd, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Abstract Scenario: alle adres beperkt velden of één of meerdere velden van een adres beperkt wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | Spui   |
    | huisnummer (11.20)   | 123    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam     | waarde     |
    | straat   | Spui       |
    | <veld 1> | <waarde 1> |
    | <veld 2> | <waarde 2> |

    Voorbeelden:
    | fields                                   | veld 1            | waarde 1 | veld 2                    | waarde 2  |
    | verblijfplaats                           | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.type                      |                   |          |                           |           |
    | verblijfplaats.functieAdres              | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.code         | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.omschrijving | functieAdres.code | W        | functieAdres.omschrijving | woonadres |

  @fout-case
  Abstract Scenario: fields parameter bevat een niet-adres beperkt field pad
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                              |
    | verblijfplaats.datumVan             |
    | verblijfplaats.verblijfadres.straat |
    
Rule: wanneer één of meerdere te bevragen velden van locatie beperkt wordt gevraagd, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Abstract Scenario: alle locatie beperkt velden of één of meerdere velden van een locatie beperkt wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
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
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |
    | <veld 1>            | <waarde 1>                  |
    | <veld 2>            | <waarde 2>                  |

    Voorbeelden:
    | fields                                   | veld 1            | waarde 1 | veld 2                    | waarde 2  |
    | verblijfplaats                           | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.type                      |                   |          |                           |           |
    | verblijfplaats.functieAdres              | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.code         | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.omschrijving | functieAdres.code | W        | functieAdres.omschrijving | woonadres |

  @fout-case
  Abstract Scenario: fields parameter bevat een niet-locatie beperkt field pad
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                                           |
    | verblijfplaats.datumIngangGeldigheid             |
    | verblijfplaats.verblijfadres.locatiebeschrijving |

Rule: wanneer één of meerdere te bevragen velden van verblijfplaats buitenland beperkt wordt gevraagd, dan wordt ook de waarde van 'land adres buitenland (13.10)' geleverd

  Abstract Scenario: alle verblijfplaats buitenland beperkt velden wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                      |
    | datum aanvang adres buitenland (13.20) | 20150808                    |
    | land adres buitenland (13.10)          | 6014                        |
    | regel 1 adres buitenland (13.30)       | 1600 Pennsylvania Avenue NW |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                                   |
    | verblijfplaats                           |
    | verblijfplaats.type                      |
    | verblijfplaats.functieAdres              |
    | verblijfplaats.functieAdres.code         |
    | verblijfplaats.functieAdres.omschrijving |

  @fout-case
  Abstract Scenario: fields parameter bevat een niet verblijfplaats buitenland beperkt field pad
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                              |
    | verblijfplaats.datumVan             |
    | verblijfplaats.verblijfadres.regel1 |

Rule: wanneer één of meerdere te bevragen velden van adres beperkt wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'straatnaam (11.10)' geleverd

  Abstract Scenario: alle adres beperkt of één of meerdere velden van een adres beperkt wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    | huisnummer (11.20)   | 123    |
    Als gba personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | <fields>                            |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam     | waarde     |
    | straat   | Spui       |
    | <veld 1> | <waarde 1> |
    | <veld 2> | <waarde 2> |

    Voorbeelden:
    | fields                                             | veld 1            | waarde 1 | veld 2                    | waarde 2  |
    | verblijfplaatsBinnenland                           | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaatsBinnenland.type                      |                   |          |                           |           |
    | verblijfplaatsBinnenland.functieAdres              | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaatsBinnenland.functieAdres.code         | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaatsBinnenland.functieAdres.omschrijving | functieAdres.code | W        | functieAdres.omschrijving | woonadres |

  @fout-case
  Scenario: fields parameter bevat de verblijfplaatsBinnenland variant van een niet-adres beperkt field pad
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                                        |
    | verblijfplaatsBinnenland.datumVan             |
    | verblijfplaatsBinnenland.verblijfadres.straat |

Rule: wanneer één of meerdere velden van locatie beperkt wordt gevraagd met de field alias verblijfplaatsBinnenland, dan wordt ook de waarde van 'locatiebeschrijving (12.10)' geleverd

  Abstract Scenario: alle loctie beperkt velden of één of meerdere velden van een locatie beperkt wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | functie adres (10.10)              | W        |
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
    | naam                | waarde                      |
    | locatiebeschrijving | Woonboot bij de Grote Sloot |
    | <veld 1>            | <waarde 1>                  |
    | <veld 2>            | <waarde 2>                  |

    Voorbeelden:
    | fields                                   | veld 1            | waarde 1 | veld 2                    | waarde 2  |
    | verblijfplaats                           | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.type                      |                   |          |                           |           |
    | verblijfplaats.functieAdres              | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.code         | functieAdres.code | W        | functieAdres.omschrijving | woonadres |
    | verblijfplaats.functieAdres.omschrijving | functieAdres.code | W        | functieAdres.omschrijving | woonadres |

  @fout-case
  Abstract Scenario: fields parameter bevat de verblijfplaatsBinnenland variant van een niet-locatie beperkt field pad
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                                                     |
    | verblijfplaatsBinnenland.datumIngangGeldigheid             |
    | verblijfplaatsBinnenland.verblijfadres.locatiebeschrijving |

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

Rule: als één of meerdere velden van een verblijfplaats wordt gevraagd en de categorie verblijfplaats (08) heeft in onderzoek gegevens, dan worden deze ook geleverd

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
