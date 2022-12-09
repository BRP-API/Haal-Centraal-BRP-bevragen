# language: nl

Functionaliteit: Persoon: verblijfplaats binnenland (adres) - verblijfadres velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle verblijfadres velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | aanduiding in onderzoek (83.10)    | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                              | waarde        |
    | gemeentecode (92.10)              | 0518          |
    | straatnaam (11.10)                | Spui          |
    | naam openbare ruimte (11.15)      | Spui          |
    | huisnummer (11.20)                | 123           |
    | huisletter (11.30)                | a             |
    | huisnummertoevoeging (11.40)      | 2             |
    | aanduiding bij huisnummer (11.50) | to            |
    | postcode (11.60)                  | 1234AA        |
    | woonplaats (11.70)                | 's-Gravenhage |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam                                         | waarde                   |
    | aanduidingBijHuisnummer.code                 | to                       |
    | aanduidingBijHuisnummer.omschrijving         | tegenover                |
    | huisletter                                   | a                        |
    | huisnummer                                   | 123                      |
    | huisnummertoevoeging                         | 2                        |
    | korteNaam                                    | Spui                     |
    | straat                                       | Spui                     |
    | postcode                                     | 1234AA                   |
    | woonplaats                                   | 's-Gravenhage            |
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
    | aanduiding in onderzoek | aanduidingBijHuisnr io | huisletter io | huisnr io | huisnrtoevoeging io | straat io | postcode io | korteNaam io | woonplaats io | type                          |
    | 080000                  | true                   | true          | true      | true                | true      | true        | true         | true          | hele categorie verblijfplaats |
    | 080900                  |                        |               |           |                     |           |             |              | true          |                               |
    | 080910                  |                        |               |           |                     |           |             |              | true          |                               |
    | 081100                  | true                   | true          | true      | true                | true      | true        | true         | true          |                               |
    | 081110                  |                        |               |           |                     | true      |             | true         |               |                               |
    | 081115                  |                        |               |           |                     | true      |             |              |               |                               |
    | 081120                  |                        |               | true      |                     |           |             |              |               |                               |
    | 081130                  |                        | true          |           |                     |           |             |              |               |                               |
    | 081140                  |                        |               |           | true                |           |             |              |               |                               |
    | 081150                  | true                   |               |           |                     |           |             |              |               |                               |
    | 081160                  |                        |               |           |                     |           | true        |              |               |                               |
    | 081170                  |                        |               |           |                     |           |             |              | true          |                               |

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
    | naam | waarde |
    | type | Adres  |
    En heeft de 'verblijfplaats' geen 'verblijfadres' gegevens

  Abstract Scenario: '<type>' is in onderzoek, maar 'woonplaats' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde                    |
    | datum aanvang adreshouding (10.30) | 20220128                  |
    | aanduiding in onderzoek (83.10)    | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
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

    Voorbeelden:
    | aanduiding in onderzoek | type                      |
    | 080900                  | hele groep gemeente       |
    | 080910                  | gemeente van inschrijving |
    | 081170                  | woonplaatsnaam            |
