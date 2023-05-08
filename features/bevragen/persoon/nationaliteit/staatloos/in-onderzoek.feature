#language: nl

Functionaliteit: Persoon: 'staatloos' nationaliteit velden in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en alle nationaliteit velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde                    |
    | nationaliteit (05.10)           | 0499                      |
    | reden opname (63.10)            | 001                       |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                                            |
    | type                                         | Staatloos                                         |
    | redenOpname.code                             | 001                                               |
    | redenOpname.omschrijving                     | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | inOnderzoek.type                             | <type io>                                         |
    | inOnderzoek.redenOpname                      | <reden opname io>                                 |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                             |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                       |

    Voorbeelden:
    | gba in onderzoek waarde | reden opname io | type io | type                                  |
    | 040000                  | true            | true    | hele categorie nationaliteit          |
    | 040500                  |                 | true    | hele groep nationaliteit              |
    | 040510                  |                 | true    | nationaliteit                         |
    | 046300                  | true            |         | hele groep opnemen nationaliteit      |
    | 046310                  | true            |         | reden opname nationaliteit            |
    | 046500                  |                 | true    | hele groep bijzonder Nederlanderschap |
    | 046510                  |                 | true    | aanduiding bijzonder Nederlanderschap |
