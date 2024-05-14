#language: nl

Functionaliteit: adressering - fields alias fout cases


Regel: de 'adresseringBinnenland' field alias kan niet worden gebruikt in combinatie met de adresregel velden voor verblijfplaats buitenland

  @fout-case
  Abstract Scenario: afnemer vraagt met de fields alias het '<field>' veld van de adresseringBinnenland gegevensgroep
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | adresseringBinnenland.<field>   |
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
    | field       |
    | adresregel3 |
    | land        |
