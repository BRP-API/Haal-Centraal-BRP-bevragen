#language: nl

Functionaliteit: GBA persoon: velden vragen met fields

  Abstract Scenario: persoon heeft veld: 'anummer (01.10)' <sub-titel>
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam            | waarde       |
    | anummer (01.10) | <gba waarde> |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | aNummer                         |
    Dan heeft de response een persoon met de volgende gegevens
    | naam    | waarde       |
    | aNummer | <gba waarde> |

    Voorbeelden:
    | sub-titel          | gba waarde |
    |                    | 1234567890 |
    | met voorloopnul    | 0123456789 |
    | met voorloopnullen | 0001234567 |
