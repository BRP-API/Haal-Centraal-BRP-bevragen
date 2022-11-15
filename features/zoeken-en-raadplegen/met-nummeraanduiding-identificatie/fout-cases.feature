#language: nl

Functionaliteit: Zoek met nummeraanduiding identificatie - fout cases

Rule: nummeraanduiding identificatie is een verplichte parameter

    @fout-case
    Scenario: De nummeraanduiding identificatie parameter is niet opgegeven
      Als personen wordt gezocht met de volgende parameters
      | naam   | waarde                               |
      | type   | ZoekMetNummeraanduidingIdentificatie |
      | fields | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                        |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1   |
      | title    | Minimale combinatie van parameters moet worden opgegeven.     |
      | status   | 400                                                           |
      | detail   | De foutieve parameter(s) zijn: nummeraanduidingIdentificatie. |
      | code     | paramsCombination                                             |
      | instance | /haalcentraal/api/brp/personen                                |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                          | reason                  |
      | required | nummeraanduidingIdentificatie | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: <titel>
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | <nummeraanduidingIdentificatie>      |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                        |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1   |
      | title    | Een of meerdere parameters zijn niet correct.                 |
      | status   | 400                                                           |
      | detail   | De foutieve parameter(s) zijn: nummeraanduidingIdentificatie. |
      | code     | paramsValidation                                              |
      | instance | /haalcentraal/api/brp/personen                                |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name                          | reason                                       |
      | pattern | nummeraanduidingIdentificatie | Waarde voldoet niet aan patroon ^[0-9]{16}$. |

      Voorbeelden:
      | nummeraanduidingIdentificatie | titel                                                                  |
      |                               | Een lege string is opgegeven als nummeraanduiding identificatie waarde |
      | 123456789012345               | Een ongeldig nummeraanduiding identificatie waarde is opgegeven        |

Rule: de inclusiefOverledenPersonen parameter is een boolean

    @fout-case
    Abstract Scenario: Een ongeldig waarde is opgegeven voor inclusiefOverledenPersonen parameter
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200051001501                     |
      | fields                        | burgerservicenummer                  |
      | inclusiefOverledenPersonen    | <inclusief overleden personen>       |
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
