#language: nl

Functionaliteit: verblijfplaats - fields alias fout cases

  Abstract Scenario: consumer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt zonder de fields alias één of meer verblijfplaats velden
    Gegeven de consumer is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <field>                         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3 |
    | title    | U bent niet geautoriseerd voor deze operatie.               |
    | status   | 403                                                         |
    | detail   | De foutieve parameter(s) zijn: fields.                      |
    | code     | autorisation                                                |
    | instance | /haalcentraal/api/brp/personen                              |
    En heeft het object de volgende 'invalidParams' gegevens
    | code         | name   | reason                                                           |
    | autorisation | fields | niet geautoriseerd voor één of meerdere opgegeven field waarden. |

    Voorbeelden:
    | field                             |
    | verblijfplaats                    |
    | verblijfplaats.datumVan           |
    | verblijfplaats.verblijfadres      |
    | verblijfplaats.verblijfadres.land |

  Scenario: consumer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt met de fields alias één of meerdere 'verblijfplaats buitenland' velden
    Gegeven de consumer is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                      |
    | type                | RaadpleegMetBurgerservicenummer             |
    | burgerservicenummer | 000000097                                   |
    | fields              | verblijfplaatsBinnenland.verblijfadres.land |
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
