#language: nl

@ready @post-assert
Functionaliteit: Zoek met geslachtsnaam en geboortedatum

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer | geslachtsaanduiding (04.10) |
    | 999995078           | M                           |
    | 999995079           | M                           |
    | 999995080           | M                           |
    | 999995081           | M                           |
    | 999995082           | M                           |
    | 999995083           | M                           |
    | 999995084           | V                           |
    | 999995085           | V                           |
    | 999995086           | V                           |
    | 999995087           | V                           |
    En het systeem heeft personen met de volgende 'geboorte' gegevens
    | burgerservicenummer | datum    | plaats.omschrijving |
    | 999995078           | 19830526 | Noordwijk           |
    | 999995079           | 19830526 | Leiden              |
    | 999995080           | 19830526 | Katwijk             |
    | 999995081           | 19830526 | Lisse               |
    | 999995082           | 19830526 | Wassenaar           |
    | 999995083           | 19830526 |                     |
    | 999995084           | 19830526 |                     |
    | 999995085           | 19830526 |                     |
    | 999995086           | 19830526 |                     |
    | 999995087           | 19830526 |                     |
    En het systeem heeft personen met de volgende 'naam' gegevens
    | burgerservicenummer | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
    | 999995078           | Maassen               | Pieter            |                     |
    | 999995079           | Groen                 |                   |                     |
    | 999995080           | Groot                 |                   |                     |
    | 999995081           | Jansen                |                   |                     |
    | 999995082           | Maassen               | Jan Peter         | van                 |
    | 999995083           | Groenlo               |                   |                     |
    | 999995084           | Aedel                 | Petra             | van den             |
    | 999995085           | Jansen                |                   |                     |
    | 999995086           | Os                    |                   |                     |
    | 999995087           | Osnabrugge            |                   |                     |
    En het systeem heeft personen met de volgende 'overlijden' gegevens
    | burgerservicenummer | datum    |
    | 999995085           | 20220301 |

Rule: Geslachtsnaam en geboortedatum zijn verplichte parameters
      Zoeken is niet hoofdlettergevoelig

  Abstract Scenario: Zoek met volledige geslachtsnaam en geboortedatum
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 2 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995078 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995082 |

    Voorbeelden:
    | geslachtsnaam |
    | Maassen       |
    | maassen       |
    | MAASSEN       |

  Abstract Scenario: Zoek met deel van geslachtsnaam en geboortedatum
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 0 personen

    Voorbeelden:
    | geslachtsnaam |
    | Maas          |
    | jans          |
    | MAAS          |

  Scenario: Zoek met geslachtsnaam van twee karakters lang
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | os                                  |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995086 |

  Abstract Scenario: Zoek met volledige voornamen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | voornamen     | <voornamen>                         |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde                |
    | burgerservicenummer | <burgerservicenummer> |

    Voorbeelden:
    | geslachtsnaam | voornamen | burgerservicenummer |
    | Maassen       | Pieter    | 999995078           |
    | maassen       | PIETER    | 999995078           |
    | MAASSEN       | pieter    | 999995078           |
    | maassen       | jan peter | 999995082           |

  Abstract Scenario: Zoek met volledige voorvoegsel
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam>                     |
    | voorvoegsel   | <voorvoegsel>                       |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995082 |

    Voorbeelden:
    | geslachtsnaam | voorvoegsel |
    | Maassen       | van         |
    | maassen       | VAN         |
    | MAASSEN       | Van         |

  Abstract Scenario: Zoek met geslacht
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Aedel                               |
    | geslacht      | <geslachtsaanduiding>               |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995084 |

    Voorbeelden:
    | geslachtsaanduiding |
    | v                   |
    | V                   |

  Scenario: Zoek met inclusiefOverledenPersonen
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Jansen                              |
    | inclusiefOverledenPersonen | true                                |
    | geboortedatum              | 1983-05-26                          |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response 2 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995081 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995085 |

  @fout-case
  Scenario: Zoek zonder geslachtsnaam en geboortedatum
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
  Scenario: Zoek zonder geslachtsnaam
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
  Scenario: Zoek zonder geboortedatum
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
  Scenario: Zoek met leeg geslachtsnaam en leeg geboortedatum
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
    | titel                                | geboortedatum | geslachtsnaam | foutieve parameter |
    | Zoek met alleen valide geslachtsnaam |               | maassen       | geboortedatum      |
    | Zoek met alleen valide geboortedatum | 1983-05-26    |               | geslachtsnaam      |

  @fout-case
  Abstract Scenario: Zoek met invalide geboortedatum
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
    | titel                                        | geslachtsnaam                                                                                                                                                                                                       |
    | Geslachtsnaam is meer dan 200 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | Geslachtsnaam bevat ongeldige karakters      | <script>alert('hello world');</script>                                                                                                                                                                              |

  @fout-case
  Scenario: Meerdere invalide parameters
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
  Abstract Scenario: Zoek met ongeldige <parameter naam> parameter
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
    | geslacht       | ^([Mm]\|[Vv]\|[Oo])$                  |

Rule: Bij zoeken met de "*" wildcard moet minimaal 3 letters (exclusief de wildcard teken) worden opgegeven
      De "*" wildcard komt overeen met nul of meer (niet-spatie) karakters

  Abstract Scenario: Zoek met "*" wildcard als laatste karakter in geslachtsnaam
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | <geslachtsnaam filter>              |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 3 personen
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995079 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995080 |
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995083 |

    Voorbeelden:
    | geslachtsnaam filter |
    | gro*                 |
    | Gro*                 |
    | GRO*                 |

  @fout-case
  Abstract Scenario: Zoek met "*" wildcard als eerste karakter in geslachtsnaam
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
  Abstract Scenario: Zoek met "*" wildcard als eerste en laatste karakter in geslachtsnaam
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

  Abstract Scenario: Zoek met "*" wildcard als laatste karakter in voornamen
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | voornamen     | <voornamen filter>                  |
    | geboortedatum | 1983-05-26                          |
    | fields        | burgerservicenummer                 |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 999995082 |

    Voorbeelden:
    | voornamen filter |
    | Jan*             |
    | jan*             |
    | JAN*             |

  @fout-case
  Abstract Scenario: Zoek met "*" wildcard als eerste karakter in voornamen
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

  @fout-case
  Abstract Scenario: geslachtsnaam met maximimaal twee letters exclusief "*" wildcard karakter
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
  Abstract Scenario: De "*" wildcard karakter staat niet aan het eind van de geslachtsnaam zoekstring
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


Rule: een afgevoerde persoonslijst moet niet worden gevonden
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), moet deze persoon(slijst) niet worden gevonden bij zoeken

  Scenario: Zoek met geslachtsnaam en geboortedatum van persoon op afgevoerde persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | 000000012                   | Isnietgoed            | 19781103              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Isnietgoed                          |
    | geboortedatum              | 1978-11-03                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met geslachtsnaam en geboortedatum van persoon op opgeschorte persoonslijst wegens "<reden opschorting omschrijving>"
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) | geslachtsnaam (02.40) | geboortedatum (03.10) |
    | 000000024                   | Iswelgoed            | 19781103              |
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                              |
    | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam              | Iswelgoed                           |
    | geboortedatum              | 1978-11-03                          |
    | inclusiefOverledenPersonen | true                                |
    | fields                     | burgerservicenummer                 |
    Dan heeft de response een persoon met de volgende gegevens
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
    | .                            | onbekend                       |
