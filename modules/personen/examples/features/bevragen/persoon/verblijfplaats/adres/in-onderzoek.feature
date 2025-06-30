# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) velden zijn in onderzoek

Regel: Het in onderzoek zijn van een veld en bijbehorende datumIngangOnderzoek worden geleverd als het betreffende veld wordt gevraagd

  Abstract Scenario: '<type>' is in onderzoek en alle adres velden excl. verblijfadres velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                       |
    | burgerservicenummer | 000000152                                                                                                                                                                             |
    | fields              | verblijfplaats.datumVan,verblijfplaats.datumIngangGeldigheid,verblijfplaats.functieAdres,verblijfplaats.adresseerbaarObjectIdentificatie,verblijfplaats.nummeraanduidingIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' de volgende 'inOnderzoek' gegevens
    | naam                             | waarde                                |
    | type                             | <type io>                             |
    | datumVan                         | <datumVan io>                         |
    | datumIngangGeldigheid            | <datumIngangGeldigheid io>            |
    | nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie io>    |
    | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie io> |
    | functieAdres                     | <functieAdres io>                     |
    | datumIngangOnderzoek.type        | Datum                                 |
    | datumIngangOnderzoek.datum       | 2002-07-01                            |
    | datumIngangOnderzoek.langFormaat | 1 juli 2002                           |

    Voorbeelden:
    | aanduiding in onderzoek | type io | datumVan io | datumIngangGeldigheid io | nummeraanduidingIdentificatie io | adresseerbaarObjectIdentificatie io | functieAdres io | type                               |
    | 080000                  | true    | true        | true                     | true                             | true                                | true            | hele categorie verblijfplaats      |
    | 081000                  |         | true        |                          |                                  |                                     | true            | hele groep adreshouding            |
    | 081010                  |         |             |                          |                                  |                                     | true            | functie adres                      |
    | 081030                  |         | true        |                          |                                  |                                     |                 | datum aanvang adreshouding         |
    | 081100                  | true    |             |                          | true                             | true                                |                 | hele groep adres                   |
    | 081180                  |         |             |                          |                                  | true                                |                 | identificatiecode verblijfplaats   |
    | 081190                  |         |             |                          | true                             |                                     |                 | identificatiecode nummeraanduiding |
    | 088500                  |         |             | true                     |                                  |                                     |                 | hele groep geldigheid              |
    | 088510                  |         |             | true                     |                                  |                                     |                 | datum ingang geldigheid            |

  Abstract Scenario: '<type>' is in onderzoek, maar <reden>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | aanduiding in onderzoek | type         | reden                                                       |
    | 081020                  | gemeentedeel | is geen veld van verblijfplaats binnenland (adres) resource |
    | 081120                  | huisnummer   | wordt niet gevraagd                                         |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | aanduiding in onderzoek | type                               | veld naam                        | gevraagde fields                                |
    | 081030                  | datum aanvang adreshouding         | datumVan                         | verblijfplaats.datumIngangGeldigheid            |
    | 081010                  | functie adres                      | functieAdres                     | verblijfplaats.datumVan                         |
    | 081180                  | identificatiecode verblijfplaats   | adresseerbaarObjectIdentificatie | verblijfplaats.functieAdres                     |
    | 081190                  | identificatiecode nummeraanduiding | nummeraanduidingIdentificatie    | verblijfplaats.adresseerbaarObjectIdentificatie |
    | 088500                  | hele groep geldigheid              | datumIngangGeldigheid            | verblijfplaats.nummeraanduidingIdentificatie    |
    | 088510                  | datum ingang geldigheid            | datumIngangGeldigheid            | verblijfplaats.nummeraanduidingIdentificatie    |

Regel: 'type' veld van 'verblijfplaats binnenland (adres)' is in onderzoek als het identificerende gegeven van adres ('straatnaam (11.10)') in onderzoek is

  Abstract Scenario: '<type>' veld is in onderzoek en functieAdres wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' de volgende 'inOnderzoek' gegevens
    | naam                             | waarde            |
    | type                             | true              |
    | functieAdres                     | <functieAdres io> |
    | datumIngangOnderzoek.type        | Datum             |
    | datumIngangOnderzoek.datum       | 2002-07-01        |
    | datumIngangOnderzoek.langFormaat | 1 juli 2002       |

    Voorbeelden:
    | aanduiding in onderzoek | functieAdres io | type                          |
    | 080000                  | true            | hele categorie verblijfplaats |
    | 081100                  |                 | hele groep adres              |
    | 081110                  |                 | straatnaam                    |
