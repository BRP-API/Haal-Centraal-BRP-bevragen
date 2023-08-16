# language: nl

Functionaliteit: Persoon: 'vastgesteld niet-Nederlander' nationaliteit velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle nationaliteit velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde                    |
    | bijzonder Nederlanderschap (65.10) | V                         |
    | reden opname (63.10)               | 001                       |
    | aanduiding in onderzoek (83.10)    | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                                            |
    | type                                         | VastgesteldNietNederlander                        |
    | redenOpname.code                             | 001                                               |
    | redenOpname.omschrijving                     | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | inOnderzoek.type                             | <type io>                                         |
    | inOnderzoek.redenOpname                      | <reden opname io>                                 |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                             |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                       |

    Voorbeelden:
    | aanduiding in onderzoek | reden opname io | type io | type                                  |
    | 040000                  | true            | true    | hele categorie nationaliteit          |
    | 040500                  |                 | true    | hele groep nationaliteit              |
    | 040510                  |                 | true    | nationaliteit                         |
    | 046300                  | true            |         | hele groep opnemen nationaliteit      |
    | 046310                  | true            |         | reden opname nationaliteit            |
    | 046500                  |                 | true    | hele groep bijzonder Nederlanderschap |
    | 046510                  |                 | true    | aanduiding bijzonder Nederlanderschap |

  Abstract Scenario: '<type>' is in onderzoek en alleen reden opname veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde                    |
    | bijzonder Nederlanderschap (65.10) | V                         |
    | reden opname (63.10)               | 001                       |
    | aanduiding in onderzoek (83.10)    | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.redenOpname     |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                                            |
    | type                                         | VastgesteldNietNederlander                        |
    | redenOpname.code                             | 001                                               |
    | redenOpname.omschrijving                     | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | inOnderzoek.type                             | <type io>                                         |
    | inOnderzoek.redenOpname                      | <reden opname io>                                 |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                             |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                       |

    Voorbeelden:
    | aanduiding in onderzoek | reden opname io | type io | type                                  |
    | 040000                  | true            | true    | hele categorie nationaliteit          |
    | 040500                  |                 | true    | hele groep nationaliteit              |
    | 040510                  |                 | true    | nationaliteit                         |
    | 046300                  | true            |         | hele groep opnemen nationaliteit      |
    | 046310                  | true            |         | reden opname nationaliteit            |
    | 046500                  |                 | true    | hele groep bijzonder Nederlanderschap |
    | 046510                  |                 | true    | aanduiding bijzonder Nederlanderschap |
