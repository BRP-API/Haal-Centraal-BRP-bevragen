#language: nl

Functionaliteit: datumVan vullen voor adres-binnenland 

  Rule: verblijfplaats datumVan wordt voor een binnenlands adres gevuld uit datumAanvangAdreshouding (10.30)

    Abstract Scenario: datum aanvang adreshouding (10.30) <titel>
      Gegeven de persoon met burgerservicenummer '000000267' heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde                     |
      | functie adres (10.10)              | W                          |
      | datum aanvang adreshouding (10.30) | <datumAanvangAdreshouding> |
      | gemeente van inschrijving (09.10)  | 0518                       |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde     |
      | gemeentecode (92.10)              | 0518       |
      | straatnaam (11.10)                | een straat |
      | huisnummer (11.20)   | 1          |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000267                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                 | waarde                 |
      | type                 | Adres                  |
      | datumVan.type        | <type>                 |
      | datumVan.datum       | <datum>                |
      | datumVan.jaar        | <jaar>                 |
      | datumVan.maand       | <maand>                |
      | datumVan.onbekend    | <onbekend>             |
      | datumVan.langFormaat | <langFormaat>          |

      Voorbeelden:
      | titel                | datumAanvangAdreshouding | type           | datum      | jaar | maand | onbekend | langFormaat  |
      | volledig bekend      | 20200308                 | Datum          | 2020-03-08 |      |       |          | 8 maart 2020 |
      | alleen jaar en maand | 20200300                 | JaarMaandDatum |            | 2020 | 3     |          | maart 2020   |
      | alleen jaar          | 20200000                 | JaarDatum      |            | 2020 |       |          | 2020         |
      | volledig onbekend    | 00000000                 | DatumOnbekend  |            |      |       | true     | onbekend     |
