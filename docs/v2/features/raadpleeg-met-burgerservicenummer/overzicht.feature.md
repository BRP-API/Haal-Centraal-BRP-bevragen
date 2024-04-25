---
layout: page-with-side-nav
title: Raadpleeg met burgerservicenummer
---
#language: nl  


# Functionaliteit: Raadpleeg met burgerservicenummer


## Regel: voor het raadplegen van een persoon moet zijn burgerservicenummer worden opgegeven


### Scenario: Raadpleeg één persoon

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende gegevens

  | anummer (01.10) |
  |-----------------|
  | 0123456789      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000024                       |
  | fields              | burgerservicenummer             |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |

## Regel: voor het raadplegen van meerdere personen moeten hun burgerservicenummers worden opgegeven


### Scenario: Raadpleeg meerdere personen

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende gegevens

  | anummer (01.10) |
  |-----------------|
  | 0123456789      |
* __En__ de persoon met burgerservicenummer '000000025' heeft de volgende gegevens

  | anummer (01.10) |
  |-----------------|
  | 1234567890      |
* __En__ de persoon met burgerservicenummer '000000026' heeft de volgende gegevens

  | anummer (01.10) |
  |-----------------|
  | 2345678901      |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000024,000000025,000000026   |
  | fields              | burgerservicenummer             |
* __Dan__ heeft de response 3 personen
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000025 |
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000026 |

## Regel: De optionele 'gemeenteVanInschrijving' parameter kan worden toegevoegd om de zoek criteria aan te scherpen


### Scenario: Raadpleeg persoon met gemeenteVanInschrijving

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                          |
  |-------------------------|---------------------------------|
  | type                    | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer     | 000000024                       |
  | gemeenteVanInschrijving | 0599                            |
  | fields                  | burgerservicenummer             |
* __Dan__ heeft de response 1 persoon
* __En__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000024 |

### Scenario: Raadpleeg persoon met gemeenteVanInschrijving

* __Gegeven__ de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0599                              |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                    | waarde                          |
  |-------------------------|---------------------------------|
  | type                    | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer     | 000000024                       |
  | gemeenteVanInschrijving | 0518                            |
  | fields                  | burgerservicenummer             |
* __Dan__ heeft de response 0 personen

