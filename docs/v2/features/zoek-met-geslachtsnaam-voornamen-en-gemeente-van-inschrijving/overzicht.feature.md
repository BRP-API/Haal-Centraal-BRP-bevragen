---
layout: page-with-side-nav
title: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving
---
#language: nl  


# Functionaliteit: Zoek met geslachtsnaam, voornamen en gemeente van inschrijving


## Regel: Geslachtsnaam, voornamen (beide niet hoofdlettergevoelig) en gemeenteVanInschrijving zijn verplichte parameters


### Abstract Scenario: Zoek een persoon met zijn volledige geslachtsnaam, voornamen en de code van de gemeente waar hij is ingeschreven

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) |
  |-----------------------|-------------------|
  | Maassen               | Pieter            |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0014                              |
* __En__ de persoon met burgerservicenummer '000000025' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
  |-----------------------|-------------------|---------------------|
  | Maassen               | Jan Peter         | van                 |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0014                              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                               |
  |-------------------------|--------------------------------------|
  | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
  | geslachtsnaam           | \<geslachtsnaam\>                      |
  | voornamen               | \<voornamen\>                          |
  | gemeenteVanInschrijving | 0014                                 |
  | fields                  | burgerservicenummer                  |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |

#### Voorbeelden:


  | geslachtsnaam | voornamen |
  |---------------|-----------|
  | Maassen       | Pieter    |
  | MAASSEN       | PIETER    |
  | MAASSEN       | pieter    |

### Scenario: Zoek een persoon wiens geslachtsnaam twee karakters lang is

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) |
  |-----------------------|-------------------|
  | Os                    | Miriam            |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0015                              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                               |
  |-------------------------|--------------------------------------|
  | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
  | geslachtsnaam           | os                                   |
  | voornamen               | Miriam                               |
  | gemeenteVanInschrijving | 0015                                 |
  | fields                  | burgerservicenummer                  |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |

## Regel: Optionele 'naam' parameters (niet hooflettergevoelig) kunnen worden toegevoegd om de zoek criteria aan te scherpen.


### Abstract Scenario: Zoek een persoon met volledige voorvoegsel

* __Gegeven__ de persoon met burgerservicenummer '000000025' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
  |-----------------------|-------------------|---------------------|
  | Maassen               | Jan Peter         | van                 |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0014                              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                               |
  |-------------------------|--------------------------------------|
  | type                    | ZoekMetNaamEnGemeenteVanInschrijving |
  | geslachtsnaam           | Maassen                              |
  | voornamen               | Jan Peter                            |
  | voorvoegsel             | \<voorvoegsel\>                        |
  | gemeenteVanInschrijving | 0014                                 |
  | fields                  | burgerservicenummer                  |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |

#### Voorbeelden:


  | voorvoegsel |
  |-------------|
  | van         |
  | Van         |
  | VAN         |

## Regel: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden


### Scenario: Zoek een overleden persoon

* __Gegeven__ de persoon met burgerservicenummer '000000025' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
  |-----------------------|-------------------|---------------------|
  | Jansen                | Jan               | van                 |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0014                              |
* __En__ de persoon met burgerservicenummer '000000035' heeft de volgende gegevens

  | geslachtsnaam (02.40) | voornamen (02.10) | voorvoegsel (02.30) |
  |-----------------------|-------------------|---------------------|
  | Jansen                | Jan               | van den             |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0014                              |
* __En__ de persoon heeft de volgende 'inschrijving' gegevens

  | naam                                 | waarde |
  |--------------------------------------|--------|
  | reden opschorting bijhouding (67.20) | O      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                               |
  |----------------------------|--------------------------------------|
  | type                       | ZoekMetNaamEnGemeenteVanInschrijving |
  | geslachtsnaam              | Jansen                               |
  | voornamen                  | Jan                                  |
  | gemeenteVanInschrijving    | 0014                                 |
  | inclusiefOverledenPersonen | true                                 |
  | fields                     | burgerservicenummer                  |
* __Dan__ heeft de response 2 personen
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                          | waarde    |
  |-------------------------------|-----------|
  | burgerservicenummer           | 000000035 |
* __En__ heeft de persoon de volgende 'opschortingBijhouding' gegevens

  | naam               | waarde     |
  |--------------------|------------|
  | reden.code         | O          |
  | reden.omschrijving | overlijden |

