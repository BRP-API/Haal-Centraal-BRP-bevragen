#language: nl

@ready @post-assert
Functionaliteit: Zoek met nummeraanduiding identificatie

  Achtergrond:
    Gegeven het systeem heeft personen met de volgende gegevens
    | burgerservicenummer |
    | 999993653           |
    | 999990147           |
    | 999992740           |
    | 999993306           |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | identificatiecode nummeraanduiding (11.90) | straatnaam (11.10)    |
    | 999993653           | 0599200000219678                           | Boterdiep             |
    | 999990147           | 0599200051001501                           | François Nivardstraat |
    | 999992740           | 0518200000617226                           | Leyweg                |
    | 999993306           | 0518200000617226                           | Leyweg                |
    En het systeem heeft personen met de volgende 'overlijden' gegevens
    | burgerservicenummer | datum overlijden (08.10) |
    | 999990147           | 20180526                 |

  Rule: nummeraanduiding identificatie is een verplichte parameter

    Scenario: Zoek met valide nummeraanduiding identificatie
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200000219678                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993653 |

    Scenario: Zoek met valide niet-gekoppelde nummeraanduiding identificatie
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000366054                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 0 personen

    Scenario: Meerdere personen hebben dezelfde nummeraanduiding identificatie
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0518200000617226                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 2 personen
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999992740 |
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999993306 |

    @fout-case
    Scenario: Zoek zonder nummeraanduiding identificatie
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
      | nummeraanduidingIdentificatie | titel                                               |
      |                               | Zoek met lege string nummeraanduiding identificatie |
      | 123456789012345               | Zoek met ongeldig nummeraanduiding identificatie    |

  Rule: Overleden personen worden standaard niet geretourneerd

    Scenario: Zoek exclusief overleden personen 
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200051001501                     |
      | inclusiefOverledenPersonen    | false                                |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 0 personen

    Scenario: Zoek exclusief overleden personen 
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200051001501                     |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 0 personen

    Abstract Scenario: Zoek inclusief overleden personen
      Als personen wordt gezocht met de volgende parameters
      | naam                          | waarde                               |
      | type                          | ZoekMetNummeraanduidingIdentificatie |
      | nummeraanduidingIdentificatie | 0599200051001501                     |
      | inclusiefOverledenPersonen    | true                                 |
      | fields                        | burgerservicenummer                  |
      Dan heeft de response 1 persoon
      En heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 999990147 |

    @fout-case
    Abstract Scenario: Zoek met ongeldig inclusiefOverledenPersonen parameter
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


Rule: een afgevoerde persoonslijst moet niet worden gevonden
  - wanneer reden opschorting bijhouding (07.67.20) is opgenomen met de waarde "F" (fout), moet deze persoon(slijst) niet worden gevonden bij zoeken

  Scenario: Zoek met nummeraanduidingIdentificatie van persoon op afgevoerde persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) |
    | 000000012                   |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode nummeraanduiding (11.90) |
    | 0599200000219678                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219678                     |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 0 personen

  Abstract Scenario: Zoek met nummeraanduidingIdentificatie van persoon op opgeschorte persoonslijst
    Gegeven een persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    En de persoon heeft de volgende 'persoon' gegevens
    | burgerservicenummer (01.20) |
    | 000000024                   |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode nummeraanduiding (11.90) |
    | 0599200000219678                           |
    Als personen wordt gezocht met de volgende parameters
    | naam                          | waarde                               |
    | type                          | ZoekMetNummeraanduidingIdentificatie |
    | nummeraanduidingIdentificatie | 0599200000219678                     |
    | inclusiefOverledenPersonen    | true                                 |
    | fields                        | burgerservicenummer                  |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met de volgende gegevens
    | naam                                     | waarde                           |
    | burgerservicenummer                      | 000000024                        |
    | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
    | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | .                            | onbekend                       |
