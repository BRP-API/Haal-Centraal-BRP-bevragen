#language: nl

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
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999999321           |

  Scenario: Zoek met meerdere valide burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321,999999322,999999323   |
    | fields              | burgerservicenummer             |
    Dan bevat de response alleen personen met de volgende gegevens 
    | burgerservicenummer |
    | 999999321           |
    | 999999322           |
    | 999999323           |

  @fout-case
  Scenario: Zoek zonder burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                          |
    | type   | RaadpleegMetBurgerservicenummer |
    | fields | burgerservicenummer             |
    Dan bevat de response de volgende gegevens
    | naam     | waarde                                              |
    | title    | Een of meerdere parameters zijn niet correct.       |
    | status   | 400                                                 |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer. |
    | code     | paramsValidation                                    |
    | instance | /personen                                           |
    En bevat de response een invalidParams met de volgende gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | <burgerservicenummers>          |
    | fields              | burgerservicenummer             |
    Dan bevat de response de volgende gegevens
    | naam     | waarde                                        |
    | title    | Één of meerdere parameters zijn niet correct. |
    | status   | 400                                           |
    | detail   | TODO                                          |
    | code     | TODO                                          |
    | instance | TODO                                          |
    En bevat de response een invalidParams met de volgende gegevens
    | code   | name                | reason   |
    | <code> | burgerservicenummer | <reason> |

    Voorbeelden:
    | burgerservicenummers | titel                                   | code     | reason |
    |                      | Zoek met leeg burgerservicenummer lijst | minItems | TODO   |
    | 1234567890           | Zoek met ongeldig burgerservicenummer   | pattern  | TODO   |

Rule: Er mag maximaal 20 burgerservicenummers worden opgegeven

  @fout-case
  Scenario: Zoek met meer dan 20 burgerservicenummers
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                                                                                                                                                            |
    | type                | RaadpleegMetBurgerservicenummer                                                                                                                                                                                   |
    | burgerservicenummer | 999999321,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802,999995492,999991802 |
    | fields              | burgerservicenummer                                                                                                                                                                                               |
    Dan bevat de response de volgende gegevens
    | naam     | waarde                                        |
    | title    | Één of meerdere parameters zijn niet correct. |
    | status   | 400                                           |
    | detail   | TODO                                          |
    | code     | TODO                                          |
    | instance | TODO                                          |
    En bevat de response een invalidParams met de volgende gegevens
    | code     | name                | reason |
    | maxItems | burgerservicenummer | TODO   |
