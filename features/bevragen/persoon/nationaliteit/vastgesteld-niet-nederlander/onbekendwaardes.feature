# language: nl

Functionaliteit: nationaliteit

  Scenario: 'reden opname (63.10)' met waarde '000' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde   |
    | bijzonder Nederlanderschap (65.10) | V        |
    | reden opname (63.10)               | 000    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                     |
    | type | VastgesteldNietNederlander |

    Voorbeelden:
    | fields                                   |
    | nationaliteiten                          |
    | nationaliteiten.redenOpname              |
    | nationaliteiten.redenOpname.code         |
    | nationaliteiten.redenOpname.omschrijving |
