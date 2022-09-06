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
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |

  Scenario: Zoek met meerdere valide burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321,999999322,999999323   |
    | fields              | burgerservicenummer             |
    Dan heeft de response 3 personen
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999321 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999322 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999999323 |

  @fout-case
  Scenario: Zoek zonder burgerservicenummers
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
    | burgerservicenummers | titel                                   | detail                                                 | code     | name                   | reason                                      |
    |                      | Zoek met leeg burgerservicenummer lijst | De foutieve parameter(s) zijn: burgerservicenummer.    | minItems | burgerservicenummer    | Array bevat minder dan 1 items.             |
    | 1234567890           | Zoek met ongeldig burgerservicenummer   | De foutieve parameter(s) zijn: burgerservicenummer[0]. | pattern  | burgerservicenummer[0] | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

  @fout-case
  Scenario: burgerservicenummer parameter is geen array
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

  @fout-case
  Scenario: Zoek met meerdere ongeldige burgerservicenummers
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

Rule: Er mag maximaal 20 burgerservicenummers worden opgegeven

  @fout-case
  Scenario: Zoek met meer dan 20 burgerservicenummers
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


Rule: bij raadplegen van een persoon op burgerservicenummer kan ook een opgeschorte persoonslijst worden geraadpleegd
  - inclusief een afgevoerde persoonslijst 

  Abstract Scenario: Raadpleeg persoon op opgeschorte persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) |
    | 000000024                   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | R                            | pl is aangelegd in de rni      |
    | F                            | fout                           |
    | .                            | onbekend                       |
