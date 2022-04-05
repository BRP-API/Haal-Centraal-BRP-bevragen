#language: nl

@ready @post-assert
Functionaliteit: Zoek met burgerservicenummer(s)

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999999321           |
    | 999999322           |
    | 999999323           |
    | 999999324           |
    | 999999325           |

Rule: Er moet minimaal één burgerservicenummer worden opgegeven

  Scenario: Zoek met valide burgerservicenummer
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response 1 persoon
    En heeft de persoon met burgerservicenummer '999999321' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |

  Scenario: Zoek met meerdere valide burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321,999999322,999999323   |
    | fields              | burgerservicenummer             |
    Dan heeft de response 3 personen
    En heeft de persoon met burgerservicenummer '999999321' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |
    En heeft de persoon met burgerservicenummer '999999322' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999322 |
    En heeft de persoon met burgerservicenummer '999999323' de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999323 |

  @fout-case
  Scenario: Zoek zonder burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                          |
    | type   | RaadpleegMetBurgerservicenummer |
    | fields | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                                                   |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.                                                         |
    | code     | paramsCombination                                                                                           |
    | instance | /haalcentraal/api/brp/personen                                                                              |
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
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | <detail>                                                                                                    |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name   | reason   |
    | <code> | <name> | <reason> |

    Voorbeelden:
    | burgerservicenummers | titel                                   | detail                                                 | code     | name                   | reason                                      |
    |                      | Zoek met leeg burgerservicenummer lijst | De foutieve parameter(s) zijn: burgerservicenummer.    | minItems | burgerservicenummer    | Array bevat minder dan 1 items.             |
    | 1234567890           | Zoek met ongeldig burgerservicenummer   | De foutieve parameter(s) zijn: burgerservicenummer[0]. | pattern  | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

  @fout-case
  Scenario: Zoek met meerdere ongeldige burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 1234567890,123456789,1234567890 |
    | fields              | burgerservicenummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer[0], burgerservicenummer[2].                              |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                   | reason                                      |
    | pattern | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |
    | pattern | burgerservicenummer[2] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

Rule: Er mag maximaal 20 burgerservicenummers worden opgegeven

  @fout-case
  Scenario: Zoek met meer dan 20 burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                                   |
    | burgerservicenummer | 999999321,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802 |
    | fields              | burgerservicenummer                                                                                                                                                                                               |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                                                      |
    | type     | https://docs.microsoft.com/en-us/dotnet/api/system.net.httpstatuscode?#System_Net_HttpStatusCode_BadRequest |
    | title    | Een of meerdere parameters zijn niet correct.                                                               |
    | status   | 400                                                                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.                                                         |
    | code     | paramsValidation                                                                                            |
    | instance | /haalcentraal/api/brp/personen                                                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                         |
    | maxItems | burgerservicenummer | Array bevat meer dan 20 items. |
