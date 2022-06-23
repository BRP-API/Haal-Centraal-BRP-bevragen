# language: nl

@proxy @post-assert
Functionaliteit: verblijfplaats binnenland

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 555550001                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde   |
    | type                 | Adres    |
    | verblijfadres.<naam> | <waarde> |

    Voorbeelden:
    | gba naam                          | naam                         | waarde        |
    | straatnaam (11.10)                | korteNaam                    | Spui          |
    | naam openbare ruimte (11.15)      | straat                       | Spui          |
    | huisnummer (11.20)                | huisnummer                   | 123           |
    | huisletter (11.30)                | huisletter                   | a             |
    | huisnummertoevoeging (11.40)      | huisnummertoevoeging         | 2             |
    | aanduiding bij huisnummer (11.50) | aanduidingBijHuisnummer.code | to            |
    | postcode (11.60)                  | postcode                     | 1234AA        |
    | woonplaatsnaam (11.70)            | woonplaats                   | 's-Gravenhage |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde   |
    | straatnaam (11.10) | Spui     |
    | <gba naam>         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam   | waarde   |
    | type   | Adres    |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                                   | naam                             | waarde           |
    | functie adres (10.10)                      | functieAdres.code                | W                |
    | identificatiecode verblijfplaats (11.80)   | adresseerbaarObjectIdentificatie | 0599010000208579 |
    | identificatiecode nummeraanduiding (11.90) | nummeraanduidingIdentificatie    | 0599200000219678 |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam               | waarde       |
    | straatnaam (11.10) | Spui         |
    | <gba naam>         | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam               | waarde         |
    | type               | Adres          |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                           | gba waarde | naam                  | waarde     | lang formaat     |
    | datum aanvang adreshouding (10.30) | 20220128   | datumVan              | 2022-01-28 | 28 januari 2022  |
    | datum ingang geldigheid (85.10)    | 20220222   | datumIngangGeldigheid | 2022-02-22 | 22 februari 2022 |

  Abstract Scenario: persoon heeft 'verblijfplaats binnenland' veld met onbekend waarde: '<gba naam>'
      Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                         | waarde       |
    | naam openbare ruimte (11.15) | Spui         |
    | <gba naam>                   | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.<naam>           |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba naam                                 | gba waarde       | naam                             |
    | straatnaam (11.10)                       | .                | verblijfadres.straat             |
    | huisnummer (11.20)                       | 0                | verblijfadres.huisnummer         |
    | woonplaatsnaam (11.70)                   | .                | verblijfadres.woonplaats         |
    | adresseerbaarObjectIdentificatie (11.80) | 0000000000000000 | adresseerbaarObjectIdentificatie |
    | nummeraanduidingIdentificatie (11.90)    | 0000000000000000 | nummeraanduidingIdentificatie    |

  Abstract Scenario: adres veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | straatnaam (11.10)                       | Spui                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | verblijfplaats.inOnderzoek      |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde                                          |
    | type                                         | Adres                                           |
    | inOnderzoek.type                             | <type in onderzoek>                             |
    | inOnderzoek.datumVan                         | <datumVan in onderzoek>                         |
    | inOnderzoek.datumIngangGeldigheid            | <datumIngangGeldigheid in onderzoek>            |
    | inOnderzoek.nummeraanduidingIdentificatie    | <nummeraanduidingIdentificatie in onderzoek>    |
    | inOnderzoek.adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie in onderzoek> |
    | inOnderzoek.functieAdres                     | <functieAdres in onderzoek>                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                     |

    Voorbeelden:
    | gba in onderzoek waarde | type in onderzoek | datumVan in onderzoek | datumIngangGeldigheid in onderzoek | nummeraanduidingIdentificatie in onderzoek | adresseerbaarObjectIdentificatie in onderzoek | functieAdres in onderzoek |
    | 080000                  |                   | true                  | true                               | true                                       | true                                          | true                      |
    | 081000                  |                   | true                  |                                    |                                            |                                               | true                      |
    | 081010                  |                   |                       |                                    |                                            |                                               | true                      |
    | 081030                  |                   | true                  |                                    |                                            |                                               |                           |
    | 081100                  |                   |                       |                                    | true                                       | true                                          |                           |
    | 081180                  |                   |                       |                                    |                                            | true                                          |                           |
    | 081190                  |                   |                       |                                    | true                                       |                                               |                           |
    | 081300                  |                   | true                  |                                    |                                            |                                               |                           |
    | 081320                  |                   | true                  |                                    |                                            |                                               |                           |
    | 088500                  |                   |                       | true                               |                                            |                                               |                           |
    | 088510                  |                   |                       | true                               |                                            |                                               |                           |

  Abstract Scenario: niet-adres veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | straatnaam (11.10)                       | Spui                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
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

  Abstract Scenario: verblijfadres veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | straatnaam (11.10)                       | Spui                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 555550001                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde                             |
    | type                                                       | Adres                              |
    | verblijfadres.inOnderzoek.aanduidingBijHuisnummer          | <aanduidingBijHuisnr in onderzoek> |
    | verblijfadres.inOnderzoek.huisletter                       | <huisletter in onderzoek>          |
    | verblijfadres.inOnderzoek.huisnummer                       | <huisnr in onderzoek>              |
    | verblijfadres.inOnderzoek.huisnummertoevoeging             | <huisnrtoevoeging in onderzoek>    |
    | verblijfadres.inOnderzoek.straat                           | <straat in onderzoek>              |
    | verblijfadres.inOnderzoek.postcode                         | <postcode in onderzoek>            |
    | verblijfadres.inOnderzoek.korteNaam                        | <korteNaam in onderzoek>           |
    | verblijfadres.inOnderzoek.woonplaats                       | <woonplaats in onderzoek>          |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum                              |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                         |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                        |

    Voorbeelden:
    | gba in onderzoek waarde | aanduidingBijHuisnr in onderzoek | huisletter in onderzoek | huisnr in onderzoek | huisnrtoevoeging in onderzoek | straat in onderzoek | postcode in onderzoek | korteNaam in onderzoek | woonplaats in onderzoek |
    | 080000                  | true                             | true                    | true                | true                          | true                | true                  | true                   | true                    |
    | 080900                  |                                  |                         |                     |                               |                     |                       |                        | true                    |
    | 080910                  |                                  |                         |                     |                               |                     |                       |                        | true                    |
    | 081100                  | true                             | true                    | true                | true                          | true                | true                  | true                   | true                    |
    | 081110                  |                                  |                         |                     |                               | true                |                       | true                   |                         |
    | 081115                  |                                  |                         |                     |                               | true                |                       |                        |                         |
    | 081120                  |                                  |                         | true                |                               |                     |                       |                        |                         |
    | 081130                  |                                  | true                    |                     |                               |                     |                       |                        |                         |
    | 081140                  |                                  |                         |                     | true                          |                     |                       |                        |                         |
    | 081150                  | true                             |                         |                     |                               |                     |                       |                        |                         |
    | 081160                  |                                  |                         |                     |                               |                     | true                  |                        |                         |
    | 081170                  |                                  |                         |                     |                               |                     |                       |                        | true                    |

  Abstract Scenario: niet-verblijfadres veld(en) van persoon is/zijn in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                                     | waarde                    |
    | straatnaam (11.10)                       | Spui                      |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 555550001                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080920                  |
