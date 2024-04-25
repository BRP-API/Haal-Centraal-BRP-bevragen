# language: nl

Functionaliteit: leveren van een datum

  een datum wordt geleverd met een type op basis van de nauwkeurigheid van de waarde

  Regel: een datum krijgt type "Datum" wanneer de laatste twee cijfers in de GBA datum ongelijk zijn aan "00".
        Hierbij geldt dat:
        - de datum wordt geleverd in veld "datum", in full-date formaat als gedefinieerd in RFC 3339, sectie 5.6
        - veld "type" krijgt de waarde "Datum"

    Abstract Scenario: laatste twee cijfers van de GBA datum is ongelijk aan "00"
      Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende 'inschrijving' gegevens
        | naam                                  | waarde      |
        | datum eerste inschrijving GBA (68.10) | <gba datum> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000103                       |
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

  Regel: een datum krijgt type "JaarMaandDatum" wanneer de laatste twee cijfers in de GBA datum gelijk zijn aan "00".
        Hierbij geldt dat:
        - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
        - de maand, dat staat in posities 5 en 6, wordt geleverd in veld "maand" als integer (getal)
        - veld "type" krijgt de waarde "JaarMaandDatum"

    Abstract Scenario: laatste twee cijfers van de GBA datum is gelijk aan "00"
      Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende gegevens
        | naam                  | waarde      |
        | geboortedatum (03.10) | <gba datum> |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000115                       |
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

  Regel: een datum krijgt type "JaarDatum" wanneer de laatste vier cijfers in de GBA datum gelijk zijn aan "0000".
        Hierbij geldt dat:
        - het jaar, dat staat in de eerste 4 cijfers, wordt geleverd in veld "jaar" als integer (getal)
        - veld "type" krijgt de waarde "JaarDatum"

    Scenario: laatste vier cijfers van de GBA datum is gelijk aan "0000"
      Gegeven de persoon met burgerservicenummer '000000127' heeft een ouder '1' met de volgende gegevens
        | naam                                               | waarde   |
        | datum ingang familierechtelijke betrekking (62.10) | 19630000 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                                         |
        | type                | RaadpleegMetBurgerservicenummer                |
        | burgerservicenummer | 000000127                                      |
        | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
        Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
        | naam                                                | waarde    |
        | datumIngangFamilierechtelijkeBetrekking.type        | JaarDatum |
        | datumIngangFamilierechtelijkeBetrekking.jaar        | 1963      |
        | datumIngangFamilierechtelijkeBetrekking.langFormaat | 1963      |

  Regel: een datum krijgt type "DatumOnbekend" wanneer de GBA datum gelijk is aan "00000000".
        Hierbij geldt dat:
        - veld "type" krijgt de waarde "DatumOnbekend"
        - veld "onbekend" wordt opgenomen met de boolean waarde true

    Scenario: GBA datum is gelijk aan "00000000"
      Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'overlijden' gegevens
        | naam                     | waarde   |
        | datum overlijden (08.10) | 00000000 |
        Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer | 000000139                       |
        | fields              | overlijden.datum                |
        Dan heeft de response een persoon met de volgende 'overlijden' gegevens
        | naam               | waarde        |
        | datum.type         | DatumOnbekend |
        | datum.onbekend     | true          |
        | datum.langFormaat  | onbekend      |
