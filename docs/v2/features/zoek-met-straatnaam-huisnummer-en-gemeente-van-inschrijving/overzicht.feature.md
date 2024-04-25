---
layout: page-with-side-nav
title: Zoek met straatnaam/naam openbare ruimte, huisnummer en gemeente van inschrijving
---
#language: nl  


# Functionaliteit: Zoek met straatnaam/naam openbare ruimte, huisnummer en gemeente van inschrijving


## Regel: Straat (niet hoofdlettergevoelig), huisnummer en gemeente van inschrijving zijn verplichte parameters

Straat parameter zoekt over zowel straatnaam als naam openbare ruimte  

### Abstract Scenario: Zoek een persoon met de volledige straat, huisnummer van het adres en code van de gemeente waar hij is ingeschreven

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
  |----------------------|--------------------|--------------------|
  | 0599                 | Boterdiep          | 32                 |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | \<straat\>                                         |
  | huisnummer              | 32                                               |
  | gemeenteVanInschrijving | 0599                                             |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |

#### Voorbeelden:


  | straat    |
  |-----------|
  | Boterdiep |
  | boterdiep |
  | BOTERDIEP |

### Scenario: Zoek een persoon waarvan de straat van zijn adres maar één karakter lang is

* __Gegeven__ de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0693                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
  |----------------------|--------------------|--------------------|
  | 0693                 | A                  | 14                 |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | a                                                |
  | huisnummer              | 14                                               |
  | gemeenteVanInschrijving | 0693                                             |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |

### Scenario: Zoek een persoon met een straat die overeenkomt met de naam openbare ruimte van zijn adres

* __Gegeven__ de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) |
  |----------------------|--------------------------|------------------------------|--------------------|
  | 0518                 | Ln Copes van Cattenburch | Laan Copes van Cattenburch   | 39                 |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | Laan Copes van Cattenburch                       |
  | huisnummer              | 39                                               |
  | gemeenteVanInschrijving | 0518                                             |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |

## Regel: Optionele 'adres' parameters (niet hooflettergevoelig) kunnen worden toegevoegd om de zoek criteria aan te scherpen.


### Abstract Scenario: Zoek een persoon met huisletter

* __Gegeven__ de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
  |----------------------|--------------------|--------------------|
  | 0518                 | Leyweg             | 62                 |
* __En__ de persoon met burgerservicenummer '000000027' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) |
  |----------------------|--------------------|--------------------|--------------------|
  | 0518                 | Leyweg             | 62                 | e                  |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | leyweg                                           |
  | huisnummer              | 62                                               |
  | gemeenteVanInschrijving | 0518                                             |
  | huisletter              | \<huisletter\>                                     |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000027 |

#### Voorbeelden:


  | huisletter |
  |------------|
  | e          |
  | E          |

### Abstract Scenario: Zoek een persoon met huisnummertoevoeging

* __Gegeven__ de persoon met burgerservicenummer '000000028' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0344                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) |
  |----------------------|--------------------|--------------------|--------------------|------------------------------|
  | 0344                 | St. Jacobsstraat   | 401                | L                  | Toe                          |
* __En__ de persoon met burgerservicenummer '000000029' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0363                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
  |----------------------|--------------------|--------------------|------------------------------|
  | 0363                 | Vitternkade        | 102                | II                           |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | \<straat\>                                         |
  | huisnummer              | \<huisnummer\>                                     |
  | gemeenteVanInschrijving | \<gemeente van inschrijving\>                      |
  | huisnummertoevoeging    | \<huisnummer toevoeging\>                          |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde                |
  |---------------------|-----------------------|
  | burgerservicenummer | \<burgerservicenummer\> |

#### Voorbeelden:


  | burgerservicenummer | gemeente van inschrijving | straat           | huisnummer | huisnummer toevoeging | opmerking                            |
  |---------------------|---------------------------|------------------|------------|-----------------------|--------------------------------------|
  | 000000028           | 0344                      | St. Jacobsstraat | 401        | Toe                   | verblijfplaats heeft ook huisletter  |
  | 000000028           | 0344                      | St. Jacobsstraat | 401        | TOE                   | verblijfplaats heeft ook huisletter  |
  | 000000029           | 0363                      | Vitternkade      | 102        | II                    | verblijfplaats heeft geen huisletter |
  | 000000029           | 0363                      | Vitternkade      | 102        | ii                    | verblijfplaats heeft geen huisletter |

## Regel: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden


### Scenario: Zoek een overleden persoon

* __Gegeven__ een adres heeft de volgende gegevens

  | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
  |----------------------|--------------------|--------------------|
  | 0363                 | Afrikanerplein     | 2                  |
* __En__ de persoon met burgerservicenummer '000000028' is ingeschreven op het adres met de volgende gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0363                              |
* __En__ de persoon met burgerservicenummer '000000029' is ingeschreven op het adres met de volgende gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0363                              |
* __En__ de persoon heeft de volgende 'inschrijving' gegevens

  | naam                                 | waarde |
  |--------------------------------------|--------|
  | reden opschorting bijhouding (67.20) | O      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                                           |
  |----------------------------|--------------------------------------------------|
  | type                       | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                     | Afrikanerplein                                   |
  | huisnummer                 | 2                                                |
  | gemeenteVanInschrijving    | 0363                                             |
  | inclusiefOverledenPersonen | true                                             |
  | fields                     | burgerservicenummer                              |
* __Dan__ heeft de response 2 personen
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000028 |
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000029 |
* __En__ heeft de persoon de volgende 'opschortingBijhouding' gegevens

  | naam               | waarde     |
  |--------------------|------------|
  | reden.code         | O          |
  | reden.omschrijving | overlijden |

## Regel: Voor de straat parameter kan wildcard matching (niet hooflettergevoelig) worden toegepast.

Er moet dan minimaal 7 letters (exclusief de wildcard "*" teken) worden opgegeven.  
De wildcard komt overeen met nul of meer (niet-spatie) karakters.  
De wildcard kan als eerste of als laatste karakter worden opgegeven.  

### Abstract Scenario: Zoek een persoon met "*" wildcard matching als laatste karakter in straat

* __Gegeven__ de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) |
  |----------------------|--------------------------|------------------------------|--------------------|
  | 0518                 | Ln Copes van Cattenburch | Laan Copes van Cattenburch   | 39                 |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | \<straat\>                                         |
  | huisnummer              | 39                                               |
  | gemeenteVanInschrijving | 0518                                             |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |

#### Voorbeelden:


  | straat   |
  |----------|
  | ln cope* |
  | laan co* |

### Scenario: Zoek een persoon met "*" wildcard matching als eerste karakter in straat

* __Gegeven__ de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0518                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | straatnaam (11.10)       | naam openbare ruimte (11.15) | huisnummer (11.20) |
  |----------------------|--------------------------|------------------------------|--------------------|
  | 0518                 | Ln Copes van Cattenburch | Laan Copes van Cattenburch   | 39                 |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                                           |
  |-------------------------|--------------------------------------------------|
  | type                    | ZoekMetStraatHuisnummerEnGemeenteVanInschrijving |
  | straat                  | *enburch                                         |
  | huisnummer              | 39                                               |
  | gemeenteVanInschrijving | 0518                                             |
  | fields                  | burgerservicenummer                              |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |

