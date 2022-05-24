#language: nl

@post-assert
Functionaliteit: Zoek met postcode en huisnummer

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999995078           |
    | 999995079           |
    | 999995080           |
    | 999995081           |
    | 999995082           |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) |
    | 999995078           | 2628HJ           | 2                  |                    |                              |                                   |
    | 999995079           | 2628HJ           | 2                  | A                  |                              |                                   |
    | 999995080           | 2628HJ           | 2                  |                    |                              | to                                |
    | 999995081           | 2628HJ           | 2                  |                    | III                          |                                   |
    | 999995082           | 2628HJ           | 2                  |                    |                              |                                   |
    En het systeem heeft personen met de volgende 'overlijden' gegevens
    | burgerservicenummer | datum    |
    | 999995082           | 20220301 |

Rule: Postcode en huisnummer zijn verplichte parameters
  Zoeken is niet hoofdlettergevoelig

  Abstract Scenario: Zoek met valide postcode en huisnummer
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan heeft de response 4 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995079 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995080 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995081 |

    Voorbeelden:
    | postcode |
    | 2628HJ   |
    | 2628hj   |
    | 2628 HJ  |
    | 2628 hj  |
    | 2628 Hj  |

  Abstract Scenario: Zoek met huisletter
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | huisletter | <huisletter>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995079 |

    Voorbeelden:
    | huisletter |
    | A          |
    | a          |

  Abstract Scenario: Zoek met huisnummertoevoeging
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                      |
    | type                 | ZoekMetPostcodeEnHuisnummer |
    | postcode             | 2628HJ                      |
    | huisnummer           | 2                           |
    | huisnummertoevoeging | <huisnummertoevoeging>      |
    | fields               | burgerservicenummer         |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995081 |

    Voorbeelden:
    | huisnummertoevoeging |
    | III                  |
    | iii                  |
    | Iii                  |

  @fout-case
  Scenario: Zoek zonder postcode en huisnummer 
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                      |
    | type   | ZoekMetPostcodeEnHuisnummer |
    | fields | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name       | reason                  |
    | required | postcode   | Parameter is verplicht. |
    | required | huisnummer | Parameter is verplicht. |

  @fout-case
  Scenario: Zoek zonder postcode 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode.                    |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name     | reason                  |
    | required | postcode | Parameter is verplicht. |

  @fout-case
  Scenario: Zoek zonder huisnummer 
    Als personen wordt gezocht met de volgende parameters
    | naam     | waarde                      |
    | type     | ZoekMetPostcodeEnHuisnummer |
    | postcode | 2628HJ                      |
    | fields   | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisnummer.                  |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name       | reason                  |
    | required | huisnummer | Parameter is verplicht. |

  @fout-case
  Scenario: Zoek met leeg postcode en leeg huisnummer 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   |                             |
    | huisnummer |                             |
    | fields     | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name       | reason                  |
    | required | postcode   | Parameter is verplicht. |
    | required | huisnummer | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | <huisnummer>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <foutieve parameter>.        |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                 | reason                  |
    | required | <foutieve parameter> | Parameter is verplicht. |

    Voorbeelden:
    | titel                             | postcode | huisnummer | foutieve parameter |
    | Zoek met alleen valide huisnummer |          | 2          | postcode           |
    | Zoek met alleen valide postcode   | 2628HJ   |            | huisnummer         |

  @fout-case
  Scenario: Zoek met invalide huisnummer 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | twee                        |
    | fields     | burgerservicenummer         |
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

  @fout-case
  Abstract Scenario: Zoek met invalide postcode 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name     | reason                                                             |
    | pattern | postcode | Waarde voldoet niet aan patroon ^[1-9]{1}[0-9]{3}[ ]?[A-Za-z]{2}$. |

    Voorbeelden:
    | postcode                               |
    | 0628HJ                                 |
    | 2628  HJ                               |
    | <script>alert('hello world');</script> |

  @fout-case
  Scenario: Meerdere invalide parameters 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 0628HJ                      |
    | huisnummer | twee                        |
    | fields     | burgerservicenummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name       | reason                                                             |
    | pattern | postcode   | Waarde voldoet niet aan patroon ^[1-9]{1}[0-9]{3}[ ]?[A-Za-z]{2}$. |
    | integer | huisnummer | Waarde is geen geldig getal.                                       |

  @fout-case
  Abstract Scenario: Zoek met ongeldige <parameter naam> parameter
    Als personen wordt gezocht met de volgende parameters
    | naam             | waarde                                 |
    | type             | ZoekMetPostcodeEnHuisnummer            |
    | postcode         | 2628HJ                                 |
    | huisnummer       | 2                                      |
    | <parameter naam> | <script>alert('hello world');</script> |
    | fields           | burgerservicenummer                    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <parameter naam>.            |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name             | reason                                     |
    | pattern | <parameter naam> | Waarde voldoet niet aan patroon <patroon>. |

    Voorbeelden:
    | parameter naam       | patroon               |
    | huisletter           | ^[a-zA-Z]{1}$         |
    | huisnummertoevoeging | ^[a-zA-Z0-9 \-]{1,4}$ |
