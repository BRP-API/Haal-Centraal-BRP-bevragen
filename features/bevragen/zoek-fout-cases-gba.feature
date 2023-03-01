#language: nl

@gba
Functionaliteit: Zoeken

Rule: Er moet een valide zoek type worden opgegeven

  @fout-case
  Scenario: zoek zonder opgeven van parameters
    Als gba personen wordt gezocht met de volgende parameters
    | naam | waarde |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek zonder opgeven van 'type' parameter
    Als gba personen wordt gezocht met de volgende parameters
    | naam     | waarde |
    | postcode | 3077AW |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek met lege type 
    Als gba personen wordt gezocht met de volgende parameters
    | naam | waarde |
    | type |        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

  @fout-case
  Abstract Scenario: zoek met ongeldige type waarde
    Als gba personen wordt gezocht met de volgende parameters
    | naam | waarde |
    | type | <type> |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

    Voorbeelden:
    | omschrijving               | type                                |
    | ongeldig zoek type         | OnbekendZoekType                    |
    | type voldoet niet aan case | zoekmetgeslachtsnaamengeboortedatum |

  @fout-case
  Scenario: Gevraagde Accept contenttype wordt niet ondersteund
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321                       |
    | fields              | burgerservicenummer             |
    | header: Accept      | application/xml                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde contenttype wordt niet ondersteund.               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/brp/personen                              |

  @fout-case
  Scenario: Lege Accept contenttype wordt niet ondersteund
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 999999321                       |
    | fields              | burgerservicenummer             |
    | header: Accept      |                                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde contenttype wordt niet ondersteund.               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/brp/personen                              |

  Abstract Scenario: '<accept media type>' als Accept contenttype wordt ondersteund
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | burgerservicenummer             |
    | header: Accept      | <accept media type>             |
    Dan heeft de response 0 personen

    Voorbeelden:
    | accept media type               |
    | */*                             |
    | */*; charset=utf-8              |
    | */*;charset=utf-8               |
    | application/json                |
    | application/json; charset=utf-8 |
    | application/json;charset=utf-8  |

  Abstract Scenario: '<media type>' als Content-Type waarde wordt ondersteund
    Als gba personen wordt gezocht met de volgende parameters
    | naam                 | waarde                          |
    | type                 | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer  | 000000024                       |
    | fields               | burgerservicenummer             |
    | header: Content-Type | <media type>                    |
    Dan heeft de response 0 personen

    Voorbeelden:
    | media type                      |
    | application/json                |
    | application/json;charset=utf-8  |
    | application/json; charset=utf-8 |

  @fout-case
  Abstract Scenario: '<media type>' als Content-Type waarde wordt niet ondersteund
    Als gba personen wordt gezocht met de volgende parameters
    | naam                 | waarde                          |
    | type                 | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer  | 999999321                       |
    | fields               | burgerservicenummer             |
    | header: Content-Type | <media type>                    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
    | title    | Media Type wordt niet ondersteund.                           |
    | status   | 415                                                          |
    | instance | /haalcentraal/api/brp/personen                               |

    Voorbeelden:
    | media type                       |
    |                                  |
    | application/xml                  |
    | text/csv                         |
    | application/json; charset=cp1252 |
