 #language: nl

 Functionaliteit: datumVan in verblijfplaatsBuitenland wordt gevuld vanuit datum aanvang adres buitenland (13.20) 

    Abstract Scenario: datum aanvang adres buitenland (13.20) is <titel>
      Gegeven de persoon met burgerservicenummer '000000279' heeft de volgende 'verblijfplaats' gegevens
        | naam                                   | waarde                        |
        | land (13.10)                           | 0004                          |
        | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000279                       |
        | fields              | verblijfplaats.datumVan         |
        Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
        | naam                 | waarde                   |
        | type                 | VerblijfplaatsBuitenland |
        | datumVan.type        | <type>                   |
        | datumVan.datum       | <datum>                  |
        | datumVan.jaar        | <jaar>                   |
        | datumVan.maand       | <maand>                  |
        | datumVan.onbekend    | <onbekend>               |
        | datumVan.langFormaat | <langFormaat>            |

        Voorbeelden:
        | titel                | datumAanvangAdresBuitenland | type           | datum      | jaar | maand | onbekend | langFormaat  |
        | volledig bekend      | 20200308                    | Datum          | 2020-03-08 |      |       |          | 8 maart 2020 |
        | alleen jaar en maand | 20200300                    | JaarMaandDatum |            | 2020 | 3     |          | maart 2020   |
        | alleen jaar          | 20200000                    | JaarDatum      |            | 2020 |       |          | 2020         |
        | volledig onbekend    | 00000000                    | DatumOnbekend  |            |      |       | true     | onbekend     |
