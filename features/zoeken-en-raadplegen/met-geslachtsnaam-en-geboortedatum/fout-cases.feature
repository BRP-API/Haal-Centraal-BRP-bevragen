#language: nl

Functionaliteit: Zoek met geslachtsnaam en geboortedatum - fout cases

  @fout-case
  Scenario: De geslachtsnaam en geboortedatum parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                              |
    | type   | ZoekMetGeslachtsnaamEnGeboortedatum |
    | fields | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Minimale combinatie van parameters moet worden opgegeven.    |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsCombination                                            |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name          | reason                  |
    | required | geboortedatum | Parameter is verplicht. |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Scenario: De geslachtsnaam parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name          | reason                  |
    | required | geslachtsnaam | Parameter is verplicht. |

  @fout-case
  Scenario: De geboortedatum parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geboortedatum.               |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Minimale combinatie van parameters moet worden opgegeven.    |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsCombination                                            |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft het object de volgende 'invalidParams' gegevens
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
    | titel                                                                   | geboortedatum | geslachtsnaam | foutieve parameter |
    | Een lege string is opgegeven als waarde voor de geboortedatum parameter |               | maassen       | geboortedatum      |
    | Een lege string is opgegeven als waarde voor de geslachtsnaam parameter | 1983-05-26    |               | geslachtsnaam      |

  @fout-case
  Abstract Scenario: Er is een ongeldig geboortedatum waarde opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | <geboortedatum>                     |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geboortedatum.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name          | reason                        |
    | date | geboortedatum | Waarde is geen geldige datum. |

    Voorbeelden:
    | geboortedatum |
    | 19830526      |
    | 26 mei 1983   |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | titel                                                     | geslachtsnaam                                                                                                                                                                                                       |
    | De opgegeven geslachtsnaam is meer dan 200 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven geslachtsnaam bevat ongeldige karakters      | <script>alert('hello world');</script>                                                                                                                                                                              |

  @fout-case
  Scenario: Er zijn meerdere ongeldige parameters opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                 |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum    |
    | geslachtsnaam | <script>alert('hello world');</script> |
    | geboortedatum | 19830526                               |
    | fields        | burgerservicenummer                    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1  |
    | title    | Een of meerdere parameters zijn niet correct.                |
    | status   | 400                                                          |
    | detail   | De foutieve parameter(s) zijn: geboortedatum, geslachtsnaam. |
    | code     | paramsValidation                                             |
    | instance | /haalcentraal/api/brp/personen                               |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |
    | date    | geboortedatum | Waarde is geen geldige datum.                                                                        |

  @fout-case
  Abstract Scenario: Een ongeldige waarde is opgegeven voor de '<parameter naam>' parameter
    Als personen wordt gezocht met de volgende parameters
    | naam             | waarde                                 |
    | type             | ZoekMetGeslachtsnaamEnGeboortedatum    |
    | geslachtsnaam    | maassen                                |
    | geboortedatum    | 1983-05-26                             |
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
    | parameter naam | patroon                               |
    | voornamen      | ^[a-zA-Z0-9À-ž \.\-\']{1,199}\*{0,1}$ |
    | voorvoegsel    | ^[a-zA-Z \']{1,10}$                   |
    | geslacht       | ^([Mm]\|[Vv]\|[Oo])$ |

  @fout-case
  Abstract Scenario: De "*" wildcard is opgegeven als eerste karakter in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *sen                 |
    | *SEN                 |

  @fout-case
  Abstract Scenario: De "*" wildcard is meerdere keren opgegeven in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *oen*                |
    | *OEN*                |

  @fout-case
  Abstract Scenario: De opgegeven geslachtsnaam exclusief "*" wildcard karakter is niet minimaal letters lang
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
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
  Abstract Scenario: De "*" wildcard karakter staat niet aan het eind in de geslachtsnaam parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam.               |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name          | reason                                                                                               |
    | pattern | geslachtsnaam | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,200}$\|^[a-zA-Z0-9À-ž \.\-\']{3,199}\*{1}$. |

    Voorbeelden:
    | geslachtsnaam filter |
    | *r*ot                |
    | gr*o*                |
    | gr*t                 |
    | gr**                 |

  @fout-case
  Abstract Scenario: De "*" wildcard is als eerste karakter opgegeven in de voornamen parameter
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | voornamen     | <voornamen filter>                  |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name      | reason                                                                 |
    | pattern | voornamen | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \.\-\']{1,199}\*{0,1}$. |

    Voorbeelden:
    | voornamen filter |
    | *eter            |
    | *ETER            |
