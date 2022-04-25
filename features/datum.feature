# language: nl

@proxy @post-assert
Functionaliteit: leveren van een datum

  Rule: een volledige datum wordt geleverd met een type op basis van de nauwkeurigheid van de waarde
    - een datum krijgt type "Datum" wanneer de laatste twee cijfers in de GbaDatum ongelijk zijn aan "00", waarbij geldt dat:
      - de datum wordt geleverd in veld "datum", in full-date formaat als gedefinieerd in RFC 3339, sectie 5.6
      - veld "type" krijgt de waarde "Datum"
    - een datum krijgt type "DatumOnbekend" wanneer de datum gelijk is aan "00000000", waarbij geldt dat:
      - veld "type" krijgt de waarde "DatumOnbekend"
      - veld "onbekend" wordt opgenomen met de boolean waarde true
    - een datum krijgt type "JaarDatum" wanneer de laatste vier cijfers in de GbaDatum gelijk zijn aan "0000", waarbij geldt dat:
      - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
      - veld "type" krijgt de waarde "JaarDatum"
    - een datum krijgt type "JaarMaandDatum" wanneer de laatste twee cijfers in de GbaDatum gelijk zijn aan "00", waarbij geldt dat:
      - de laatste vier cijfers in de GbaDatum zijn ongelijk aan "0000"
      - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
      - de maand, dat staat in posities 5 en 6, wordt geleverd in veld "maand" als integer (getal)
      - veld "type" krijgt de waarde "JaarMaandDatum"

    Abstract Scenario: <type> in <groep> <veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende '<groep>' gegevens
      | naam   | waarde     |
      | <veld> | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetBurgerservicenummer    |
      | burgerservicenummer | 555550001                          |
      | fields              | burgerservicenummer,<groep>.<veld> |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende '<groep>' gegevens
      | naam               | waarde       |
      | <veld>.type        | <type>       |
      | <veld>.datum       | <datum>      |
      | <veld>.jaar        | <jaar>       |
      | <veld>.maand       | <maand>      |
      | <veld>.onbekend    | <onbekend>   |
      | <veld>.langFormaat | <langFormaat |

      Voorbeelden:
      | groep                 | veld                                  | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | geboorte              | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | inOnderzoek           | datumIngangOnderzoek                  | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | overlijden            | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | opschortingBijhouding | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfplaats        | datumInschrijvingInGemeente           | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfplaats        | datumVestigingInNederland             | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfplaats        | datumIngangGeldigheid                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfstitel        | datumIngang                           | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfstitel        | datumEinde                            | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | geboorte              | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | inOnderzoek           | datumIngangOnderzoek                  | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | overlijden            | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | opschortingBijhouding | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfplaats        | datumInschrijvingInGemeente           | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfplaats        | datumVestigingInNederland             | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfstitel        | datumIngang                           | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfplaats        | datumIngangGeldigheid                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfstitel        | datumEinde                            | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | geboorte              | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | inOnderzoek           | datumIngangOnderzoek                  | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | overlijden            | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | opschortingBijhouding | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfplaats        | datumInschrijvingInGemeente           | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfplaats        | datumVestigingInNederland             | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfplaats        | datumIngangGeldigheid                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfstitel        | datumIngang                           | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfstitel        | datumEinde                            | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | geboorte              | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | inOnderzoek           | datumIngangOnderzoek                  | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | overlijden            | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | opschortingBijhouding | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfplaats        | datumInschrijvingInGemeente           | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfplaats        | datumVestigingInNederland             | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfplaats        | datumIngangGeldigheid                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfstitel        | datumIngang                           | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfstitel        | datumEinde                            | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |


    Abstract Scenario: <type> in datumEersteInschrijvingGBA
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                       | waarde     |
      | burgerservicenummer        | 555550001  |
      | datumEersteInschrijvingGBA | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | burgerservicenummer,datumEersteInschrijvingGBA |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende gegevens
      | naam                                   | waarde        |
      | burgerservicenummer                    | 555550001     |
      | datumEersteInschrijvingGBA.type        | <type>        |
      | datumEersteInschrijvingGBA.datum       | <datum>       |
      | datumEersteInschrijvingGBA.jaar        | <jaar>        |
      | datumEersteInschrijvingGBA.maand       | <maand>       |
      | datumEersteInschrijvingGBA.onbekend    | <onbekend>    |
      | datumEersteInschrijvingGBA.langFormaat | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

    Abstract Scenario: <type> datumIngangFamilierechtelijkeBetrekking van ouders
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam                                    | waarde     |
      | burgerservicenummer                     | 555550002  |
      | datumIngangFamilierechtelijkeBetrekking | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                             |
      | type                | RaadpleegMetBurgerservicenummer                                    |
      | burgerservicenummer | 555550001                                                          |
      | fields              | burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de persoon met burgerservicenummer '555550001' een 'ouder' met de volgende gegevens
      | naam                                                | waarde        |
      | burgerservicenummer                                 | 555550002     |
      | datumIngangFamilierechtelijkeBetrekking.type        | <type>        |
      | datumIngangFamilierechtelijkeBetrekking.datum       | <datum>       |
      | datumIngangFamilierechtelijkeBetrekking.jaar        | <jaar>        |
      | datumIngangFamilierechtelijkeBetrekking.maand       | <maand>       |
      | datumIngangFamilierechtelijkeBetrekking.onbekend    | <onbekend>    |
      | datumIngangFamilierechtelijkeBetrekking.langFormaat | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

     Abstract Scenario: <type> <groep> <veld> van <relatie>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een '<relatie>' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de '<relatie>' heeft de volgende '<groep>' gegevens
      | naam   | waarde     |
      | <veld> | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                     |
      | type                | RaadpleegMetBurgerservicenummer            |
      | burgerservicenummer | 555550001                                  |
      | fields              | burgerservicenummer,<field>.<groep>.<veld> |
      Dan heeft de persoon met burgerservicenummer '555550001' een '<relatie>' met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En de '<relatie>' met burgerservicenummer '555550002' heeft de volgende '<groep>' gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | relatie | field    | groep                       | veld                 | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | ouder   | ouders   | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | ouder   | ouders   | geboorte                    | datum                | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | ouder   | ouders   | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | ouder   | ouders   | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | ouder   | ouders   | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | ouder   | ouders   | inOnderzoek                 | datumIngangOnderzoek | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | ouder   | ouders   | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | ouder   | ouders   | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | partner | partners | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | partner | partners | geboorte                    | datum                | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | partner | partners | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | partner | partners | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | partner | partners | aangaanHuwelijkPartnerschap | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | partner | partners | aangaanHuwelijkPartnerschap | datum                | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | partner | partners | aangaanHuwelijkPartnerschap | datum                | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | partner | partners | aangaanHuwelijkPartnerschap | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | partner | partners | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | partner | partners | inOnderzoek                 | datumIngangOnderzoek | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | partner | partners | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | partner | partners | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | kind    | kinderen | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | kind    | kinderen | geboorte                    | datum                | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kind    | kinderen | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | kind    | kinderen | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | kind    | kinderen | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | kind    | kinderen | inOnderzoek                 | datumIngangOnderzoek | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kind    | kinderen | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | kind    | kinderen | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Rule: verblijfplaats datumVan wordt gevuld uit datumAanvangAdreshouding of datumAanvangAdresBuitenland

    Abstract Scenario: <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                        | waarde                        |
      | datumAanvangAdreshouding    | <datumAanvangAdreshouding>    |
      | datumAanvangAdresBuitenland | <datumAanvangAdresBuitenland> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                      |
      | type                | RaadpleegMetBurgerservicenummer             |
      | burgerservicenummer | 999992934                                   |
      | fields              | burgerservicenummer,verblijfplaats.datumVan |
      Dan heeft de persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats' gegevens
      | naam                 | waarde        |
      | datumVan.type        | <type>        |
      | datumVan.datum       | <datum>       |
      | datumVan.jaar        | <jaar>        |
      | datumVan.maand       | <maand>       |
      | datumVan.onbekend    | <onbekend>    |
      | datumVan.langFormaat | <langFormaat> |

      Voorbeelden:
      | titel                                            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | type           | datum      | jaar | maand | onbekend | langFormaat  |
      | datumAanvangAdreshouding                         | 20200308                 |                             | Datum          | 2020-03-08 |      |       |          | 8 maart 2020 |
      | datumAanvangAdreshouding alleen jaar en maand    | 20200300                 |                             | JaarMaandDatum |            | 2020 | 3     |          | maart 2020   |
      | datumAanvangAdreshouding alleen jaar             | 20200000                 |                             | JaarDatum      |            | 2020 |       |          | 2020         |
      | datumAanvangAdreshouding volledig onbekend       | 00000000                 |                             | DatumOnbekend  |            |      |       | true     | onbekend     |
      | datumAanvangAdresBuitenland                      |                          | 20200308                    | Datum          | 2020-03-08 |      |       |          | 8 maart 2020 |
      | datumAanvangAdresBuitenland alleen jaar en maand |                          | 20200300                    | JaarMaandDatum |            | 2020 | 3     |          | maart 2020   |
      | datumAanvangAdresBuitenland alleen jaar          |                          | 20200000                    | JaarDatum      |            | 2020 |       |          | 2020         |
      | datumAanvangAdresBuitenland volledig onbekend    |                          | 00000000                    | DatumOnbekend  |            |      |       | true     | onbekend     |
