#language: nl

Functionaliteit: Persoon: overlijden velden vragen met fields

  Abstract Scenario: 'datum overlijden (08.10)' van het type '<type>' wordt gevraagd met field pad 'overlijden.datum'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'overlijden' gegevens
      | datum overlijden (08.10) |
      | <GbaDatum>               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000152                       |
      | fields              | overlijden.datum                |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam               | waarde        |
      | indicatieOverleden | true          |
      | datum.type         | <type>        |
      | datum.datum        | <datum>       |
      | datum.jaar         | <jaar>        |
      | datum.maand        | <maand>       |
      | datum.onbekend     | <onbekend>    |
      | datum.langFormaat  | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
