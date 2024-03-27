#language: nl

@input-validatie
Functionaliteit: Zoek met straatnaam/naam openbare ruimte, huisnummer en gemeente van inschrijving - fout cases

Regel: Straat, huisnummer en gemeenteVanInschrijving zijn verplichte parameters

  @fout-case
  Scenario: De straat, huisnummer en gemeenteVanInschrijving parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                                           |
    | type   | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields | burgerservicenummer                              |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
    | title    | Een of meerdere parameters zijn niet correct.                               |
    | status   | 400                                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving, huisnummer, straat. |
    | code     | paramsValidation                                                            |
    | instance | /haalcentraal/api/brp/personen                                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                    | reason                  |
    | required | straat                  | Parameter is verplicht. |
    | required | huisnummer              | Parameter is verplicht. |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als straat, huisnummer en gemeenteVanInschrijving waarde
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  |                                                  |
    | huisnummer              |                                                  |
    | gemeenteVanInschrijving |                                                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
    | title    | Een of meerdere parameters zijn niet correct.                               |
    | status   | 400                                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving, huisnummer, straat. |
    | code     | paramsValidation                                                            |
    | instance | /haalcentraal/api/brp/personen                                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                    | reason                  |
    | required | straat                  | Parameter is verplicht. |
    | required | huisnummer              | Parameter is verplicht. |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

Regel: een straat is een string bestaande uit minimaal 1 en maximaal 80 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - cijfers (0-9)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  | <straat>                                         |
    | huisnummer              | 1                                                |
    | gemeenteVanInschrijving | 0518                                             |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: straat.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name   | reason                                                                                                                                 |
    | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

    Voorbeelden:
    | titel                                             | straat                                                                                                    |
    | De opgegeven straat is meer dan 80 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven straat bevat ongeldige karakters     | <script>alert('hello world');</script>                                                                    |

Regel: een straat met wildcard is een string bestaande uit minimaal 7 en maximaal 79 karakters, beginnend of eindigend met de "*" karakters. De overige karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - cijfers (0-9)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                  | <straat>                                         |
    | huisnummer              | 38                                               |
    | gemeenteVanInschrijving | 0518                                             |
    | fields                  | burgerservicenummer                              |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: straat.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name   | reason                                                                                                                                 |
    | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

    Voorbeelden:
    | straat     | titel                                                                                   |
    | *van Ock*  | De "*" wildcard is opgegeven als eerste en laatste karakter in de straat parameter      |
    | Laan * van | De "*" wildcard is niet opgegeven als eerste of laatste karakter in de straat parameter |
    | Laan*      | De straat parameter bevat niet het minimum aantal vereiste karakters                    |

Regel: een huisnummer is een getal tussen 1 en 99999

  @fout-case
  Abstract Scenario: Een string met één of meerdere niet-numerieke karakters is opgegeven als huisnummer waarde 
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  | leyweg                                           |
    | huisnummer              | <huisnummer>                                     |
    | gemeenteVanInschrijving | 0518                                             |
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
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  | leyweg                                           |
    | huisnummer              | <huisnummer>                                     |
    | gemeenteVanInschrijving | 0518                                             |
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

Regel: een huisletter is een string bestaande uit 1 letter (niet hoofdlettergevoelig)

  @fout-case
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de 'huisletter' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                  | leyweg                                           |
    | huisnummer              | 2                                                |
    | gemeenteVanInschrijving | 0518                                             |
    | huisletter              | <huisletter>                                     |
    | fields                  | burgerservicenummer                              |
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
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                  | leyweg                                           |
    | huisnummer              | 2                                                |
    | gemeenteVanInschrijving | 0518                                             |
    | huisnummertoevoeging    | <huisnummertoevoeging>                           |
    | fields                  | burgerservicenummer                              |
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

Regel: inclusiefOverledenPersonen is een boolean

  @fout-case
  Abstract Scenario: Een ongeldig waarde is opgegeven voor de 'inclusiefOverledenPersonen' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                     | Afrikanerplein                                   |
    | huisnummer                 | 1                                                |
    | gemeenteVanInschrijving    | 0363                                             |
    | fields                     | burgerservicenummer                              |
    | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
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
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                  | Afrikanerplein                                   |
    | huisnummer              | 1                                                |
    | gemeenteVanInschrijving | 0363                                             |
    | <parameter>             | <waarde>                                         |
    | fields                  | burgerservicenummer                              |
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
