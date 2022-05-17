# language: nl

@proxy @post-assert
Functionaliteit: leveren van een datum

  een datum wordt geleverd met een type op basis van de nauwkeurigheid van de waarde

  Rule: een datum krijgt type "Datum" wanneer de laatste twee cijfers in de GBA datum ongelijk zijn aan "00".
        Hierbij geldt dat:
        - de datum wordt geleverd in veld "datum", in full-date formaat als gedefinieerd in RFC 3339, sectie 5.6
        - veld "type" krijgt de waarde "Datum"

    Abstract Scenario: laatste twee cijfers van de GBA datum is ongelijk aan "00"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                  | waarde      |
      | burgerservicenummer                   | 555550001   |
      | datum eerste inschrijving GBA (68.10) | <gba datum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | datumEersteInschrijvingGBA      |
      Dan heeft de response een persoon met de volgende gegevens
      | naam                                   | waarde         |
      | datumEersteInschrijvingGBA.type        | Datum          |
      | datumEersteInschrijvingGBA.datum       | <datum>        |
      | datumEersteInschrijvingGBA.langFormaat | <lang formaat> |

      Voorbeelden:
      | gba datum | datum      | lang formaat      |
      | 19350110  | 1935-01-10 | 10 januari 1935   |
      | 20200229  | 2020-02-29 | 29 februari 2020  |
      | 20200308  | 2020-03-08 | 8 maart 2020      |
      | 19390401  | 1939-04-01 | 1 april 1939      |
      | 19780914  | 1978-09-14 | 14 september 1978 |
      | 20021102  | 2002-11-02 | 2 november 2002   |

  Rule: een datum krijgt type "JaarMaandDatum" wanneer de laatste twee cijfers in de GBA datum gelijk zijn aan "00".
        Hierbij geldt dat:
        - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
        - de maand, dat staat in posities 5 en 6, wordt geleverd in veld "maand" als integer (getal)
        - veld "type" krijgt de waarde "JaarMaandDatum"

    Abstract Scenario: laatste twee cijfers van de GBA datum is gelijk aan "00"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'geboorte' gegevens
      | naam                  | waarde      |
      | geboortedatum (03.10) | <gba datum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | geboorte.datum                  |
      Dan heeft de response een persoon met de volgende 'geboorte' gegevens
      | naam              | waarde         |
      | datum.type        | JaarMaandDatum |
      | datum.jaar        | <jaar>         |
      | datum.maand       | <maand>        |
      | datum.langFormaat | <lang formaat> |

      Voorbeelden:
      | gba datum | jaar | maand | lang formaat  |
      | 20200500  | 2020 | 5     | mei 2020      |
      | 20080600  | 2008 | 6     | juni 2008     |
      | 19680700  | 1968 | 7     | juli 1968     |
      | 19720800  | 1972 | 8     | augustus 1972 |
      | 19501000  | 1950 | 10    | oktober 1950  |
      | 19991200  | 1999 | 12    | december 1999 |

  Rule: een datum krijgt type "JaarDatum" wanneer de laatste vier cijfers in de GBA datum gelijk zijn aan "0000".
        Hierbij geldt dat:
        - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
        - veld "type" krijgt de waarde "JaarDatum"

    Scenario: laatste vier cijfers van de GBA datum is gelijk aan "0000"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'ouder' met de volgende gegevens
      | naam                                               | waarde   |
      | datum ingang familierechtelijke betrekking (62.10) | 19630000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                                | waarde    |
      | type                                                | Ouder     |
      | datumIngangFamilierechtelijkeBetrekking.type        | JaarDatum |
      | datumIngangFamilierechtelijkeBetrekking.jaar        | 1963      |
      | datumIngangFamilierechtelijkeBetrekking.langFormaat | 1963      |

  Rule: een datum krijgt type "DatumOnbekend" wanneer de GBA datum gelijk is aan "00000000".
        Hierbij geldt dat:
        - veld "type" krijgt de waarde "DatumOnbekend"
        - veld "onbekend" wordt opgenomen met de boolean waarde true

    Scenario: GBA datum is gelijk aan "00000000"
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'overlijden' gegevens
      | naam                     | waarde   |
      | datum overlijden (08.10) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | overlijden.datum                |
      Dan heeft de response een persoon met de volgende 'overlijden' gegevens
      | naam              | waarde        |
      | datum.type        | DatumOnbekend |
      | datum.onbekend    | true          |
      | datum.langFormaat | onbekend      |

    Abstract Scenario: <type> in <groep> <veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende '<groep>' gegevens
      | naam   | waarde     |
      | <veld> | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | groep                 | veld                                  | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | geboorte              | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | overlijden            | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | opschortingBijhouding | datum                                 | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfstitel        | datumIngang                           | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfstitel        | datumEinde                            | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | Datum          | 20300701 | 2030-07-01 |      |       |          | 1 juli 2030  |
      | geboorte              | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | overlijden            | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | opschortingBijhouding | datum                                 | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfstitel        | datumIngang                           | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfstitel        | datumEinde                            | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | geboorte              | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | overlijden            | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | opschortingBijhouding | datum                                 | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfstitel        | datumIngang                           | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfstitel        | datumEinde                            | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarDatum      | 20300000 |            | 2030 |       |          | 2030         |
      | geboorte              | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | overlijden            | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | opschortingBijhouding | datum                                 | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfstitel        | datumIngang                           | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | verblijfstitel        | datumEinde                            | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |
      | kiesrecht             | einddatumUitsluitingEuropeesKiesrecht | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |
      | kiesrecht             | einddatumUitsluitingKiesrecht         | JaarMaandDatum | 20300700 |            | 2030 | 7     |          | juli 2030    |
      | immigratie            | datumVestigingInNederland             | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | immigratie            | datumVestigingInNederland             | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | immigratie            | datumVestigingInNederland             | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | immigratie            | datumVestigingInNederland             | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

    Abstract Scenario: <type> in <veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde     |
      | burgerservicenummer | 555550001  |
      | <veld>              | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <veld>                          |
      Dan heeft de response een persoon met de volgende gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | groep          | veld                        | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | verblijfplaats | datumInschrijvingInGemeente | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfplaats | datumInschrijvingInGemeente | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfplaats | datumInschrijvingInGemeente | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfplaats | datumInschrijvingInGemeente | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

    Abstract Scenario: <type> in verblijfplaats <veld>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam               | waarde     |
      | straatnaam (11.10) | een straat |
      | <veld>             | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.<veld>           |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam               | waarde        |
      | type               | Adres         |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | groep          | veld                  | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | verblijfplaats | datumIngangGeldigheid | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | verblijfplaats | datumIngangGeldigheid | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | verblijfplaats | datumIngangGeldigheid | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | verblijfplaats | datumIngangGeldigheid | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

    Abstract Scenario: <type> in inOnderzoek datumIngangOnderzoek
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                                     | waarde     |
      | burgerservicenummer                      | 555550001  |
      | aanduiding gegevens in onderzoek (83.10) | 010000     |
      | datum ingang onderzoek (83.20)           | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <groep>.<veld>                  |
      Dan heeft de response een persoon met de volgende '<groep>' gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | groep       | veld                 | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | inOnderzoek | datumIngangOnderzoek | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | inOnderzoek | datumIngangOnderzoek | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | inOnderzoek | datumIngangOnderzoek | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | inOnderzoek | datumIngangOnderzoek | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

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
      Dan heeft de response een persoon met de volgende gegevens
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
      | datumIngangFamilierechtelijkeBetrekking | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 555550001                                      |
      | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                                | waarde        |
      | type                                                | Ouder         |
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
      En de persoon heeft een '<relatie>' met de volgende '<groep>' gegevens
      | naam   | waarde     |
      | <veld> | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <field>.<groep>.<veld>          |
      Dan heeft de response een persoon met een '<relatie>' met de volgende gegevens
      | naam | waarde         |
      | type | <relatie type> |
      En heeft de '<relatie>' de volgende '<groep>' gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | relatie type | relatie | field    | groep                       | veld  | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Ouder        | ouder   | ouders   | geboorte                    | datum | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Ouder        | ouder   | ouders   | geboorte                    | datum | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | Ouder        | ouder   | ouders   | geboorte                    | datum | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | Ouder        | ouder   | ouders   | geboorte                    | datum | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | Partner      | partner | partners | geboorte                    | datum | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Partner      | partner | partners | geboorte                    | datum | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | Partner      | partner | partners | geboorte                    | datum | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | Partner      | partner | partners | geboorte                    | datum | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | Partner      | partner | partners | aangaanHuwelijkPartnerschap | datum | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Partner      | partner | partners | aangaanHuwelijkPartnerschap | datum | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | Partner      | partner | partners | aangaanHuwelijkPartnerschap | datum | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | Partner      | partner | partners | aangaanHuwelijkPartnerschap | datum | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | Kind         | kind    | kinderen | geboorte                    | datum | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Kind         | kind    | kinderen | geboorte                    | datum | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | Kind         | kind    | kinderen | geboorte                    | datum | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | Kind         | kind    | kinderen | geboorte                    | datum | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

    Abstract Scenario: <type> <groep> <veld> van <relatie>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een '<relatie>' met de volgende gegevens
      | naam                                     | waarde                   |
      | aanduiding gegevens in onderzoek (83.10) | <GBA InOnderzoek waarde> |
      | datum ingang onderzoek (83.20)           | <GbaDatum>               |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | <field>.<groep>.<veld>          |
      Dan heeft de response een persoon met een '<relatie>' met de volgende gegevens
      | naam | waarde         |
      | type | <relatie type> |
      En heeft de '<relatie>' de volgende '<groep>' gegevens
      | naam               | waarde        |
      | <veld>.type        | <type>        |
      | <veld>.datum       | <datum>       |
      | <veld>.jaar        | <jaar>        |
      | <veld>.maand       | <maand>       |
      | <veld>.onbekend    | <onbekend>    |
      | <veld>.langFormaat | <langFormaat> |

      Voorbeelden:
      | relatie type | relatie | field    | groep       | veld                 | type           | GBA InOnderzoek waarde | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Ouder        | ouder   | ouders   | inOnderzoek | datumIngangOnderzoek | Datum          | 020000                 | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Ouder        | ouder   | ouders   | inOnderzoek | datumIngangOnderzoek | DatumOnbekend  | 020000                 | 00000000 |            |      |       | true     | onbekend     |
      | Ouder        | ouder   | ouders   | inOnderzoek | datumIngangOnderzoek | JaarDatum      | 020000                 | 20200000 |            | 2020 |       |          | 2020         |
      | Ouder        | ouder   | ouders   | inOnderzoek | datumIngangOnderzoek | JaarMaandDatum | 020000                 | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | Partner      | partner | partners | inOnderzoek | datumIngangOnderzoek | Datum          | 050000                 | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Partner      | partner | partners | inOnderzoek | datumIngangOnderzoek | DatumOnbekend  | 050000                 | 00000000 |            |      |       | true     | onbekend     |
      | Partner      | partner | partners | inOnderzoek | datumIngangOnderzoek | JaarDatum      | 050000                 | 20200000 |            | 2020 |       |          | 2020         |
      | Partner      | partner | partners | inOnderzoek | datumIngangOnderzoek | JaarMaandDatum | 050000                 | 20200300 |            | 2020 | 3     |          | maart 2020   |
      | Kind         | kind    | kinderen | inOnderzoek | datumIngangOnderzoek | Datum          | 090000                 | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | Kind         | kind    | kinderen | inOnderzoek | datumIngangOnderzoek | DatumOnbekend  | 090000                 | 00000000 |            |      |       | true     | onbekend     |
      | Kind         | kind    | kinderen | inOnderzoek | datumIngangOnderzoek | JaarDatum      | 090000                 | 20200000 |            | 2020 |       |          | 2020         |
      | Kind         | kind    | kinderen | inOnderzoek | datumIngangOnderzoek | JaarMaandDatum | 090000                 | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Rule: verblijfplaats datumVan wordt gevuld uit datumAanvangAdreshouding of datumAanvangAdresBuitenland

    Abstract Scenario: datum aanvang adreshouding (10.30) <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde                     |
      | straatnaam (11.10)                 | een straat                 |
      | datum aanvang adreshouding (10.30) | <datumAanvangAdreshouding> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | verblijfplaats.datumVan         |
      Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
      | naam                 | waarde        |
      | type                 | Adres         |
      | datumVan.type        | <type>        |
      | datumVan.datum       | <datum>       |
      | datumVan.jaar        | <jaar>        |
      | datumVan.maand       | <maand>       |
      | datumVan.onbekend    | <onbekend>    |
      | datumVan.langFormaat | <langFormaat> |

      Voorbeelden:
      | titel                | datumAanvangAdreshouding | type           | datum      | jaar | maand | onbekend | langFormaat  |
      | volledig bekend      | 20200308                 | Datum          | 2020-03-08 |      |       |          | 8 maart 2020 |
      | alleen jaar en maand | 20200300                 | JaarMaandDatum |            | 2020 | 3     |          | maart 2020   |
      | alleen jaar          | 20200000                 | JaarDatum      |            | 2020 |       |          | 2020         |
      | volledig onbekend    | 00000000                 | DatumOnbekend  |            |      |       | true     | onbekend     |

    Abstract Scenario: datum aanvang adres buitenland (13.20) <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde                        |
      | land adres buitenland (13.10)          | 0004                          |
      | datum aanvang adres buitenland (13.20) | <datumAanvangAdresBuitenland> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
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
