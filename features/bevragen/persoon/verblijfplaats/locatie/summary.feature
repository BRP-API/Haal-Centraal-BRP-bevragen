#language: nl

Functionaliteit: Het vullen van de gegevens voor een Locatie

  Rule: Een verblijfplaats is een binnenlandse locatie wanneer locatiebeschrijving (12.10) een waarde heeft
    - veld 'type' krijgt de waarde 'Locatie' 

  Scenario: 'locatiebeschrijving (12.10)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.locatiebeschrijving'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                           |
    | type                | RaadpleegMetBurgerservicenummer                  |
    | burgerservicenummer | 000000152                                        |
    | fields              | verblijfplaats                                   |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                      |
    | type                              | Locatie                     |
    | functieAdres.code                 | W                           |
    | functieAdres.omschrijving         | woonadres                   |
    | verblijfadres.locatiebeschrijving | Woonboot bij de Grote Sloot |
    | datumIngangGeldigheid.type        | Datum                       |
    | datumIngangGeldigheid.datum       | 2022-02-22                  |
    | datumIngangGeldigheid.langFormaat | 22 februari 2022            |  
    | datumVan.type                     | Datum                       |
    | datumVan.datum                    | 2015-08-08                  |
    | datumVan.langFormaat              | 8 augustus 2015             |
