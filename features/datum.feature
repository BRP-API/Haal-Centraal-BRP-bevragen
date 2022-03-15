# language: nl

@proxy
Functionaliteit: leveren van een datum

  Rule: een volledige datum wordt geleverd met een type op basis van de nauwkeurigheid van de waarde
    - een datum krijgt type "Datum" wanneer de laatste twee cijfers in de GbaDatum ongelijk zijn aan "00", waarbij geldt dat:
      - de datum wordt geleverd in veld "datum", in full-date formaat als gedefinieerd in RFC 3339, sectie 5.6
      - veld "type" krijgt de waarde "Datum"
    - een datum krijgt type "OnbekendDatum" wanneer de datum gelijk is aan "00000000", waarbij geldt dat:
      - veld "type" krijgt de waarde "OnbekendDatum"
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
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende '<groep>.<veld>' gegevens
      | naam     | waarde     |
      | type     | <type>     |
      | datum    | <datum>    |
      | jaar     | <jaar>     |
      | maand    | <maand>    |
      | onbekend | <onbekend> |

      Voorbeelden:
      | groep                 | veld                                  | type           | GbaDatum | datum      | jaar | maand | onbekend |
      | geboorte              | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | inOnderzoek           | datumIngangOnderzoek                  | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | overlijden            | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | opschortingBijhouding | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | verblijfplaats        | datumInschrijvingInGemeente           | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | verblijfplaats        | datumVestigingInNederland             | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | verblijfplaats        | datumIngangGeldigheid                 | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | verblijfstitel        | datumIngang                           | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | verblijfstitel        | datumEinde                            | Datum          | 20300701 | 2030-07-01 |      |       |          |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | Datum          | 20300701 | 2030-07-01 |      |       |          |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | Datum          | 20300701 | 2030-07-01 |      |       |          |
      | geboorte              | datum                                 | OnbekendDatum  | 00000000 |            |      |       | true     |
      | inOnderzoek           | datumIngangOnderzoek                  | OnbekendDatum  | 00000000 |            |      |       | true     |
      | overlijden            | datum                                 | OnbekendDatum  | 00000000 |            |      |       | true     |
      | opschortingBijhouding | datum                                 | OnbekendDatum  | 00000000 |            |      |       | true     |
      | verblijfplaats        | datumInschrijvingInGemeente           | OnbekendDatum  | 00000000 |            |      |       | true     |
      | verblijfplaats        | datumVestigingInNederland             | OnbekendDatum  | 00000000 |            |      |       | true     |
      | verblijfplaats        | datumIngangGeldigheid                 | OnbekendDatum  | 00000000 |            |      |       | true     |
      | verblijfstitel        | datumIngang                           | OnbekendDatum  | 00000000 |            |      |       | true     |
      | verblijfstitel        | datumEinde                            | OnbekendDatum  | 00000000 |            |      |       | true     |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | OnbekendDatum  | 00000000 |            |      |       | true     |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | OnbekendDatum  | 00000000 |            |      |       | true     |
      | geboorte              | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          |
      | inOnderzoek           | datumIngangOnderzoek                  | JaarDatum      | 20200000 |            | 2020 |       |          |
      | overlijden            | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          |
      | opschortingBijhouding | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          |
      | verblijfplaats        | datumInschrijvingInGemeente           | JaarDatum      | 20200000 |            | 2020 |       |          |
      | verblijfplaats        | datumVestigingInNederland             | JaarDatum      | 20200000 |            | 2020 |       |          |
      | verblijfplaats        | datumIngangGeldigheid                 | JaarDatum      | 20200000 |            | 2020 |       |          |
      | verblijfstitel        | datumIngang                           | JaarDatum      | 20200000 |            | 2020 |       |          |
      | verblijfstitel        | datumEinde                            | JaarDatum      | 20300000 |            | 2030 |       |          |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarDatum      | 20300000 |            | 2030 |       |          |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarDatum      | 20300000 |            | 2030 |       |          |
      | geboorte              | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | inOnderzoek           | datumIngangOnderzoek                  | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | overlijden            | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | opschortingBijhouding | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | verblijfplaats        | datumInschrijvingInGemeente           | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | verblijfplaats        | datumVestigingInNederland             | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | verblijfplaats        | datumIngangGeldigheid                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | verblijfstitel        | datumIngang                           | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | verblijfstitel        | datumEinde                            | JaarMaandDatum | 20300700 |            | 2030 | 7     |          |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarMaandDatum | 20300700 |            | 2030 | 7     |          |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarMaandDatum | 20300700 |            | 2030 | 7     |          |


    Scenario: <type> in datumEersteInschrijvingGBA
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                       | waarde     |
      | burgerservicenummer        | 555550001  |
      | datumEersteInschrijvingGBA | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 999992934                                      |
      | fields              | burgerservicenummer,datumEersteInschrijvingGBA |
      Dan bevat de persoon met burgerservicenummer '555550001' alleen de volgende 'datumEersteInschrijvingGBA' gegevens
      | naam     | waarde     |
      | type     | <type>     |
      | datum    | <datum>    |
      | jaar     | <jaar>     |
      | maand    | <maand>    |
      | onbekend | <onbekend> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend |
      | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | OnbekendDatum  | 00000000 |            |      |       | true     |
      | JaarDatum      | 20200000 |            | 2020 |       |          |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |

    Abstract Scenario: <type> datumIngangFamilierechtelijkeBetrekking van ouders
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een ouder met de volgende gegevens
      | naam                                    | waarde                                    |
      | burgerservicenummer                     | 555550002                                 |
      | datumIngangFamilierechtelijkeBetrekking | <datumIngangFamilierechtelijkeBetrekking> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                                             |
      | type                | RaadpleegMetBurgerservicenummer                                    |
      | burgerservicenummer | 555550001                                                          |
      | fields              | burgerservicenummer,ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de persoon met burgerservicenummer '555550001' een ouder met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En de ouder met burgerservicenummer '555550002' heeft de volgende 'datumIngangFamilierechtelijkeBetrekking' gegevens
      | naam     | waarde     |
      | type     | <type>     |
      | datum    | <datum>    |
      | jaar     | <jaar>     |
      | maand    | <maand>    |
      | onbekend | <onbekend> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend |
      | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | OnbekendDatum  | 00000000 |            |      |       | true     |
      | JaarDatum      | 20200000 |            | 2020 |       |          |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |

     Abstract Scenario: <type> <groep> <veld> van <relatie>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een <relatie> met de volgende gegevens
      | naam                  | waarde    |
      | burgerservicenummer   | 555550002 |
      En de <relatie> heeft de volgende '<groep>' gegevens
      | naam   | waarde     |
      | <veld> | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                       |
      | type                | RaadpleegMetBurgerservicenummer              |
      | burgerservicenummer | 555550001                                    |
      | fields              | burgerservicenummer,<relatie>.<groep>.<veld> |
      Dan heeft de persoon met burgerservicenummer '555550001' een <relatie> met de volgende gegevens
      | burgerservicenummer |
      | 555550002           |
      En de <relatie> met burgerservicenummer '555550002' heeft de volgende '<groep>.<veld>' gegevens
      | naam     | waarde     |
      | type     | <type>     |
      | datum    | <datum>    |
      | jaar     | <jaar>     |
      | maand    | <maand>    |
      | onbekend | <onbekend> |

      Voorbeelden:
      | relatie  | groep                       | veld                 | type           | GbaDatum | datum      | jaar | maand | onbekend |
      | ouders   | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | ouders   | geboorte                    | datum                | OnbekendDatum  | 00000000 |            |      |       | true     |
      | ouders   | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          |
      | ouders   | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | ouders   | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | ouders   | inOnderzoek                 | datumIngangOnderzoek | OnbekendDatum  | 00000000 |            |      |       | true     |
      | ouders   | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          |
      | ouders   | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | partners | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | partners | geboorte                    | datum                | OnbekendDatum  | 00000000 |            |      |       | true     |
      | partners | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          |
      | partners | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | partners | aangaanHuwelijkPartnerschap | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | partners | aangaanHuwelijkPartnerschap | datum                | OnbekendDatum  | 00000000 |            |      |       | true     |
      | partners | aangaanHuwelijkPartnerschap | datum                | JaarDatum      | 20200000 |            | 2020 |       |          |
      | partners | aangaanHuwelijkPartnerschap | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | partners | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | partners | inOnderzoek                 | datumIngangOnderzoek | OnbekendDatum  | 00000000 |            |      |       | true     |
      | partners | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          |
      | partners | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | kinderen | geboorte                    | datum                | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | kinderen | geboorte                    | datum                | OnbekendDatum  | 00000000 |            |      |       | true     |
      | kinderen | geboorte                    | datum                | JaarDatum      | 20200000 |            | 2020 |       |          |
      | kinderen | geboorte                    | datum                | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |
      | kinderen | inOnderzoek                 | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          |
      | kinderen | inOnderzoek                 | datumIngangOnderzoek | OnbekendDatum  | 00000000 |            |      |       | true     |
      | kinderen | inOnderzoek                 | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          |
      | kinderen | inOnderzoek                 | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          |

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
      Dan bevat de persoon met burgerservicenummer '555550001' de volgende 'verblijfplaats.datumVan' gegevens
      | naam     | waarde     |
      | type     | <type>     |
      | datum    | <datum>    |
      | jaar     | <jaar>     |
      | maand    | <maand>    |
      | onbekend | <onbekend> |

      Voorbeelden:
      | titel                                            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | type           | datum      | jaar | maand | onbekend |
      | datumAanvangAdreshouding                         | 20200308                 |                             | Datum          | 2020-03-08 |      |       |          |
      | datumAanvangAdreshouding alleen jaar en maand    | 20200300                 |                             | JaarMaandDatum |            | 2020 | 3     |          |
      | datumAanvangAdreshouding alleen jaar             | 20200000                 |                             | JaarDatum      |            | 2020 |       |          |
      | datumAanvangAdreshouding volledig onbekend       | 00000000                 |                             | OnbekendDatum  |            |      |       | true     |
      | datumAanvangAdresBuitenland                      |                          | 20200308                    | Datum          | 2020-03-08 |      |       |          |
      | datumAanvangAdresBuitenland alleen jaar en maand |                          | 20200300                    | JaarMaandDatum |            | 2020 | 3     |          |
      | datumAanvangAdresBuitenland alleen jaar          |                          | 20200000                    | JaarDatum      |            | 2020 |       |          |
      | datumAanvangAdresBuitenland volledig onbekend    |                          | 00000000                    | OnbekendDatum  |            |      |       | true     |
 
