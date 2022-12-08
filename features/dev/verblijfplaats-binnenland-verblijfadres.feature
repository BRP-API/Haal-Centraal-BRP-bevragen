# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland - verblijfadres

  Abstract Scenario: persoon heeft 'verblijfadres' veld met onbekend waarde: '<gba naam>'
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
    | gba naam           | gba waarde | naam                     |
    | straatnaam (11.10) | .          | verblijfadres.straat     |
    | huisnummer (11.20) | 0          | verblijfadres.huisnummer |
    | woonplaats (11.70) | .          | verblijfadres.woonplaats |

  Abstract Scenario: verblijfadres veld(en) van persoon is/zijn in onderzoek
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
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 000000152                                |
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
    | naam                | waarde                                   |
    | type                | RaadpleegMetBurgerservicenummer          |
    | burgerservicenummer | 000000152                                |
    | fields              | verblijfplaats.verblijfadres.inOnderzoek |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080920                  |

  Abstract Scenario: 'aanduiding bij huisnummer (11.50)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                              | waarde |
    | gemeente_code                     | 0518   |
    | aanduiding bij huisnummer (11.50) | to     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                               |
    | type                | RaadpleegMetBurgerservicenummer                      |
    | burgerservicenummer | 000000152                                            |
    | fields              | verblijfplaats.verblijfadres.aanduidingBijHuisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.aanduidingBijHuisnummer.code                 | to          |
    | verblijfadres.aanduidingBijHuisnummer.omschrijving         | tegenover   |
    | verblijfadres.inOnderzoek.aanduidingBijHuisnummer          | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081150                  |

  Abstract Scenario: 'huisletter (11.30)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | huisletter (11.30) | a      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisletter |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.huisletter                                   | a           |
    | verblijfadres.inOnderzoek.huisletter                       | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081130                  |

  Abstract Scenario: 'huisnummer (11.20)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | huisnummer (11.20) | 33     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.huisnummer                                   | 33          |
    | verblijfadres.inOnderzoek.huisnummer                       | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081120                  |

  Abstract Scenario: 'huisnummertoevoeging (11.40)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                         | waarde |
    | gemeente_code                | 0518   |
    | huisnummertoevoeging (11.40) | 2      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000152                                         |
    | fields              | verblijfplaats.verblijfadres.huisnummertoevoeging |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.huisnummertoevoeging                         | 2           |
    | verblijfadres.inOnderzoek.huisnummertoevoeging             | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081140                  |

  Abstract Scenario: 'naam openbare ruimte (11.15)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                         | waarde |
    | gemeente_code                | 0518   |
    | naam openbare ruimte (11.15) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.straat |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.straat                                       | Spui        |
    | verblijfadres.inOnderzoek.straat                           | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081110                  |
    | 081115                  |

  Abstract Scenario: 'postcode (11.60)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam             | waarde |
    | gemeente_code    | 0518   |
    | postcode (11.60) | 1234AA |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | verblijfplaats.verblijfadres.postcode |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.postcode                                     | 1234AA      |
    | verblijfadres.inOnderzoek.postcode                         | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081160                  |

  Abstract Scenario: 'straatnaam (11.10)' is in onderzoek
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
    | naam                | waarde                                 |
    | type                | RaadpleegMetBurgerservicenummer        |
    | burgerservicenummer | 000000152                              |
    | fields              | verblijfplaats.verblijfadres.korteNaam |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.korteNaam                                    | Spui        |
    | verblijfadres.inOnderzoek.korteNaam                        | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 081100                  |
    | 081110                  |

  Abstract Scenario: 'woonplaats (11.70)' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde  |
    | gemeente_code      | 0518    |
    | woonplaats (11.70) | Utrecht |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.woonplaats |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                                       | waarde      |
    | type                                                       | Adres       |
    | verblijfadres.woonplaats                                   | Utrecht     |
    | verblijfadres.inOnderzoek.woonplaats                       | true        |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | verblijfadres.inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080000                  |
    | 080900                  |
    | 080910                  |
    | 081100                  |
    | 081170                  |

  Abstract Scenario: 'aanduiding bij huisnummer (11.50)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                              | waarde |
    | gemeente_code                     | 0518   |
    | aanduiding bij huisnummer (11.50) | to     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisletter |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081150                  |

  Abstract Scenario: 'huisletter (11.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | huisletter (11.30) | a      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081130                  |

  Abstract Scenario: 'huisnummer (11.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde |
    | gemeente_code      | 0518   |
    | huisnummer (11.20) | 33     |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000152                                         |
    | fields              | verblijfplaats.verblijfadres.huisnummertoevoeging |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081120                  |

  Abstract Scenario: 'huisnummertoevoeging (11.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                         | waarde |
    | gemeente_code                | 0518   |
    | huisnummertoevoeging (11.40) | 2      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.straat |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081140                  |

  Abstract Scenario: 'naam openbare ruimte (11.15)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                         | waarde |
    | gemeente_code                | 0518   |
    | naam openbare ruimte (11.15) | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | verblijfplaats.verblijfadres.postcode |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081110                  |
    | 081115                  |

  Abstract Scenario: 'postcode (11.60)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam             | waarde |
    | gemeente_code    | 0518   |
    | postcode (11.60) | 1234AA |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.straat |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081160                  |

  Abstract Scenario: 'straatnaam (11.10)' is in onderzoek, maar wordt niet gevraagd
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
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.woonplaats |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 081110                  |

  Abstract Scenario: 'woonplaats (11.70)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam               | waarde  |
    | gemeente_code      | 0518    |
    | woonplaats (11.70) | Utrecht |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                               |
    | type                | RaadpleegMetBurgerservicenummer                      |
    | burgerservicenummer | 000000152                                            |
    | fields              | verblijfplaats.verblijfadres.aanduidingBijHuisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

    Voorbeelden:
    | gba in onderzoek waarde |
    | 080900                  |
    | 080910                  |
    | 081170                  |
