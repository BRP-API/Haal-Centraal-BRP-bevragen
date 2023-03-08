# language: nl

Functionaliteit: Persoon: partner velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en de velden burgerservicenummer, soortVerbintenis en geslacht wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
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
    | aanduiding in onderzoek | burgerservicenummer io | soort verbintenis io | geslacht io | type                            |
    | 050000                  | true                   | true                 | true        | hele categorie partner          |
    | 050100                  | true                   |                      |             | hele groep identificatienummers |
    | 050120                  | true                   |                      |             | burgerservicenummer             |
    | 050400                  |                        |                      | true        | hele groep geslacht             |
    | 050410                  |                        |                      | true        | geslachtsaanduiding             |
    | 051500                  |                        | true                 |             | hele groep soort verbintenis    |
    | 051510                  |                        | true                 |             | soort verbintenis               |

  Abstract Scenario: '<type>' is in onderzoek, maar veld '<veld naam>' wordt niet gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | voornamen (02.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | Merel             | <aanduiding in onderzoek>       | 20020701                       |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <gevraagde fields>              |
    Dan heeft de response een persoon met een 'partner' zonder gegevens

    Voorbeelden:
    | aanduiding in onderzoek | type                            | veldnaam            | gevraagde fields             |
    | 050100                  | hele groep identificatienummers | burgerservicenummer | partners.soortVerbintenis    |
    | 050120                  | burgerservicenummer             | burgerservicenummer | partners.soortVerbintenis    |
    | 050400                  | hele groep geslacht             | geslacht            | partners.burgerservicenummer |
    | 050410                  | geslachtsaanduiding             | geslacht            | partners.burgerservicenummer |
    | 051500                  | hele groep soort verbintenis    | soortVerbintenis    | partners.geslacht            |
    | 051510                  | soort verbintenis               | soortVerbintenis    | partners.geslacht            |
