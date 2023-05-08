#language: nl

@gba
Functionaliteit: geboorte in onderzoek

  Abstract Scenario: geboorte veld(en) van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    | geboortedatum (03.10)           | 19630405                  |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.datum                  |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                             | waarde                    |
    | geboorte.datum                                   | 19630405                  |
    | persoonInOnderzoek.aanduidingGegevensInOnderzoek | <gba in onderzoek waarde> |
    | persoonInOnderzoek.datumIngangOnderzoek          | 20020701                  |

    Voorbeelden:
    | gba in onderzoek waarde |
    | 010000                  |
    | 010200                  |
    | 010300                  |
    | 010310                  |
