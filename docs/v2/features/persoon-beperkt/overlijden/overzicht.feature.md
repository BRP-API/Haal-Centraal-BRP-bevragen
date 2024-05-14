---
layout: page-with-side-nav
title: Persoon beperkt: overlijden
---
# language: nl  


# Functionaliteit: Persoon beperkt: overlijden


Wanneer een consumer van de BRP API personen zoekt inclusief overleden personen  
* __Dan__ wil de consumer worden geattendeerd welke van de gevonden personen zijn overleden zonder expliciet om overlijden gegevens te vragen met de fields parameter

## Regel: opschorting bijhouding met reden "O" wordt altijd geleverd bij een gevonden overleden persoon is overleden. Ook als het niet met fields is gevraagd


### Abstract Scenario: \<sub titel\> van een niet-overleden persoon

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | geslachtsnaam (02.40) | geboortedatum (03.10) |
  |-----------------------|-----------------------|
  | Jansen                | 19630405              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                              |
  |----------------------------|-------------------------------------|
  | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
  | geslachtsnaam              | Jansen                              |
  | geboortedatum              | 1963-04-05                          |
  | inclusiefOverledenPersonen | true                                |
  | fields                     | \<fields\>                            |
* __Dan__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000152 |

#### Voorbeelden:


  | sub titel                                         | fields              |
  |---------------------------------------------------|---------------------|
  | opschorting bijhouding velden wordt niet gevraagd | burgerservicenummer |

### Scenario: opschorting bijhouding gegevens wordt niet gevraagd van een overleden persoon

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | geslachtsnaam (02.40) | geboortedatum (03.10) |
  |-----------------------|-----------------------|
  | Jansen                | 19630405              |
* __En__ de persoon heeft de volgende 'inschrijving' gegevens

  | naam                                 | waarde |
  |--------------------------------------|--------|
  | reden opschorting bijhouding (67.20) | O      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                              |
  |----------------------------|-------------------------------------|
  | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
  | geslachtsnaam              | Jansen                              |
  | geboortedatum              | 1963-04-05                          |
  | inclusiefOverledenPersonen | true                                |
  | fields                     | burgerservicenummer                 |
* __Dan__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000152 |
* __En__ heeft de persoon de volgende 'opschortingBijhouding' gegevens

  | naam               | waarde     |
  |--------------------|------------|
  | reden.code         | O          |
  | reden.omschrijving | overlijden |

## Regel: leeftijd veld wordt niet geleverd voor overleden personen


### Scenario: leeftijd wordt gevraagd van een overleden persoon

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft de volgende gegevens

  | geslachtsnaam (02.40) | geboortedatum (03.10) |
  |-----------------------|-----------------------|
  | Jansen                | 19630405              |
* __En__ de persoon heeft de volgende 'overlijden' gegevens

  | datum overlijden (08.10) | plaats overlijden (08.20) | land overlijden (08.30) |
  |--------------------------|---------------------------|-------------------------|
  | 20020701                 | 0518                      | 6030                    |
* __En__ de persoon heeft de volgende 'inschrijving' gegevens

  | naam                                 | waarde |
  |--------------------------------------|--------|
  | reden opschorting bijhouding (67.20) | O      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                              |
  |----------------------------|-------------------------------------|
  | type                       | ZoekMetGeslachtsnaamEnGeboortedatum |
  | geslachtsnaam              | Jansen                              |
  | geboortedatum              | 1963-04-05                          |
  | inclusiefOverledenPersonen | true                                |
  | fields                     | leeftijd                            |
* __Dan__ heeft de response een persoon met alleen de volgende 'opschortingBijhouding' gegevens

  | naam               | waarde     |
  |--------------------|------------|
  | reden.code         | O          |
  | reden.omschrijving | overlijden |

