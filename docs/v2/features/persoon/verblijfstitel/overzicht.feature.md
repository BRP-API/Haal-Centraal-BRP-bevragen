---
layout: page-with-side-nav
title: verblijfstitel velden vragen met fields
---
# language: nl  


# Functionaliteit: verblijfstitel velden vragen met fields


### Achtergrond:

* __Gegeven__ landelijke tabel "Verblijfstitel" heeft de volgende waarden

  | code | omschrijving                                                                   |
  |------|--------------------------------------------------------------------------------|
  | 00   | Onbekend                                                                       |
  | 37   | Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec. |

## Regel: een verblijfstitel wordt alleen geleverd wanneer die nog geldig is

- een verblijfstitel wordt geleverd wanneer Datum einde verblijfstitel (39.20) leeg is of een datum in de toekomst heeft  
- een verblijfstitel wordt NIET geleverd wanneer Datum einde verblijfstitel (39.20) vandaag is of een datum in het verleden heeft  

### Scenario: persoon heeft geen verblijfstitel

* __Gegeven__ de persoon met burgerservicenummer '000000309' heeft de volgende gegevens

  | naam                  | waarde |
  |-----------------------|--------|
  | geslachtsnaam (02.40) | Jansen |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000309                       |
  | fields              | verblijfstitel.aanduiding       |
* __Dan__ heeft de response een persoon zonder gegevens

### Scenario: verblijfstitel heeft geen datum einde

* __Gegeven__ de persoon met burgerservicenummer '000000103' heeft de volgende 'verblijfstitel' gegevens

  | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
  |-----------------------------------|-------------------------------------|
  | 37                                | 20210315                            |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000103                       |
  | fields              | verblijfstitel.aanduiding       |
* __Dan__ heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens

  | naam                    | waarde                                                                         |
  |-------------------------|--------------------------------------------------------------------------------|
  | aanduiding.code         | 37                                                                             |
  | aanduiding.omschrijving | Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec. |

### Abstract Scenario: verblijfstitel heeft \<titel\>

* __Gegeven__ de persoon met burgerservicenummer '000000115' heeft de volgende 'verblijfstitel' gegevens

  | aanduiding verblijfstitel (39.10) | datum einde verblijfstitel (39.20) | datum ingang verblijfstitel (39.30) |
  |-----------------------------------|------------------------------------|-------------------------------------|
  | 37                                | \<datumEinde\>                       | 20210315                            |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000115                       |
  | fields              | verblijfstitel.aanduiding       |
* __Dan__ heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens

  | naam                    | waarde                                                                         |
  |-------------------------|--------------------------------------------------------------------------------|
  | aanduiding.code         | 37                                                                             |
  | aanduiding.omschrijving | Vw 2000 art. 8, onder e, gemeenschapsonderdaan econ. niet-actief, arbeid spec. |

#### Voorbeelden:


  | titel                      | datumEinde |
  |----------------------------|------------|
  | datum einde in de toekomst | 20350315   |
  | datum einde is morgen      | morgen     |

### Abstract Scenario: verblijfstitel heeft \<titel\>

* __Gegeven__ de persoon met burgerservicenummer '000000127' heeft de volgende 'verblijfstitel' gegevens

  | aanduiding verblijfstitel (39.10) | datum einde verblijfstitel (39.20) | datum ingang verblijfstitel (39.30) |
  |-----------------------------------|------------------------------------|-------------------------------------|
  | 37                                | \<datumEinde\>                       | 20210315                            |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                                             |
  |---------------------|----------------------------------------------------|
  | type                | RaadpleegMetBurgerservicenummer                    |
  | burgerservicenummer | 000000127                                          |
  | fields              | burgerservicenummer,verblijfstitel.aanduiding.code |
* __Dan__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000127 |

#### Voorbeelden:


  | titel                       | datumEinde |
  |-----------------------------|------------|
  | datum einde is vandaag      | vandaag    |
  | datum einde in het verleden | 20220315   |

## Regel: een verblijfstitel met aanduiding 98 "geen verblijfstitel (meer)" wordt niet opgenomen


### Scenario: vervallen verblijfstitel

* __Gegeven__ de persoon met burgerservicenummer '000000139' heeft de volgende 'verblijfstitel' gegevens

  | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
  |-----------------------------------|-------------------------------------|
  | 98                                | 20210315                            |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                                        |
  |---------------------|-----------------------------------------------|
  | type                | RaadpleegMetBurgerservicenummer               |
  | burgerservicenummer | 000000139                                     |
  | fields              | burgerservicenummer,verblijfstitel.aanduiding |
* __Dan__ heeft de response een persoon met alleen de volgende gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000139 |

## Regel: Een verblijfstitel met onbekende aanduiding wordt wel geleverd


### Scenario: persoon heeft verblijfstitel maar het is nog onbekend welke

* __Gegeven__ de persoon met burgerservicenummer '000000140' heeft de volgende 'verblijfstitel' gegevens

  | aanduiding verblijfstitel (39.10) | datum ingang verblijfstitel (39.30) |
  |-----------------------------------|-------------------------------------|
  | 00                                | 20210714                            |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000140                       |
  | fields              | verblijfstitel                  |
* __Dan__ heeft de response een persoon met alleen de volgende 'verblijfstitel' gegevens

  | naam                    | waarde       |
  |-------------------------|--------------|
  | aanduiding.code         | 00           |
  | aanduiding.omschrijving | Onbekend     |
  | datumIngang.type        | Datum        |
  | datumIngang.datum       | 2021-07-14   |
  | datumIngang.langFormaat | 14 juli 2021 |

