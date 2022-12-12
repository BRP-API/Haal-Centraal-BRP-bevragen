 #language: nl

Functionaliteit: Datumingangeldigheid vullen.

  Rule: Zie datum.feature voor de algemene bescrijving hoed datums worden opgebouwd en gevuld. 

    Abstract Scenario: <type> in verblijfplaats datumIngangGeldigheid
      Gegeven de persoon met burgerservicenummer '000000176' heeft de volgende 'verblijfplaats' gegevens
      | naam                            | waarde     |
      | functie adres (10.10)           | W          |
      | datum ingang geldigheid (85.10) | <GbaDatum> |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                 | waarde     |
      | gemeentecode (92.10) | 0518       |
      | straatnaam (11.10)   | een straat |
      | huisnummer (11.20)   | 1          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetBurgerservicenummer      |
      | burgerservicenummer | 000000176                            |
      | fields              | verblijfplaats.datumIngangGeldigheid |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                              | waarde                 |
      | type                              | Adres                  |
      | datumIngangGeldigheid.type        | <type>                 |
      | datumIngangGeldigheid.datum       | <datum>                |
      | datumIngangGeldigheid.jaar        | <jaar>                 |
      | datumIngangGeldigheid.maand       | <maand>                |
      | datumIngangGeldigheid.onbekend    | <onbekend>             |
      | datumIngangGeldigheid.langFormaat | <langFormaat>          |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
