# language: nl

@post-assert
Functionaliteit: Persoonbeperkt adressering

  Scenario: adresregel1 voor een persoon met binnenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                         | waarde           |
    | straatnaam (11.10)           | St. Jacobsstraat |
    | huisnummer (11.20)           | 400              |
    | huisletter (11.30)           | L                |
    | huisnummertoevoeging (11.40) | Toe              |
    | postcode (11.60)             | 2497BV           |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2497BV                      |
    | huisnummer | 400                         |
    | fields     | adressering.adresregel1     |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                    |
    | adresregel1 | St. Jacobsstraat 400 LToe |

  Scenario: adresregel2 voor een persoon met binnenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                         | waarde           |
    | straatnaam (11.10)           | St. Jacobsstraat |
    | huisnummer (11.20)           | 400              |
    | huisletter (11.30)           | L                |
    | huisnummertoevoeging (11.40) | Toe              |
    | postcode (11.60)             | 2583XL           |
    | woonplaatsnaam (11.70)       | Scheveningen     |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2583XL                      |
    | huisnummer | 400                         |
    | fields     | adressering.adresregel2     |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                |
    | adresregel2 | 2583 XL  SCHEVENINGEN |

  Abstract Scenario: <field> voor een persoon met binnenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                         | waarde           |
    | straatnaam (11.10)           | St. Jacobsstraat |
    | huisnummer (11.20)           | 400              |
    | huisletter (11.30)           | L                |
    | huisnummertoevoeging (11.40) | Toe              |
    | postcode (11.60)             | 2583XL           |
    | woonplaatsnaam (11.70)       | Scheveningen     |
    Als personen wordt gezocht met de volgende parameters
    | naam       | waarde                      |
    | type       | ZoekMetPostcodeEnHuisnummer |
    | postcode   | 2583XL                      |
    | huisnummer | 400                         |
    | fields     | adressering.<field>         |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | field       |
    | adresregel3 |
    | land        |

  Scenario: adresregel1 voor een persoon met locatie
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde                     |
    | adresregel1 | Woonboot in de Grote Sloot |

  Scenario: adresregel2 voor een persoon met locatie
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeente van inschrijving (09.10)    | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel2             |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde        |
    | adresregel2 | 'S-GRAVENHAGE |

  Abstract Scenario: <field> voor een persoon met locatie
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                                 | waarde        |
    | gemeente van inschrijving (09.10)    | 0518          |
    | gemeenteVanInschrijving.omschrijving | 's-Gravenhage |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam                        | waarde                     |
    | locatiebeschrijving (12.10) | Woonboot in de Grote Sloot |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.<field>             |
    Dan heeft de response een persoon met een leeg 'adressering' object

    Voorbeelden:
    | field       |
    | adresregel3 |
    | land        |

  Scenario: adresregel1 voor een persoon met buitenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde          |
    | land adres buitenland (13.10)    | 5010            |
    | land.omschrijving                | België          |
    | regel 1 adres buitenland (13.30) | Rue du pomme 25 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel1             |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde          |
    | adresregel1 | Rue du pomme 25 |

  Scenario: adresregel2 voor een persoon met buitenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde    |
    | land adres buitenland (13.10)    | 5010      |
    | land.omschrijving                | België    |
    | regel 2 adres buitenland (13.40) | Bruxelles |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel2             |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde    |
    | adresregel2 | Bruxelles |

  Scenario: adresregel3 voor een persoon met buitenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde        |
    | land adres buitenland (13.10)    | 5010          |
    | land.omschrijving                | België        |
    | regel 3 adres buitenland (13.50) | postcode 1000 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.adresregel3             |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam        | waarde        |
    | adresregel3 | postcode 1000 |

  Scenario: land voor een persoon met buitenlands adres
    Gegeven het systeem heeft een persoon met de volgende 'verblijfplaats' gegevens
    | naam                             | waarde        |
    | land adres buitenland (13.10)    | 5010          |
    | land.omschrijving                | België        |
    | regel 3 adres buitenland (13.50) | postcode 1000 |
    En de persoon heeft de volgende 'naam' gegevens
    | naam                  | waarde  |
    | geslachtsnaam (02.40) | Maassen |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | adressering.land                    |
    Dan heeft de response een persoon met alleen de volgende 'adressering' gegevens
    | naam              | waarde |
    | land.code         | 5010   |
    | land.omschrijving | België |

