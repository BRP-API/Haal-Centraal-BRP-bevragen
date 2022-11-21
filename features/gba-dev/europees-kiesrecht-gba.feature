# language: nl

Functionaliteit: Europees kiesrecht

  Scenario: Geen europees kiesrecht (31.10) en geen einddatum uitsluiting europees kiesrecht (31.30)
    Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Janssen               |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000103                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: Europees kiesrecht zonder einddatum : <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende 'inschrijving' gegevens
    | europees kiesrecht (31.10) |
    | <Europees kiesrecht>       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000115                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                     | waarde                    |
    | aanduiding.code          | <Europees kiesrecht>         |
    | aanduiding.omschrijving  | <aanduiding.omschrijving> |

    Voorbeelden:
   | omschrijving                       | Europees kiesrecht | aanduiding.omschrijving |
   | uitgesloten zonder einddatum       | 1                  | persoon is uitgesloten  |
   | persoon ontvangt oproep            | 2                  | persoon ontvangt oproep |


  Abstract Scenario: Europees kiesrecht <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'inschrijving' gegevens
    | europees kiesrecht (31.10) | einddatum uitsluiting europees kiesrecht (31.30) |
    | <Europees kiesrecht>       | <einddatum uitsluiting>                          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000127                             |
    | fields              | burgerservicenummer,europeesKiesrecht |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                       | waarde                    |
    | burgerservicenummer                        | 000000127                 |
    | europeesKiesrecht.aanduiding.code          | <aanduiding.code>         |
    | europeesKiesrecht.aanduiding.omschrijving  | <aanduiding.omschrijving> |
    | europeesKiesrecht.einddatumUitsluiting     | <einddatumUitsluiting>    |

    Voorbeelden:
    | omschrijving                       | Europees kiesrecht | einddatum uitsluiting | aanduiding.code | aanduiding.omschrijving | einddatumUitsluiting |
    | einddatum uitsluiting in toekomst  | 1                  | volgend jaar          | 1               | persoon is uitgesloten  | volgend jaar         |
    | einddatum uitsluiting in verleden  | 1                  | gisteren              |                 |                         |                      |
    | einddatum uitsluiting vandaag      | 1                  | vandaag               |                 |                         |                      |
    | einddatum uitsluiting morgen       | 1                  | morgen                | 1               | persoon is uitgesloten  | morgen               |
    | einddatum uitsluiting vorige maand | 1                  | vorige maand          |                 |                         |                      |
    | einddatum uitsluiting deze maand   | 1                  | deze maand            | 1               | persoon is uitgesloten  | deze maand           |
    | einddatum uitsluiting vorig jaar   | 1                  | vorig jaar            |                 |                         |                      |
    | einddatum uitsluiting dit jaar     | 1                  | dit jaar              | 1               | persoon is uitgesloten  | dit jaar             |
    | einddatum uitsluiting onbekend     | 1                  | 00000000              | 1               | persoon is uitgesloten  | 00000000             |

  Scenario: Europees kiesrecht zonder aanduiding wordt niet geleverd
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'inschrijving' gegevens
    | einddatum uitsluiting europees kiesrecht (31.30) |
    | morgen                                           |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000127                             |
    | fields              | burgerservicenummer,europeesKiesrecht |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                       | waarde                    |
    | burgerservicenummer                        | 000000127                 |
