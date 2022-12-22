# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld met onbekend waarde: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                         | waarde       |
    | gemeente_code                | 0518         |
    | naam openbare ruimte (11.15) | Spui         |
    | <gba naam>                   | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba naam                                   | gba waarde       | naam                             |
    | identificatiecode verblijfplaats (11.80)   | 0000000000000000 | adresseerbaarObjectIdentificatie |
    | identificatiecode nummeraanduiding (11.90) | 0000000000000000 | nummeraanduidingIdentificatie    |

  Abstract Scenario: niet-verblijfplaats binnenland veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080900                  |
    | 080910                  |
    | 080920                  |
    | 081110                  |
    | 081115                  |

  Abstract Scenario: 'datum aanvang adreshouding (10.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.datumVan         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde          |
    | type                                         | Adres           |
    | datumVan.type                                | Datum           |
    | datumVan.datum                               | 2022-01-28      |
    | datumVan.langFormaat                         | 28 januari 2022 |
    | inOnderzoek.datumVan                         | true            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002     |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081000                  |
    | 081030                  |
    | 081300                  |
    | 081320                  |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | datum ingang geldigheid (85.10) | 20220222                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                               |
    | type                | RaadpleegMetBurgerservicenummer      |
    | burgerservicenummer | 000000152                            |
    | fields              | verblijfplaats.datumIngangGeldigheid |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde           |
    | type                                         | Adres            |
    | datumIngangGeldigheid.type                   | Datum            |
    | datumIngangGeldigheid.datum                  | 2022-02-22       |
    | datumIngangGeldigheid.langFormaat            | 22 februari 2022 |
    | inOnderzoek.datumIngangGeldigheid            | true             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 088500                  |
    | 088510                  |

  Abstract Scenario: 'identificatiecode nummeraanduiding (11.90)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                                       | waarde           |
    | gemeente_code                              | 0518             |
    | straatnaam (11.10)                         | Spui             |
    | identificatiecode nummeraanduiding (11.90) | 0599200000219678 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000152                                    |
    | fields              | verblijfplaats.nummeraanduidingIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde           |
    | type                                         | Adres            |
    | nummeraanduidingIdentificatie                | 0599200000219678 |
    | inOnderzoek.nummeraanduidingIdentificatie    | true             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081190                  |

  Abstract Scenario: 'identificatiecode verblijfplaats (11.80)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                                     | waarde           |
    | gemeente_code                            | 0518             |
    | straatnaam (11.10)                       | Spui             |
    | identificatiecode verblijfplaats (11.80) | 0599010000208579 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                          |
    | type                | RaadpleegMetBurgerservicenummer                 |
    | burgerservicenummer | 000000152                                       |
    | fields              | verblijfplaats.adresseerbaarObjectIdentificatie |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde           |
    | type                                         | Adres            |
    | adresseerbaarObjectIdentificatie             | 0599010000208579 |
    | inOnderzoek.adresseerbaarObjectIdentificatie | true             |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum            |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01       |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002      |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081180                  |

  Abstract Scenario: 'functie adres (10.10)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | functie adres (10.10)           | W                         |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | straatnaam (11.10) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.functieAdres     |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Adres       |
    | functieAdres.code                            | W           |
    | functieAdres.omschrijving                    | woonadres   |
    | inOnderzoek.functieAdres                     | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081000                  |
    | 081010                  |
