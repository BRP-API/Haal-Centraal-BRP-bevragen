#language: nl

Functionaliteit: Persoon beperkt: adressering velden vragen met fields/fields alias

  Wanneer een consumer van de BRP API niet is geautoriseerd voor het bevragen van de adresregel velden voor een verblijfplaats buitenland
  Dan moet de consumer de adresseringBinnenland fields alias gebruiken om aan te geven dat hij adresregel velden voor een verblijfplaats binnenland vraagt

Regel: de standaard adresregel veld paden kunnen worden gebruikt door een consumer die is geautoriseerd voor het vragen van adresregels horende bij verblijfplaats binnenland (adres, locatie) en verblijfplaats buitenland

  Scenario: afnemer is geautoriseerd voor zowel 'adressering binnen- en buitenland' en vraagt alle adresregel velden met hun volledig pad
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                                                   |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                                      |
    | geslachtsnaam | Maassen                                                                                  |
    | geboortedatum | 1983-05-26                                                                               |
    | fields        | adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam              | waarde                       |
    | adresregel1       | 1600 Pennsylvania Avenue NW  |
    | adresregel2       | Washington, DC 20500         |
    | adresregel3       | Selangor                     |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

  Abstract Scenario: afnemer is geautoriseerd voor zowel 'adressering binnen- & buitenland' en vraagt het <field> veld van de adressering gegevensgroep
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<field>                 |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam    | waarde   |
    | <field> | <waarde> |

    Voorbeelden:
    | field       | waarde                      |
    | adresregel1 | 1600 Pennsylvania Avenue NW |
    | adresregel2 | Washington, DC 20500        |
    | adresregel3 | Selangor                    |

  Scenario: afnemer is geautoriseerd voor zowel 'adressering binnen- & buitenland' en vraagt het land veld van de adressering gegevensgroep
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.land                    |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

Regel: de 'adresseringBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het vragen van adresregels horende bij verblijfplaats buitenland

  Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias alle adresregel velden met hun volledig pad van een verblijfplaats buitenland
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                 |
    | geslachtsnaam | Maassen                                                             |
    | geboortedatum | 1983-05-26                                                          |
    | fields        | adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |
    Dan heeft de response een persoon zonder gegevens

  Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias alle adresregel velden met hun volledig pad van een adres
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                  | waarde |
    | functie adres (10.10) | W      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde          |
    | gemeentecode (92.10) | 0518            |
    | straatnaam (11.10)   | Borgesiusstraat |
    | huisnummer (11.20)   | 103             |
    | postcode (11.60)     | 2497BV          |
    | woonplaats (11.70)   | Scheveningen    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                                                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum                                 |
    | geslachtsnaam | Maassen                                                             |
    | geboortedatum | 1983-05-26                                                          |
    | fields        | adresseringBinnenland.adresregel1,adresseringBinnenland.adresregel2 |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel1 | Borgesiusstraat 103   |
    | adresregel2 | 2497 BV  SCHEVENINGEN |

  Abstract Scenario: afnemer is niet geautoriseerd voor 'adressering buitenland' en vraagt met de fields alias het <field> veld van adressering gegevensgroep van een verblijfplaats buitenland
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'adressering binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | naam                  | waarde   |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adresseringBinnenland.<field>       |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | field       |
    | adresregel1 |
    | adresregel2 |
