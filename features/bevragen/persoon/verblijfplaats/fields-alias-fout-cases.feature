#language: nl

Functionaliteit: verblijfplaats - fields alias fout cases

Regel: de standaard verblijfplaats field paden mag niet worden gebruikt door een consumer die niet is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

  @autorisatie @fout-case
  Abstract Scenario: afnemer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt zonder de fields alias één of meer verblijfplaats velden
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <field>                         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                  |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
    | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
    | status   | 403                                                                     |
    | code     | unauthorizedField                                                       |
    | instance | /haalcentraal/api/brp/personen                                          |

    Voorbeelden:
    | field                             |
    | verblijfplaats                    |
    | verblijfplaats.datumVan           |
    | verblijfplaats.verblijfadres      |
    | verblijfplaats.verblijfadres.land |

Regel: de field alias 'verblijfplaatsBinnenland' mag niet worden gebruikt voor het vragen van 'verblijfplaats buitenland' velden

  @fout-case
  Abstract Scenario: de fields alias wordt gebruikt voor het vragen van één of meerdere 'verblijfplaats buitenland' velden
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <fields>                        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: fields[0].                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code   | name      | reason                                       |
    | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

    Voorbeelden:
    | fields                                        |
    | verblijfplaatsBinnenland.verblijfadres.regel1 |
    | verblijfplaatsBinnenland.verblijfadres.regel2 |
    | verblijfplaatsBinnenland.verblijfadres.regel3 |
    | verblijfplaatsBinnenland.verblijfadres.land   |