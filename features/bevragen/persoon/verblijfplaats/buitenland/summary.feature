# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland -verblijfadres
  Als de persoon een vebrlijfplaats heeft waarbij land, adresregel, datumVan en datumIngangGeldigheid valide waardes gevuld zijn is er sprake van een VerblijplaatsBuitenland. 

  Abstract Scenario: persoon heeft een complete verblijfplaats buitenland.  
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                      |
    | datum ingang geldigheid (85.10)        | 20150901                    |
    | datum aanvang adres buitenland (13.20) | 20150808                    |
    | land adres buitenland (13.10)          | 6014                        |
    | regel 1 adres buitenland (13.30)       | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40)       | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50)       | Selangor                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats                  |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                       |
    | type                              | VerblijfplaatsBuitenland     |
    | verblijfadres.land.code           | 6014                         |
    | verblijfadres.land.omschrijving   | Verenigde Staten van Amerika |
    | verblijfadres.regel1              | 1600 Pennsylvania Avenue NW  |
    | verblijfadres.regel2              | Washington, DC 20500         |
    | verblijfadres.regel3              | Selangor                     |   
    | datumVan.type                     | Datum                        |
    | datumVan.datum                    | 2015-08-08                   |
    | datumVan.langFormaat              | 8 augustus 2015              |
    | datumIngangGeldigheid.type        | Datum                        |
    | datumIngangGeldigheid.datum       | 2015-09-01                   |
    | datumIngangGeldigheid.langFormaat | 1 september 2015             |

