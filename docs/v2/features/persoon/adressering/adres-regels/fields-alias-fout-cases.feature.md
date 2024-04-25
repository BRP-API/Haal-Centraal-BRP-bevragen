---
layout: page-with-side-nav
title: adressering - fields alias fout cases
---
#language: nl  


# Functionaliteit: adressering - fields alias fout cases


## Regel: de 'adresseringBinnenland' field alias moet worden gebruikt door een consumer niet is geautoriseerd voor het bevragen van adresregels horende bij verblijfplaats buitenland


`@fout-case`
### Abstract Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt zonder de fields alias één of meer adresregel velden

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | \<field\>                         |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                                  |
  |----------|-------------------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3             |
  | title    | U bent niet geautoriseerd voor één of meerdere opgegeven field waarden. |
  | status   | 403                                                                     |
  | code     | unauthorizedField                                                       |
  | instance | /haalcentraal/api/brp/personen                                          |

#### Voorbeelden:


  | field                   |
  |-------------------------|
  | adressering             |
  | adressering.adresregel1 |
  | adressering.land        |

## Regel: de 'adresseringBinnenland' field alias kan niet worden gebruikt in combinatie met de adresregel velden voor verblijfplaats buitenland


`@fout-case`
### Abstract Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias het 'land' veld van de adressering gegevensgroep

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | adresseringBinnenland.\<field\>   |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: fields[0].                   |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/brp/personen                              |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code   | name      | reason                                       |
  |--------|-----------|----------------------------------------------|
  | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

#### Voorbeelden:


  | field       |
  |-------------|
  | adresregel3 |
  | land        |
