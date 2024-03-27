#language: nl

@input-validatie
Functionaliteit: Zoek met postcode en huisnummer - fout cases

Regel: Postcode en huisnummer zijn verplichte parameters

  @fout-case
  Scenario: De postcode en huisnummer parameters zijn niet opgegeven 
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                      |
    | type   | ZoekMetPostcodeEnHuisnummer |
    | fields | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
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
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name     | reason                  |
    | required | postcode | Parameter is verplicht. |

  @fout-case
  Scenario: De huisnummer parameter is niet opgegeven 
    Als personen wordt gezocht met de volgende parameters
    | naam     | waarde                      |
    | type     | ZoekMetPostcodeEnHuisnummer |
    | postcode | 2628HJ                      |
    | fields   | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisnummer.                  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name       | reason                  |
    | required | huisnummer | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als postcode en huisnummer waarde 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   |                             |
    | huisnummer |                             |
    | fields     | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
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
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <foutieve parameter>.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                 | reason                  |
    | required | <foutieve parameter> | Parameter is verplicht. |

    Voorbeelden:
    | titel                                              | postcode | huisnummer | foutieve parameter |
    | Een lege string is opgegeven als huisnummer waarde |          | 2          | postcode           |
    | Een lege waarde is opgegeven als postcode waarde   | 2628HJ   |            | huisnummer         |

Regel: een huisnummer is een getal tussen 1 en 99999

  @fout-case
  Abstract Scenario: Een string met één of meerdere niet-numerieke karakters is opgegeven als huisnummer waarde 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | <huisnummer>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisnummer.                  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name       | reason                       |
    | integer | huisnummer | Waarde is geen geldig getal. |

    Voorbeelden:
    | huisnummer                            |
    | twee                                  |
    | 2e                                    |
    | <script>alert('hello world')</script> |

  @fout-case
  Abstract Scenario: Het opgegeven huisnummer valt niet tussen 1 en 99999 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | <huisnummer>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisnummer.                  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code   | name       | reason   |
    | <code> | huisnummer | <reason> |

    Voorbeelden:
    | huisnummer | code    | reason                             |
    | 0          | minimum | Waarde is lager dan minimum 1.     |
    | 100000     | maximum | Waarde is hoger dan maximum 99999. |

Regel: een postcode is een string bestaande uit 4 cijfers, 0 of 1 spatie en 2 letters (niet hoofdlettergevoelig)

  @fout-case
  Abstract Scenario: Een ongeldig postcode is opgegeven 
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | <postcode>                  |
    | huisnummer | 2                           |
    | fields     | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
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
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: postcode, huisnummer.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name       | reason                                                             |
    | pattern | postcode   | Waarde voldoet niet aan patroon ^[1-9]{1}[0-9]{3}[ ]?[A-Za-z]{2}$. |
    | integer | huisnummer | Waarde is geen geldig getal.                                       |

Regel: een huisletter is een string bestaande uit 1 letter (niet hoofdlettergevoelig)

  @fout-case
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de 'huisletter' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2628HJ                      |
    | huisnummer | 2                           |
    | huisletter | <huisletter>                |
    | fields     | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisletter.                  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name       | reason                                         |
    | pattern | huisletter | Waarde voldoet niet aan patroon ^[a-zA-Z]{1}$. |

    Voorbeelden:
    | huisletter                             |
    | <script>alert('hello world');</script> |
    | 1                                      |

Regel: Een huisnummertoevoeging is een string bestaande uit minimaal 1 en maximaal 4 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - spatie ( ) en min (-)

  @fout-case
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de 'huisnummertoevoeging' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                 | waarde                      |
    | type                 | ZoekMetPostcodeEnHuisnummer |
    | postcode             | 2628HJ                      |
    | huisnummer           | 2                           |
    | huisnummertoevoeging | <huisnummertoevoeging>      |
    | fields               | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: huisnummertoevoeging.        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                 | reason                                                 |
    | pattern | huisnummertoevoeging | Waarde voldoet niet aan patroon ^[a-zA-Z0-9 \-]{1,4}$. |

    Voorbeelden:
    | huisnummertoevoeging                   |
    | <script>alert('hello world');</script> |
    | 123.45                                 |

Regel: inclusiefOverledenPersonen is een boolean (true of false waarde)

  @fout-case
  Abstract Scenario: Een ongeldig waarde is opgegeven voor de 'inclusiefOverledenPersonen' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                         |
    | type                       | ZoekMetPostcodeEnHuisnummer    |
    | postcode                   | 2628HJ                         |
    | huisnummer                 | 2                              |
    | fields                     | burgerservicenummer            |
    | inclusiefOverledenPersonen | <inclusief overleden personen> |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: inclusiefOverledenPersonen.  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                       | reason                  |
    | boolean | inclusiefOverledenPersonen | Waarde is geen boolean. |

    Voorbeelden:
    | inclusief overleden personen |
    |                              |
    | geen boolean                 |

Regel: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt 

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam        | waarde                      |
    | type        | ZoekMetPostcodeEnHuisnummer |
    | postcode    | 2628HJ                      |
    | huisnummer  | 2                           |
    | <parameter> | <waarde>                    |
    | fields      | burgerservicenummer         |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code         | name        | reason                      |
    | unknownParam | <parameter> | Parameter is niet verwacht. |

    Voorbeelden:
    | titel                                     | parameter   | waarde     |
    | zoeken met parameter uit ander zoektype   | voornamen   | Pietje     |
    | typfout in naam optionele parameter       | huisleter   | A          |
    | zoeken met niet gespecificeerde parameter | bestaatNiet | een waarde |
