# language: nl

Functionaliteit: Persoon: partner velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en de velden burgerservicenummer, soortVerbintenis en geslacht wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetBurgerservicenummer                                          |
    | burgerservicenummer | 000000012                                                                |
    | fields              | partners.burgerservicenummer,partners.soortVerbintenis,partners.geslacht |
    Dan heeft de response een persoon met een 'partner' met alleen de volgende gegevens
    | naam                                         | waarde                   |
    | inOnderzoek.burgerservicenummer              | <burgerservicenummer io> |
    | inOnderzoek.soortVerbintenis                 | <soort verbintenis io>   |
    | inOnderzoek.geslacht                         | <geslacht io>            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                    |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01               |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002              |

    Voorbeelden:
    | aanduiding in onderzoek | burgerservicenummer io | soort verbintenis io | geslacht io | type |
    | 050000                  | true                   | true                 | true        |      |
    | 050100                  | true                   |                      |             |      |
    | 050120                  | true                   |                      |             |      |
    | 050400                  |                        |                      | true        |      |
    | 050410                  |                        |                      | true        |      |
    | 051500                  |                        | true                 |             |      |
    | 051510                  |                        | true                 |             |      |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type | veldnaam            | gevraagde fields             |
    | 050100                  |      | burgerservicenummer | partners.soortVerbintenis    |
    | 050120                  |      | burgerservicenummer | partners.soortVerbintenis    |
    | 050400                  |      | geslacht            | partners.burgerservicenummer |
    | 050410                  |      | geslacht            | partners.burgerservicenummer |
    | 051500                  |      | soortVerbintenis    | partners.geslacht            |
    | 051510                  |      | soortVerbintenis    | partners.geslacht            |
