---
layout: page-with-side-nav
title: adressering velden vragen met fields/fields alias
---
#language: nl  


# Functionaliteit: Persoon: adressering velden vragen met fields/fields alias


Wanneer een consumer van de BRP API niet is geautoriseerd voor het bevragen van de adresregel velden voor een verblijfplaats buitenland  
* __Dan__ moet de consumer de adresseringBinnenland fields alias gebruiken om aan te geven dat hij adresregel velden voor een verblijfplaats binnenland vraagt

## Regel: de standaard adresregel veld paden kunnen worden gebruikt door een consumer die is geautoriseerd voor het vragen van adresregels horende bij verblijfplaats binnenland (adres, locatie) en verblijfplaats buitenland


### Abstract Scenario: afnemer is geautoriseerd voor 'adressering buitenland' en vraagt \<sub titel\>

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'adressering' gegevens

  | naam              | waarde                       |
  |-------------------|------------------------------|
  | adresregel1       | 1600 Pennsylvania Avenue NW  |
  | adresregel2       | Washington, DC 20500         |
  | adresregel3       | Selangor                     |
  | land.code         | 6014                         |
  | land.omschrijving | Verenigde Staten van Amerika |

#### Voorbeelden:


  | fields                                                                                   | sub titel                                   |
  |------------------------------------------------------------------------------------------|---------------------------------------------|
  | adressering                                                                              | de adressering gegevensgroep veld           |
  | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land | alle adresregel velden met hun volledig pad |

### Scenario: afnemer vraagt adresseringBinnenland én verblijfplaats en de persoon heeft buitenlandse verblijfplaats

* __Gegeven__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                                             |
  |---------------------|----------------------------------------------------|
  | type                | RaadpleegMetBurgerservicenummer                    |
  | burgerservicenummer | 000000097                                          |
  | fields              | adresseringBinnenland,verblijfplaats.verblijfadres |
* __Dan__ heeft de response een persoon met de volgende 'verblijfplaats' gegevens

  | naam                            | waarde                       |
  |---------------------------------|------------------------------|
  | type                            | VerblijfplaatsBuitenland     |
  | verblijfadres.regel1            | 1600 Pennsylvania Avenue NW  |
  | verblijfadres.regel2            | Washington, DC 20500         |
  | verblijfadres.regel3            | Selangor                     |
  | verblijfadres.land.code         | 6014                         |
  | verblijfadres.land.omschrijving | Verenigde Staten van Amerika |

### Abstract Scenario: afnemer is geautoriseerd voor 'adressering buitenland' en vraagt het \<field\> veld van de adressering gegevensgroep

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | adressering.\<field\>             |
* __Dan__ heeft de response een persoon met de volgende 'adressering' gegevens

  | naam    | waarde   |
  |---------|----------|
  | \<field\> | <waarde> |

#### Voorbeelden:


  | field       | waarde                      |
  |-------------|-----------------------------|
  | adresregel1 | 1600 Pennsylvania Avenue NW |
  | adresregel2 | Washington, DC 20500        |
  | adresregel3 | Selangor                    |

### Scenario: afnemer is geautoriseerd voor 'adressering buitenland' en vraagt het land veld van de adressering gegevensgroep

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | adressering.land                |
* __Dan__ heeft de response een persoon met de volgende 'adressering' gegevens

  | naam              | waarde                       |
  |-------------------|------------------------------|
  | land.code         | 6014                         |
  | land.omschrijving | Verenigde Staten van Amerika |

## Regel: de 'adresseringBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het vragen van adresregels horende bij verblijfplaats buitenland


### Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias de adresregel velden van een verblijfplaats buitenland

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon zonder gegevens

#### Voorbeelden:


  | fields                                                              |
  |---------------------------------------------------------------------|
  | adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |

### Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias de adresregel velden van een adres

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                  | waarde |
  |-----------------------|--------|
  | functie adres (10.10) | W      |
* __En__ de 'verblijfplaats' heeft de volgende 'adres' gegevens

  | naam                 | waarde          |
  |----------------------|-----------------|
  | gemeentecode (92.10) | 0518            |
  | straatnaam (11.10)   | Borgesiusstraat |
  | huisnummer (11.20)   | 103             |
  | postcode (11.60)     | 2497BV          |
  | woonplaats (11.70)   | Scheveningen    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | \<fields\>                        |
* __Dan__ heeft de response een persoon met de volgende 'adressering' gegevens

  | naam        | waarde                |
  |-------------|-----------------------|
  | adresregel1 | Borgesiusstraat 103   |
  | adresregel2 | 2497 BV  SCHEVENINGEN |

#### Voorbeelden:


  | fields                                                              |
  |---------------------------------------------------------------------|
  | adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |

### Abstract Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias een adresregel veld van een verblijfplaats buitenland

* __Gegeven__ de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
* __En__ de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens

  | naam                             | waarde                      |
  |----------------------------------|-----------------------------|
  | land adres buitenland (13.10)    | 6014                        |
  | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
  | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
  | regel 3 adres buitenland (13.50) | Selangor                    |
* __Als__ personen wordt gezocht met de volgende parameters

  | naam                | waarde                          |
  |---------------------|---------------------------------|
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000097                       |
  | fields              | adresseringBinnenland.\<field\>   |
* __Dan__ heeft de response een persoon zonder gegevens

#### Voorbeelden:


  | field       |
  |-------------|
  | adresregel1 |
  | adresregel2 |

