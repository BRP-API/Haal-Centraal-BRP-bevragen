#language: nl

Functionaliteit: verblijfplaats - fields alias

  Wanneer een consumer van de BRP API niet is geautoriseerd voor het bevragen van de velden voor een verblijfplaats buitenland
  Dan moet de consumer de verblijfplaatsBinnenland fields alias gebruiken om aan te geven dat hij velden voor een verblijfplaats binnenland vraagt

Regel: de standaard verblijfplaats field paden kan worden gebruikt door een consumer die is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

  Abstract Scenario: afnemer is geautoriseerd voor 'verblijfplaats buitenland' en vraagt het datumVan veld van een verblijfplaats buitenland
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 19860801                               | 6014                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | datumVan.type        | Datum                    |
    | datumVan.datum       | 1986-08-01               |
    | datumVan.langFormaat | 1 augustus 1986          |

    Voorbeelden:
    | field                   |
    | verblijfplaats.datumVan |

  Scenario: afnemer is geautoriseerd voor 'verblijfplaats buitenland' en vraagt het verblijfadres veld van een verblijfplaats
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam              | waarde                       |
    | regel1            | 1600 Pennsylvania Avenue NW  |
    | regel2            | Washington, DC 20500         |
    | regel3            | Selangor                     |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

  Scenario: afnemer is geautoriseerd voor 'verblijfplaats buitenland' en vraagt het land veld van verblijfadres veld van een verblijfplaats
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000097                         |
    | fields              | verblijfplaats.verblijfadres.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |
    En heeft de 'verblijfplaats' de volgende 'verblijfadres' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

Regel: de 'verblijfplaatsBinnenland' field alias moet worden gebruikt door een consumer die niet is geautoriseerd voor het bevragen van 'verblijfplaats buitenland' velden

  Scenario: afnemer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt het datumVan veld van een verblijfplaats buitenland
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 19860801                               | 5001                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000097                         |
    | fields              | verblijfplaatsBinnenland.datumVan |
    Dan heeft de response een persoon zonder gegevens

  Scenario: afnemer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt het datumVan veld van een adres
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 19860801                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                 | waarde          |
    | gemeentecode (92.10) | 0518            |
    | straatnaam (11.10)   | Borgesiusstraat |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000097                         |
    | fields              | verblijfplaatsBinnenland.datumVan |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde          |
    | type                 | Adres           |
    | datumVan.type        | Datum           |
    | datumVan.datum       | 1986-08-01      |
    | datumVan.langFormaat | 1 augustus 1986 |

  Abstract Scenario: afnemer is niet geautoriseerd voor 'verblijfplaats buitenland' en vraagt <omschrijving> van een verblijfplaats buitenland
    Gegeven de afnemer met indicatie '000008' is geautoriseerd voor 'verblijfplaats binnenland' gegevens
    En de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 19860801                               | 5001                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000097                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | fields                                 | omschrijving              |
    | verblijfplaatsBinnenland               | alle velden               |
    | verblijfplaatsBinnenland.verblijfadres | alle verblijfadres velden |
  
  Scenario: afnemer vraagt verblijfplaatsBinnenland én adressering en de persoon heeft buitenlandse verblijfplaats
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | land adres buitenland (13.10)    | 6014                        |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40) | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50) | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                             |
    | type                | RaadpleegMetBurgerservicenummer                    |
    | burgerservicenummer | 000000097                                          |
    | fields              | adressering,verblijfplaatsBinnenland.verblijfadres |
    Dan heeft de response een persoon met de volgende 'adressering' gegevens
    | naam              | waarde                       |
    | adresregel1       | 1600 Pennsylvania Avenue NW  |
    | adresregel2       | Washington, DC 20500         |
    | adresregel3       | Selangor                     |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |
