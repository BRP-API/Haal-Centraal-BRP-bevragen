# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en datumVan, datumIngangGeldigheid, functieAdres, adresseerbaarObjectIdentificatie en nummeraanduidingIdentificatie worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
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
    | gba in onderzoek waarde | type io | datumVan io | datumIngangGeldigheid io | nummeraanduidingIdentificatie io | adresseerbaarObjectIdentificatie io | functieAdres io | type                          |
    | 080000                  | true    | true        | true                     | true                             | true                                | true            | hele categorie verblijfplaats |
    | 081000                  |         | true        |                          |                                  |                                     | true            | hele groep adreshouding       |
    | 081010                  |         |             |                          |                                  |                                     | true            |                               |
    | 081030                  |         | true        |                          |                                  |                                     |                 | datum aanvang adreshouding    |
    | 081100                  | true    |             |                          | true                             | true                                |                 |                               |
    | 081180                  |         |             |                          |                                  | true                                |                 |                               |
    | 081190                  |         |             |                          | true                             |                                     |                 |                               |
    | 081300                  | true    | true        |                          |                                  |                                     |                 |                               |
    | 081320                  |         | true        |                          |                                  |                                     |                 |                               |
    | 088500                  |         |             | true                     |                                  |                                     |                 |                               |
    | 088510                  |         |             | true                     |                                  |                                     |                 |                               |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumVan' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde | type                       |
    | 081000                  | hele groep adreshouding    |
    | 081030                  | datum aanvang adreshouding |

  Abstract Scenario: '<type>' is in onderzoek, maar 'datumIngangGeldigheid' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | verblijfplaats.nummeraanduidingIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde | type                    |
    | 088500                  | hele groep geldigheid   |
    | 088510                  | datum ingang geldigheid |

  Abstract Scenario: '<type>' is in onderzoek, maar 'functieAdres' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
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
    | gba in onderzoek waarde | type                    |
    | 081000                  | hele groep adreshouding |
    | 081010                  | functie adres           |

  Abstract Scenario: '<type>' is in onderzoek, maar 'nummeraanduidingIdentificatie' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                          |
    | type                | RaadpleegMetBurgerservicenummer                 |
    | burgerservicenummer | 000000152                                       |
    | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde | type                               |
    | 081100                  | hele groep adres                   |
    | 081190                  | identificatiecode nummeraanduiding |

  Abstract Scenario: '<type>' is in onderzoek, maar 'adresseerbaarObjectIdentificatie' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
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

    Voorbeelden:
    | gba in onderzoek waarde | type                             |
    | 081100                  | hele groep adres                 |
    | 081180                  | identificatiecode verblijfplaats |
