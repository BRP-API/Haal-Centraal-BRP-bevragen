#language: nl

Functionaliteit: Zoek met postcode en huisnummer - fout cases

Rule: Postcode en huisnummer zijn verplichte parameters

  @fout-case
  Scenario: De postcode en huisnummer parameters zijn niet opgegeven 
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
  Scenario: De postcode parameter is niet opgegeven 
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
  Scenario: De huisnummer parameter is niet opgegeven 
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
  Scenario: Een lege waarde is opgegeven voor de postcode en huisnummer parameters 
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
    | titel                                                     | postcode | huisnummer | foutieve parameter |
    | Een lege waarde is opgegeven voor de huisnummer parameter |          | 2          | postcode           |
    | Een lege waarde is opgegeven voor de postcode parameter   | 2628HJ   |            | huisnummer         |

  @fout-case
  Scenario: Een ongeldig huisnummer is opgegeven 
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
  Abstract Scenario: Een ongeldig postcode is opgegeven 
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
  Scenario: Meerdere ongeldige parameters zijn opgegeven 
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
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de '<parameter naam>' parameter
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
