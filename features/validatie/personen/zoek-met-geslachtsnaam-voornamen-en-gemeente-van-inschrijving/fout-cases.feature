#language: nl

@input-validatie
Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving - fout cases

Regel: Geslachtsnaam, voornamen en gemeenteVanInschrijving zijn verplichte parameters

  @fout-case
  Scenario: De voornamen, geslachtsnaam en gemeenteVanInschrijving parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                               |
    | type   | ZoekMetNaamEnGemeenteVanInschrijving |
    | fields | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                            |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                       |
    | title    | Een of meerdere parameters zijn niet correct.                                     |
    | status   | 400                                                                               |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving, geslachtsnaam, voornamen. |
    | code     | paramsValidation                                                                  |
    | instance | /haalcentraal/api/brp/personen                                                    |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                    | reason                  |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |
    | required | geslachtsnaam           | Parameter is verplicht. |
    | required | voornamen               | Parameter is verplicht. |

  @fout-case
  Scenario: Alleen de geslachtsnaam parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | gemeenteVanInschrijving | 0518                                 |
    | fields                  | burgerservicenummer                  |
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
  Scenario: Alleen de voornamen parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0518                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name      | reason                  |
    | required | voornamen | Parameter is verplicht. |

  @fout-case
  Scenario: Alleen de gemeenteVanInschrijving parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                               |
    | type          | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen     | Jan                                  |
    | geslachtsnaam | Jansen                               |
    | fields        | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                    | reason                  |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als voornamen, geslachtsnaam en gemeente van inschrijving waarde
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               |                                      |
    | geslachtsnaam           |                                      |
    | gemeenteVanInschrijving |                                      |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                                            |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                       |
    | title    | Een of meerdere parameters zijn niet correct.                                     |
    | status   | 400                                                                               |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving, geslachtsnaam, voornamen. |
    | code     | paramsValidation                                                                  |
    | instance | /haalcentraal/api/brp/personen                                                    |
    En heeft de response invalidParams met de volgende gegevens
    | code     | name                    | reason                  |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |
    | required | geslachtsnaam           | Parameter is verplicht. |
    | required | voornamen               | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | <voornamen>                          |
    | geslachtsnaam           | <geslachtsnaam>                      |
    | gemeenteVanInschrijving | <gemeente van inschrijving>          |
    | fields                  | burgerservicenummer                  |
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
    | titel                                                             | voornamen | geslachtsnaam | gemeente van inschrijving | foutieve parameter      |
    | Een lege string is opgegeven als voornamen waarde                 |           | Jansen        | 0518                      | voornamen               |
    | Een lege string is opgegeven als geslachtsnaam waarde             | Jan       |               | 0518                      | geslachtsnaam           |
    | Een lege string is opgegeven als gemeente van inschrijving waarde | Jan       | Jansen        |                           | gemeenteVanInschrijving |

Regel: Een geslachtsnaam is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | geslachtsnaam           | <geslachtsnaam>                      |
    | gemeenteVanInschrijving | 0599                                 |
    | fields                  | burgerservicenummer                  |
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
  Abstract Scenario: De "*" wildcard karakter staat niet aan het eind in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | geslachtsnaam           | <geslachtsnaam filter>               |
    | gemeenteVanInschrijving | 0599                                 |
    | fields                  | burgerservicenummer                  |
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
    | Jan*sen              |

Regel: Een voornamen waarde is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | <voornamen>                          |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0599                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                                                               |
    | pattern | voornamen | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | titel                                                 | voornamen                                                                                                                                                                                                           |
    | De opgegeven voornamen is meer dan 199 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven voornamen bevat ongeldige karakters      | <script>alert('hello world');</script>                                                                                                                                                                              |

Regel: Een voornamen waarde met wildcard is een string bestaande uit minimaal 1 en maximaal 199 karakters, eindigend met de "*" karakter. De overige karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - diakrieten (À-ž)
      - spatie ( ), punt (.), min (-) en de enkele aanhalingsteken (')

  @fout-case
  Abstract Scenario: De "*" wildcard is opgegeven als eerste karakter in de voornamen parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | <voornamen>                          |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0599                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft de response invalidParams met de volgende gegevens
    | code    | name      | reason                                                                                              |
    | pattern | voornamen | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | voornamen met wildcard |
    | *iet                   |
    | *ETER                  |

Regel: Een gemeenteVanInschrijving waarde bestaat uit 4 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | <gemeente code>                      |
    | fields                  | burgerservicenummer                  |
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

Regel: Een voorvoegsel waarde is een string bestaande uit minimaal 1 en maximaal 10 karakters. Deze karakters kunnen zijn:
      - kleine letters (a-z)
      - hoofdletters (A-Z)
      - spatie ( ) en de enkele aanhalingsteken (')

  @fout-case
  Scenario: Een ongeldige waarde is opgegeven voor de 'voorvoegsel' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                 |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving   |
    | voornamen               | Jan                                    |
    | geslachtsnaam           | Jansen                                 |
    | gemeenteVanInschrijving | 0599                                   |
    | voorvoegsel             | <script>alert('hello world');</script> |
    | fields                  | burgerservicenummer                    |
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
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0599                                 |
    | geslacht                | <geslacht>                           |
    | fields                  | burgerservicenummer                  |
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
    | naam                       | waarde                               |
    | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen                  | Jan                                  |
    | geslachtsnaam              | Jansen                               |
    | gemeenteVanInschrijving    | 0599                                 |
    | fields                     | burgerservicenummer                  |
    | inclusiefOverledenPersonen | <inclusief overleden personen>       |
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
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0599                                 |
    | <parameter>             | <waarde>                             |
    | fields                  | burgerservicenummer                  |
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
