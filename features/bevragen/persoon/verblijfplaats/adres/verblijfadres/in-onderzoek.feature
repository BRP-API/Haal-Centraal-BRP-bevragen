# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) - verblijfadres velden zijn in onderzoek

Rule: Het in onderzoek zijn van een veld en bijbehorende datumIngangOnderzoek worden geleverd als het betreffende veld wordt gevraagd

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfadres velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0518   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde         |
    | type                                         | Adres          |
    | inOnderzoek.type                             | <type io>      |
    | inOnderzoek.datumIngangOnderzoek.type        | <datum type>   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat> |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde                   |
    | korteNaam                                    | Spui                     |
    | inOnderzoek.aanduidingBijHuisnummer          | <aanduidingBijHuisnr io> |
    | inOnderzoek.huisletter                       | <huisletter io>          |
    | inOnderzoek.huisnummer                       | <huisnr io>              |
    | inOnderzoek.huisnummertoevoeging             | <huisnrtoevoeging io>    |
    | inOnderzoek.korteNaam                        | <korteNaam io>           |
    | inOnderzoek.straat                           | <straat io>              |
    | inOnderzoek.postcode                         | <postcode io>            |
    | inOnderzoek.woonplaats                       | <woonplaats io>          |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | aanduiding in onderzoek | aanduidingBijHuisnr io | huisletter io | huisnr io | huisnrtoevoeging io | straat io | postcode io | korteNaam io | woonplaats io | type io | datum type | datum      | lang formaat | type                          |
    | 080000                  | true                   | true          | true      | true                | true      | true        | true         | true          | true    | Datum      | 2002-07-01 | 1 juli 2002  | hele categorie verblijfplaats |
    | 081100                  | true                   | true          | true      | true                | true      | true        | true         | true          | true    | Datum      | 2002-07-01 | 1 juli 2002  |                               |
    | 081110                  |                        |               |           |                     | true      |             | true         |               | true    | Datum      | 2002-07-01 | 1 juli 2002  |                               |
    | 081115                  |                        |               |           |                     | true      |             |              |               |         |            |            |              |                               |
    | 081120                  |                        |               | true      |                     |           |             |              |               |         |            |            |              |                               |
    | 081130                  |                        | true          |           |                     |           |             |              |               |         |            |            |              |                               |
    | 081140                  |                        |               |           | true                |           |             |              |               |         |            |            |              |                               |
    | 081150                  | true                   |               |           |                     |           |             |              |               |         |            |            |              |                               |
    | 081160                  |                        |               |           |                     |           | true        |              |               |         |            |            |              |                               |
    | 081170                  |                        |               |           |                     |           |             |              | true          |         |            |            |              |                               |

  Scenario: 'aanduiding bij huisnummer (11.50)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 081150   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisletter |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'huisletter (11.30)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 081130   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.huisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'huisnummer (11.20)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 081120   |
    | datum ingang onderzoek (83.20)  | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                            |
    | type                | RaadpleegMetBurgerservicenummer                   |
    | burgerservicenummer | 000000152                                         |
    | fields              | verblijfplaats.verblijfadres.huisnummertoevoeging |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'huisnummertoevoeging (11.40)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | aanduiding in onderzoek (83.10)    | 081140   |
    | datum ingang onderzoek (83.20)     | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.straat |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'naam openbare ruimte (11.15)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | aanduiding in onderzoek (83.10)    | 081115   |
    | datum ingang onderzoek (83.20)     | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | verblijfplaats.verblijfadres.postcode |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'postcode (11.60)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | aanduiding in onderzoek (83.10)    | 081160   |
    | datum ingang onderzoek (83.20)     | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.straat |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'straatnaam (11.10)' is in onderzoek, maar wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | aanduiding in onderzoek (83.10)    | 081110   |
    | datum ingang onderzoek (83.20)     | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                  |
    | type                | RaadpleegMetBurgerservicenummer         |
    | burgerservicenummer | 000000152                               |
    | fields              | verblijfplaats.verblijfadres.woonplaats |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Adres       |
    | inOnderzoek.type                             | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Scenario: 'woonplaats (11.70)' is in onderzoek, maar 'woonplaats' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20220128 |
    | aanduiding in onderzoek (83.10)    | 081170   |
    | datum ingang onderzoek (83.20)     | 20020701 |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                               |
    | type                | RaadpleegMetBurgerservicenummer                      |
    | burgerservicenummer | 000000152                                            |
    | fields              | verblijfplaats.verblijfadres.aanduidingBijHuisnummer |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

Rule: 'type' veld van 'verblijfplaats binnenland (adres)' is in onderzoek als het identificerende gegeven van adres ('straatnaam (11.10)') in onderzoek is

  Abstract Scenario: '<type>' veld is in onderzoek en postcode wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde |
    | gemeentecode (92.10) | 0519   |
    | straatnaam (11.10)   | Spui   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000152                             |
    | fields              | verblijfplaats.verblijfadres.postcode |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                                         | waarde      |
    | type                                         | Adres       |
    | inOnderzoek.type                             | true        |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002 |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde         |
    | inOnderzoek.postcode                         | <postcode io>  |
    | inOnderzoek.datumIngangOnderzoek.type        | <datum type>   |
    | inOnderzoek.datumIngangOnderzoek.datum       | <datum>        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | <lang formaat> |

  Voorbeelden:
    | aanduiding in onderzoek | postcode io | datum type | datum      | lang formaat | type                          |
    | 080000                  | true        | Datum      | 2002-07-01 | 1 juli 2002  | hele categorie verblijfplaats |
    | 081100                  | true        | Datum      | 2002-07-01 | 1 juli 2002  | hele groep adres              |
    | 081110                  |             |            |            |              | straatnaam                    |
