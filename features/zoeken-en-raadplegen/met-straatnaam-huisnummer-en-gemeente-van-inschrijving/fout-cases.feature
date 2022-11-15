#language: nl

Functionaliteit: Zoek met straatnaam/naam openbare ruimte, huisnummer en gemeente van inschrijving - fout cases

Rule: Straat (niet hoofdlettergevoelig), huisnummer en gemeente van inschrijving zijn verplichte parameters

  @fout-case
  Scenario: De straat, huisnummer en gemeente van inschrijving parameters zijn niet opgegeven
    Als personen wordt gezocht met de volgende parameters
    | naam   | waarde                                           |
    | type   | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields | burgerservicenummer                              |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                   |
    | status   | 400                                                                         |
    | detail   | De foutieve parameter(s) zijn: straat, huisnummer, gemeenteVanInschrijving. |
    | code     | paramsCombination                                                           |
    | instance | /haalcentraal/api/brp/personen                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                    | reason                  |
    | required | straat                  | Parameter is verplicht. |
    | required | huisnummer              | Parameter is verplicht. |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

  @fout-case
  Scenario: Een lege string is opgegeven als straat, huisnummer en gemeente van inschrijving waarde
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  |                                                  |
    | huisnummer              |                                                  |
    | gemeenteVanInschrijving |                                                  |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.                   |
    | status   | 400                                                                         |
    | detail   | De foutieve parameter(s) zijn: straat, huisnummer, gemeenteVanInschrijving. |
    | code     | paramsCombination                                                           |
    | instance | /haalcentraal/api/brp/personen                                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                    | reason                  |
    | required | straat                  | Parameter is verplicht. |
    | required | huisnummer              | Parameter is verplicht. |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  | <straat>                                         |
    | huisnummer              | 1                                                |
    | gemeenteVanInschrijving | 0518                                             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: straat.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name   | reason                                                                                                                                 |
    | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

    Voorbeelden:
    | titel                                             | straat                                                                                                    |
    | De opgegeven straat is meer dan 80 karakters lang | abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ |
    | De opgegeven straat bevat ongeldige karakters     | <script>alert('hello world');</script>                                                                    |

  @fout-case
  Scenario: Een ongeldig waarde is opgegeven voor de huisnummer parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | fields                  | burgerservicenummer                              |
    | straat                  | leyweg                                           |
    | huisnummer              | twee                                             |
    | gemeenteVanInschrijving | 0518                                             |
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

Rule: de inclusiefOverledenPersonen parameter is een boolean

  @fout-case
  Abstract Scenario: Een ongeldig waarde is opgegeven voor de inclusiefOverledenPersonen parameter
    Als personen wordt gezocht met de volgende parameters
    | naam                       | waarde                                           |
    | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                     | Afrikanerplein                                   |
    | huisnummer                 | 1                                                |
    | gemeenteVanInschrijving    | 0363                                             |
    | fields                     | burgerservicenummer                              |
    | inclusiefOverledenPersonen | <inclusief overleden personen>                   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: inclusiefOverledenPersonen.  |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name                       | reason   |
    | <code> | inclusiefOverledenPersonen | <reason> |

    Voorbeelden:
    | inclusief overleden personen | code    | reason                  |
    |                              | boolean | Waarde is geen boolean. |
    | geen boolean                 | boolean | Waarde is geen boolean. |

Rule: Voor de straat parameter kan wildcard matching (niet hooflettergevoelig) worden toegepast.
      Er moet dan minimaal 7 letters (exclusief de wildcard "*" teken) worden opgegeven.
      De wildcard moet als laatste karakter worden opgegeven.
      De wildcard komt overeen met nul of meer (niet-spatie) karakters.
      De wildcard kan als eerste of als laatste karakter worden opgegeven.

  @fout-case
  Abstract Scenario: <titel>
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                                           |
    | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
    | straat                  | <straat>                                         |
    | huisnummer              | 38                                               |
    | gemeenteVanInschrijving | 0518                                             |
    | fields                  | burgerservicenummer                              |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: straat.                      |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name   | reason                                                                                                                                 |
    | pattern | straat | Waarde voldoet niet aan patroon ^[a-zA-Z0-9À-ž \-\'\.]{1,80}$\|^[a-zA-Z0-9À-ž \-\'\.]{7,79}\*{1}$\|^\*{1}[a-zA-Z0-9À-ž \-\'\.]{7,79}$. |

    Voorbeelden:
    | straat     | titel                                                                                   |
    | *van Ock*  | De "*" wildcard is opgegeven als eerste en laatste karakter in de straat parameter      |
    | Laan * van | De "*" wildcard is niet opgegeven als eerste of laatste karakter in de straat parameter |
    | Laan*      | De straat parameter bevat niet het minimum aantal vereiste karakters                    |
