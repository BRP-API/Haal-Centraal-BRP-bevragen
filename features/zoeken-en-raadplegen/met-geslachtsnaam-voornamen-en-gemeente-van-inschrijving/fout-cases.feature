#language: nl

Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving - fout cases

Rule: Geslachtsnaam, voornamen (beide niet hoofdlettergevoelig) en gemeenteVanInschrijving zijn verplichte parameters

  @fout-case
  Scenario: De voornamen, geslachtsnaam en gemeenteVanInschrijving parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                               |
    | type   | ZoekMetNaamEnGemeenteVanInschrijving |
    | fields | burgerservicenummer                  |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                            |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                       |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                         |
    | status   | 400                                                                               |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam, voornamen, gemeenteVanInschrijving. |
    | code     | paramsCombination                                                                 |
    | instance | /haalcentraal/api/brp/personen                                                    |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                    | reason                  |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |
    | required | geslachtsnaam           | Parameter is verplicht. |
    | required | voornamen               | Parameter is verplicht. |

  @fout-case
  Scenario: De geslachtsnaam parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen               | Jan                                  |
    | gemeenteVanInschrijving | 0518                                 |
    | fields                  | burgerservicenummer                  |
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
  Scenario: De voornamen parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                               |
    | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
    | geslachtsnaam           | Jansen                               |
    | gemeenteVanInschrijving | 0518                                 |
    | fields                  | burgerservicenummer                  |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: voornamen.                   |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name      | reason                  |
    | required | voornamen | Parameter is verplicht. |

  @fout-case
  Scenario: De gemeenteVanInschrijving parameter is niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                               |
    | type          | ZoekMetNaamEnGemeenteVanInschrijving |
    | voornamen     | Jan                                  |
    | geslachtsnaam | Jansen                               |
    | fields        | burgerservicenummer                  |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
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
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                            |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                       |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                         |
    | status   | 400                                                                               |
    | detail   | De foutieve parameter(s) zijn: geslachtsnaam, voornamen, gemeenteVanInschrijving. |
    | code     | paramsCombination                                                                 |
    | instance | /haalcentraal/api/brp/personen                                                    |
    En heeft het object de volgende 'invalidParams' gegevens
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
    | titel                                                             | voornamen | geslachtsnaam | gemeente van inschrijving | foutieve parameter      |
    | Een lege string is opgegeven als voornamen waarde                 |           | Jansen        | 0518                      | voornamen               |
    | Een lege string is opgegeven als geslachtsnaam waarde             | Jan       |               | 0518                      | geslachtsnaam           |
    | Een lege string is opgegeven als gemeente van inschrijving waarde | Jan       | Jansen        |                           | gemeenteVanInschrijving |
