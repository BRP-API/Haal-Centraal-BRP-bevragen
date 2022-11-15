#language: nl

Functionaliteit: Raadpleeg met burgerservicenummer - fout cases

Rule: Er moet minimaal één burgerservicenummer worden opgegeven

  @fout-case
  Scenario: De burgerservicenummer parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                          |
    | type   | RaadpleegMetBurgerservicenummer |
    | fields | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummers>          |
    | fields              | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | <detail>                                                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason   |
    | <code> | <name> | <reason> |

    Voorbeelden:
    | burgerservicenummers | titel                                                                   | detail                                                 | code     | name                   | reason                                      |
    |                      | De burgerservicenummer parameter is leeg                                | De foutieve parameter(s) zijn: burgerservicenummer.    | minItems | burgerservicenummer    | Array bevat minder dan 1 items.             |
    | 1234567890           | De burgerservicenummer parameter bevat een ongeldig burgerservicenummer | De foutieve parameter(s) zijn: burgerservicenummer[0]. | pattern  | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

  @fout-case
  Scenario: De burgerservicenummer parameter bevat meerdere ongeldige burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 1234567890,123456789,1234567890 |
    | fields              | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                         |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                    |
    | title    | Een of meerdere parameters zijn niet correct.                                  |
    | status   | 400                                                                            |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer[0], burgerservicenummer[2]. |
    | code     | paramsValidation                                                               |
    | instance | /haalcentraal/api/brp/personen                                                 |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                   | reason                                      |
    | pattern | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |
    | pattern | burgerservicenummer[2] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

  @fout-case
  Scenario: De burgerservicenummer parameter is geen lijst van burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                             | waarde                          |
    | type                             | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer (als string) | 999994086                       |
    | fields                           | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name                | reason                   |
    | array | burgerservicenummer | Parameter is geen array. |

Rule: Er mag maximaal 20 burgerservicenummers worden opgegeven

  @fout-case
  Scenario: De burgerservicenummer parameter bevat meer dan 20 burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                                   |
    | burgerservicenummer | 999999321,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802 |
    | fields              | burgerservicenummer                                                                                                                                                                                               |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                         |
    | maxItems | burgerservicenummer | Array bevat meer dan 20 items. |
