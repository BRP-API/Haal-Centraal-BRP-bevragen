---
layout: page-with-side-nav
title: Zoek met postcode en huisnummer
---
#language: nl  


# Functionaliteit: Zoek met postcode en huisnummer


### Achtergrond:

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
  |----------------------|------------------|--------------------|
  | 0599                 | 2628HJ           | 2                  |
* __En__ de persoon met burgerservicenummer '000000025' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | huisletter (11.30) |
  |----------------------|------------------|--------------------|--------------------|
  | 0599                 | 2628HJ           | 2                  | A                  |
* __En__ de persoon met burgerservicenummer '000000026' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | huisnummertoevoeging (11.40) |
  |----------------------|------------------|--------------------|------------------------------|
  | 0599                 | 2628HJ           | 2                  | III                          |
* __En__ de persoon met burgerservicenummer '000000027' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) | aanduiding bij huisnummer (11.50) |
  |----------------------|------------------|--------------------|-----------------------------------|
  | 0599                 | 2628HJ           | 2                  | to                                |
* __En__ de persoon met burgerservicenummer '000000028' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
  |----------------------|------------------|--------------------|
  | 0599                 | 2629HJ           | 2                  |
* __En__ de persoon heeft de volgende 'inschrijving' gegevens

  | naam                                 | waarde |
  |--------------------------------------|--------|
  | reden opschorting bijhouding (67.20) | O      |
* __En__ de persoon met burgerservicenummer '000000029' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0600                              |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | gemeentecode (92.10) | postcode (11.60) | huisnummer (11.20) |
  |----------------------|------------------|--------------------|
  | 0600                 | 2630HJ           | 2                  |

## Regel: Postcode (niet hoofdlettergevoelig) en huisnummer zijn verplichte parameters. Postcode mag zowel met als zonder spatie tussen de cijfer- en letterdeel worden verstrekt.


### Abstract Scenario: Zoek een persoon met de postcode (\<sub-titel\>) en huisnummer van het adres van zijn verblijfplaats

* __Als__ personen wordt gezocht met de volgende parameters

  | naam       | waarde                      |
  |------------|-----------------------------|
  | type       | ZoekMetPostcodeEnHuisnummer |
  | postcode   | \<postcode\>                  |
  | huisnummer | 2                           |
  | fields     | burgerservicenummer         |
* __Dan__ heeft de response 4 personen
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000027 |

#### Voorbeelden:


  | postcode | sub-titel                                                             |
  |----------|-----------------------------------------------------------------------|
  | 2628HJ   | letters zijn hoofdletters                                             |
  | 2628hj   | letters zijn kleine letters                                           |
  | 2628 HJ  | spatie tussen de cijfers en hoofdletters                              |
  | 2628 hj  | spatie tussen de cijfers en kleine letters                            |
  | 2628 Hj  | spatie tussen de cijfers en letters (zowel hoofd- als kleine letters) |

## Regel: Optionele 'adres' parameters (niet hooflettergevoelig) kunnen worden toegevoegd om de zoek criteria aan te scherpen.


### Abstract Scenario: Zoek een persoon met de postcode, huisnummer en huisletter van het adres van zijn verblijfplaats

* __Als__ personen wordt gezocht met de volgende parameters

  | naam       | waarde                      |
  |------------|-----------------------------|
  | type       | ZoekMetPostcodeEnHuisnummer |
  | postcode   | 2628HJ                      |
  | huisnummer | 2                           |
  | huisletter | \<huisletter\>                |
  | fields     | burgerservicenummer         |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |

#### Voorbeelden:


  | huisletter |
  |------------|
  | A          |
  | a          |

### Abstract Scenario: Zoek een persoon met de postcode, huisnummer en huisnummertoevoeging van het adres van zijn verblijfplaats

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                 | waarde                      |
  |----------------------|-----------------------------|
  | type                 | ZoekMetPostcodeEnHuisnummer |
  | postcode             | 2628HJ                      |
  | huisnummer           | 2                           |
  | huisnummertoevoeging | \<huisnummertoevoeging\>      |
  | fields               | burgerservicenummer         |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |

#### Voorbeelden:


  | huisnummertoevoeging |
  |----------------------|
  | III                  |
  | iii                  |
  | Iii                  |

### Scenario: Zoek een persoon met de postcode, huisnummer en gemeenteVanInschrijving code van het adres van zijn verblijfplaats

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                      |
  |-------------------------|-----------------------------|
  | type                    | ZoekMetPostcodeEnHuisnummer |
  | postcode                | 2630HJ                      |
  | huisnummer              | 2                           |
  | gemeenteVanInschrijving | 0600                        |
  | fields                  | burgerservicenummer         |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000029 |

## Regel: De optionele 'inclusiefOverledenPersonen' parameter moet worden opgegeven om een overleden persoon te kunnen vinden


### Scenario: Zoek een overleden persoon

* __Als__ personen wordt gezocht met de volgende parameters

  | naam                       | waarde                      |
  |----------------------------|-----------------------------|
  | type                       | ZoekMetPostcodeEnHuisnummer |
  | postcode                   | 2629HJ                      |
  | huisnummer                 | 2                           |
  | inclusiefOverledenPersonen | true                        |
  | fields                     | burgerservicenummer         |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000028 |
* __En__ heeft de persoon de volgende 'opschortingBijhouding' gegevens

  | naam               | waarde     |
  |--------------------|------------|
  | reden.code         | O          |
  | reden.omschrijving | overlijden |

