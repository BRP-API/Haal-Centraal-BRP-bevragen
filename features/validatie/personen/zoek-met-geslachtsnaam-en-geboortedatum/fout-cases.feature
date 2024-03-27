#language: nl

@input-validatie
Functionaliteit: Zoek met geslachtsnaam en geboortedatum - fout cases

Regel: Geslachtsnaam en geboortedatum zijn verplichte parameters

  @fout-case
  Scenario: De geslachtsnaam en geboortedatum parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                              |
    | type   | ZoekMetGeslachtsnaamEnGeboortedatum |
    | fields | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Een of meerdere parameters zijn niet correct.                |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsValidation                                             |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Scenario: Alleen de geslachtsnaam parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name          | reason                  |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Scenario: Alleen de geboortedatum parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geboortedatum.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als geslachtsnaam en geboortedatum waarde
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam |                                     |
    | geboortedatum |                                     |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Een of meerdere parameters zijn niet correct.                |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsValidation                                             |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | <geboortedatum>                     |
    | fields        | burgerservicenummer                 |
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
    | titel                                                 | geboortedatum | geslachtsnaam | foutieve parameter |
    | Een lege string is opgegeven als geboortedatum waarde |               | maassen       | geboortedatum      |
    | Een lege string is opgegeven als geslachtsnaam waarde | 1983-05-26    |               | geslachtsnaam      |

Regel: De geboortedatum is een datum string geformatteerd volgens de [ISO 8601 date format](https://www.w3.org/QA/Tips/iso-date)

  @fout-case
  Abstract Scenario: Een ongeldig datum is opgegeven als geboortedatum waarde
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | <geboortedatum>                     |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geboortedatum.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code | name          | reason                        |
    | date | geboortedatum | Waarde is geen geldige datum. |

    Voorbeelden:
    | geboortedatum |
    | 19830526      |
    | 26 mei 1983   |

Regel: Een geslachtsnaam is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | titel                                                     | geslachtsnaam                                                                                                                                                                                                       |
    | De opgegeven geslachtsnaam is meer dan 200 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven geslachtsnaam bevat ongeldige karakters      | <script>alert('hello world');</script>                                                                                                                                                                              |

Regel: Een geslachtsnaam met wildcard is een string bestaande uit minimaal 3 en maximaal 199 karakters, eindigend met de "*" karakter. De overige karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: De "*" wildcard is opgegeven als eerste karakter in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *sen                 |
    | *SEN                 |

  @fout-case
  Abstract Scenario: De "*" wildcard komt meerdere keren voor in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *oen*                |
    | *OEN*                |
    | gr**                 |
    | *r*ot                |
    | gr*o*                |

  @fout-case
  Abstract Scenario: De "*" wildcard karakter staat niet aan het eind in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | gr*t                 |
    | g*oot                |

  @fout-case
  Abstract Scenario: De opgegeven geslachtsnaam exclusief "*" wildcard karakter is niet minimaal 3 karakters lang
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *                    |
    | *n                   |
    | n*                   |
    | ab*                  |
    | ***                  |

  @fout-case
  Scenario: Er zijn meerdere ongeldige parameters opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                 |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum    |
    | geslachtsnaam | <script>alert('hello world');</script> |
    | geboortedatum | 19830526                               |
    | fields        | burgerservicenummer                    |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Een of meerdere parameters zijn niet correct.                |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsValidation                                             |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |
    | date    | geboortedatum | Waarde is geen geldige datum.                                                                        |

Regel: Een voornamen waarde is een string bestaande uit minimaal 1 en maximaal 199 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | voornamen     | <voornamen>                         |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                                 |
    | pattern | voornamen | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,199}\*{0,1}$. |

    Voorbeelden:
    | titel                                                   | voornamen                                                                                                                                                                                                           |
    | De opgegeven voornamen zijn meer dan 200 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven voornamen bevat ongeldige karakters        | <script>alert('hello world');</script>                                                                                                                                                                              |

Regel: Een voornamen waarde met wildcard is een string bestaande uit minimaal 1 en maximaal 199 karakters, eindigend met de "*" karakter. De overige karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: De "*" wildcard is opgegeven als eerste karakter in de voornamen parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Jansen                              |
    | geboortedatum | 1983-05-26                          |
    | voornamen     | <voornamen met wildcard>            |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                                 |
    | pattern | voornamen | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,199}\*{0,1}$. |

    Voorbeelden:
    | voornamen met wildcard |
    | *iet                   |
    | *ETER                  |

Regel: Een voorvoegsel waarde is een string bestaande uit minimaal 1 en maximaal 10 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - spatie ( ) en de enkele aanhalingsteken (')

  @fout-case
  Scenario: Een ongeldige waarde is opgegeven voor de 'voorvoegsel' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                 |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum    |
    | geslachtsnaam | maassen                                |
    | geboortedatum | 1983-05-26                             |
    | voorvoegsel   | <script>alert('hello world');</script> |
    | fields        | burgerservicenummer                    |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voorvoegsel.                 |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name        | reason                                               |
    | pattern | voorvoegsel | Waarde voldoet niet aan patroon ^[a-zA-Z \']{1,10}$. |

Regel: De geslacht waarde is één karakter lang en kan één van de volgende karakters zijn: M, m, V, v, O, o

  @fout-case
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de 'geslacht' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | geslacht      | <geslacht>                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslacht.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name     | reason                                                |
    | pattern | geslacht | Waarde voldoet niet aan patroon ^([Mm]\|[Vv]\|[Oo])$. |

    Voorbeelden:
    | geslacht                               |
    | N                                      |
    | <script>alert('hello world');</script> |

Regel: inclusiefOverledenPersonen is een boolean (true of false waarde)

  @fout-case
  Abstract Scenario: Een ongeldig waarde is opgegeven voor de 'inclusiefOverledenPersonen' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | maassen                             |
    | geboortedatum              | 1983-05-26                          |
    | fields                     | burgerservicenummer                 |
    | inclusiefOverledenPersonen | <inclusief overleden personen>      |
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

Regel: Een gemeenteVanInschrijving waarde bestaat uit 4 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                              |
    | type                    | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam           | maassen                             |
    | geboortedatum           | 1983-05-26                          |
    | gemeenteVanInschrijving | <gemeente code>                     |
    | fields                  | burgerservicenummer                 |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name                    | reason                                      |
    | pattern | gemeenteVanInschrijving | Waarde voldoet niet aan patroon ^[0-9]{4}$. |

    Voorbeelden:
    | titel                                                                    | gemeente code                          |
    | De opgegeven gemeenteVanInschrijving waarde is minder dan 4 cijfers lang | 123                                    |
    | De opgegeven gemeenteVanInschrijving waarde is meer dan 4 cijfers lang   | 12345                                  |
    | De opgegeven gemeenteVanInschrijving waarde bevat ongeldige karakters    | <script>alert('hello world');</script> |

Regel: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt 

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | <parameter>   | <waarde>                            |
    | fields        | burgerservicenummer                 |
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
    | titel                                     | parameter    | waarde     |
    | zoeken met parameter uit ander zoektype   | postcode     | 1234AB     |
    | typfout in naam optionele parameter       | voorvoegsels | van der    |
    | zoeken met niet gespecificeerde parameter | bestaatNiet  | een waarde |
