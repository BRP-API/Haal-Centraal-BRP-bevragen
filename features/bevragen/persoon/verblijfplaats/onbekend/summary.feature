#language: nl 

Functionaliteit: leveren van een onbekende verblijfplaats

  Rule: Een verblijfplaats is onbekend wanneer geen adres, locatie of verblijf buitenland gegeven een waarde heeft
    - veld 'type' krijgt de waarde 'VerblijfplaatsOnbekend' 
    - veld 'verblijfplaatsOnbekend' wordt opgenomen met de boolean waarde true
    - een standaardwaarde in de bron geldt hier niet als waarde
    - een string met lengte nul ("") geldt hier niet als waarde

    Scenario: adres onbekend 
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
      | naam                                        | waarde           |
      | datum aanvang adreshouding (10.30)          | 20150808         |
      | datum ingang geldigheid (85.10)             | 20220222         |
      | functie adres (10.10)                       | W                |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                        | waarde           |
      | gemeentecode (92.10)                        | 0518             |
      | straatnaam (11.10)                          | .                |
      | huisnummer (11.20)                          | 0                |
      | woonplaats (11.70)                          | .                |
      | identificatiecode verblijfplaats (11.80)    | 0000000000000000 |
      | identificatiecode nummeraanduiding (11.90)  | 0000000000000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                 |
      | type                              | VerblijfplaatsOnbekend |
      | datumVan.type                     | Datum                  |
      | datumVan.datum                    | 2015-08-08             |
      | datumVan.langFormaat              | 8 augustus 2015        |
      | datumIngangGeldigheid.type        | Datum                  |
      | datumIngangGeldigheid.datum       | 2022-02-22             |
      | datumIngangGeldigheid.langFormaat | 22 februari 2022       |
      | functieAdres.code                 | W                      |
      | functieAdres.omschrijving         | woonadres              |

    Scenario: land onbekend 
    Gegeven de persoon met burgerservicenummer '000000383' heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | datum ingang geldigheid (85.10)        | 20220222 |
      | land adres buitenland (13.10)          | 0000     |
      | datum aanvang adres buitenland (13.20) | 20201105 |
      | regel 2 adres buitenland (13.40)       |          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000383                       |
      | fields              | verblijfplaats                  |
      Dan heeft de response een persoon met alleen de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                 |
      | type                              | VerblijfplaatsOnbekend |
      | datumVan.type                     | Datum                  |
      | datumVan.datum                    | 2020-11-05             |
      | datumVan.langFormaat              | 5 november 2020        |
      | datumIngangGeldigheid.type        | Datum                  |
      | datumIngangGeldigheid.datum       | 2022-02-22             |
      | datumIngangGeldigheid.langFormaat | 22 februari 2022       |
