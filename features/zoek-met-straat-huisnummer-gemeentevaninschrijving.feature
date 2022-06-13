#language: nl

@post-assert
Functionaliteit: Zoek met straat, huisnummer en gemeente van inschrijving

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer | gemeente van inschrijving (09.10) |
    | 999993653           | 0599                              |
    | 999993914           | 0693                              |
    | 999991230           | 0518                              |
    | 999991231           | 0518                              |
    | 999990160           | 0344                              |
    | 999994402           | 0363                              |
    | 999993008           | 0363                              |
    | 999993009           | 0363                              |
    | 999990159           | 0518                              |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
    | 999993653           | Boterdiep                |                              | 31                 |                    |                              |
    | 999993914           | A                        |                              | 13                 |                    |                              |
    | 999991230           | Leyweg                   |                              | 61                 |                    |                              |
    | 999991231           | Leyweg                   |                              | 61                 | e                  |                              |
    | 999990160           | St. Jacobsstraat         |                              | 400                | L                  | Toe                          |
    | 999994402           | Vitternkade              |                              | 101                |                    | II                           |
    | 999993008           | Afrikanerplein           |                              | 1                  |                    |                              |
    | 999993009           | Afrikanerplein           |                              | 1                  |                    |                              |
    | 999990159           | Ln Copes van Cattenburch | Laan Copes van Cattenburch   | 38                 |                    |                              |
    En het systeem heeft personen met de volgende 'overlijden' gegevens
    | burgerservicenummer | datum overlijden (08.10) |
    | 999993008           | 20080700                 |

  Rule: Straat, huisnummer en gemeente van inschrijving zijn verplichte parameters
        Zoeken is niet hoofdlettergevoelig
  
    Abstract Scenario: Zoek met volledige straat, huisnummer en gemeente van inschrijving
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | <straat>                                         |
      | huisnummer              | 31                                               |
      | gemeenteVanInschrijving | 0599                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993653 |

      Voorbeelden:
      | straat    |
      | Boterdiep |
      | boterdiep |
      | BOTERDIEP |

    Scenario: Zoek met straat van één karakter lang
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | a                                                |
      | huisnummer              | 13                                               |
      | gemeenteVanInschrijving | 0693                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993914 |

    Scenario: Zoek met naam openbare ruimte
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | Laan Copes van Cattenburch                       |
      | huisnummer              | 38                                               |
      | gemeenteVanInschrijving | 0518                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990159 |

    Abstract Scenario: Zoek met huisletter
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | leyweg                                           |
      | huisnummer              | 61                                               |
      | gemeenteVanInschrijving | 0518                                             |
      | huisletter              | <huisletter>                                     |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999991231 |

      Voorbeelden:
      | huisletter |
      | e          |
      | E          |

    Abstract Scenario: Zoek met huisnummertoevoeging
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | <straat>                                         |
      | huisnummer              | <huisnummer>                                     |
      | gemeenteVanInschrijving | <gemeente van inschrijving>                      |
      | huisnummertoevoeging    | <huisnummer toevoeging>                          |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |

      Voorbeelden:
      | burgerservicenummer | gemeente van inschrijving | straat           | huisnummer | huisnummer toevoeging | opmerking                            |
      | 999990160           | 0344                      | St. Jacobsstraat | 400        | Toe                   | verblijfplaats heeft ook huisletter  |
      | 999990160           | 0344                      | St. Jacobsstraat | 400        | TOE                   | verblijfplaats heeft ook huisletter  |
      | 999994402           | 0363                      | Vitternkade      | 101        | II                    | verblijfplaats heeft geen huisletter |
      | 999994402           | 0363                      | Vitternkade      | 101        | ii                    | verblijfplaats heeft geen huisletter |

    @fout-case
    Scenario: Zoek zonder straat, huisnummer en gemeente van inschrijving
      Als personen wordt gezocht met de volgende parameters
      | naam   | waarde                                           |
      | type   | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | fields | burgerservicenummer                              |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
      | title    | Minimale combinatie van parameters moet worden opgegeven.                   |
      | status   | 400                                                                         |
      | detail   | De foutieve parameter(s) zijn: straat, huisnummer, gemeenteVanInschrijving. |
      | code     | paramsCombination                                                           |
      | instance | /haalcentraal/api/brp/personen                                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                    | reason                  |
      | required | straat                  | Parameter is verplicht. |
      | required | huisnummer              | Parameter is verplicht. |
      | required | gemeenteVanInschrijving | Parameter is verplicht. |

    @fout-case
    Scenario: Zoek met lege straat, huisnummer en gemeente van inschrijving
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | fields                  | burgerservicenummer                              |
      | straat                  |                                                  |
      | huisnummer              |                                                  |
      | gemeenteVanInschrijving |                                                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
      | title    | Minimale combinatie van parameters moet worden opgegeven.                   |
      | status   | 400                                                                         |
      | detail   | De foutieve parameter(s) zijn: straat, huisnummer, gemeenteVanInschrijving. |
      | code     | paramsCombination                                                           |
      | instance | /haalcentraal/api/brp/personen                                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                    | reason                  |
      | required | straat                  | Parameter is verplicht. |
      | required | huisnummer              | Parameter is verplicht. |
      | required | gemeenteVanInschrijving | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: <titel>
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | fields                  | burgerservicenummer                              |
      | straat                  | <straat>                                         |
      | huisnummer              | 1                                                |
      | gemeenteVanInschrijving | 0518                                             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: straat.                      |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name   | reason                                                                                                                                 |
      | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

      Voorbeelden:
      | titel                                | straat                                                                                                    |
      | Straat is meer dan 80 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
      | Straat bevat ongeldige karakters     | <script>alert('hello world');</script>                                                                    |

    @fout-case
    Scenario: Zoek met invalide huisnummer
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | fields                  | burgerservicenummer                              |
      | straat                  | leyweg                                           |
      | huisnummer              | twee                                             |
      | gemeenteVanInschrijving | 0518                                             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: huisnummer.                  |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name       | reason                       |
      | integer | huisnummer | Waarde is geen geldig getal. |

  Rule: Overleden personen worden standaard niet geretourneerd

    Scenario: Zoek exclusief overleden personen 
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | Afrikanerplein                                   |
      | huisnummer                 | 1                                                |
      | gemeenteVanInschrijving    | 0363                                             |
      | inclusiefOverledenPersonen | false                                            |
      | fields                     | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993009 |

    Scenario: Zoek exclusief overleden personen 
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                                           |
      | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                  | Afrikanerplein                                   |
      | huisnummer              | 1                                                |
      | gemeenteVanInschrijving | 0363                                             |
      | fields                  | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993009 |

    Scenario: Zoek inclusief overleden personen
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | Afrikanerplein                                   |
      | huisnummer                 | 1                                                |
      | gemeenteVanInschrijving    | 0363                                             |
      | inclusiefOverledenPersonen | true                                             |
      | fields                     | burgerservicenummer                              |
      Dan heeft de response 2 personen
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993008 |
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993009 |

    @fout-case
    Abstract Scenario: Zoek met ongeldig inclusiefOverledenPersonen parameter
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | Afrikanerplein                                   |
      | huisnummer                 | 1                                                |
      | gemeenteVanInschrijving    | 0363                                             |
      | fields                     | burgerservicenummer                              |
      | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: inclusiefOverledenPersonen.  |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code   | name                       | reason   |
      | <code> | inclusiefOverledenPersonen | <reason> |

      Voorbeelden:
      | inclusief overleden personen | code    | reason                  |
      |                              | boolean | Waarde is geen boolean. |
      | geen boolean                 | boolean | Waarde is geen boolean. |

  Rule: Bij zoeken met de "*" wildcard moet minimaal 7 letters (exclusief de wildcard teken) worden opgegeven
        De "*" wildcard komt overeen met nul of meer (niet-spatie) karakters

    Abstract Scenario: Zoek met "*" wildcard als laatste karakter in straat
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | <straat>                                         |
      | huisnummer                 | 38                                               |
      | gemeenteVanInschrijving    | 0518                                             |
      | fields                     | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990159 |

      Voorbeelden:
      | straat   |
      | ln cope* |
      | laan co* |

    Scenario: Zoek met "*" wildcard als eerste karakter in straat
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | *enburch                                         |
      | huisnummer                 | 38                                               |
      | gemeenteVanInschrijving    | 0518                                             |
      | fields                     | burgerservicenummer                              |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990159 |

    @fout-case
    Abstract Scenario: Zoek met ongeldige straat wildcard
      Als personen wordt gezocht met de volgende parameters
      | naam                       | waarde                                           |
      | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
      | straat                     | *van Ock*                                        |
      | huisnummer                 | 38                                               |
      | gemeenteVanInschrijving    | 0518                                             |
      | fields                     | burgerservicenummer                              |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: straat.                      |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name   | reason                                                                                                                                 |
      | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

    Voorbeelden:
    | straat     | reden                                                   |
    | *van Ock*  | wildcard als eerste en laatste karakter in straat       |
    | Laan * van | wildcard is niet eerste of laatste karakter in straat   |
    | Laan*      | straat bevat niet het minimum aantal vereiste karakters |
    