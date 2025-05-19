# language: nl
Functionaliteit: vragen van een tabelwaardeveld met fields

  Regel: Het vragen van één of meerdere velden van een 'waardetabel' veld levert alle velden van de 'waardetabel' veld

    Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met field pad '<fields>'
      Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
        | geslachtsaanduiding (04.10) |
        | V                           |
      Als personen wordt gezocht met de volgende parameters
        | naam                | waarde                          |
        | type                | RaadpleegMetBurgerservicenummer |
        | burgerservicenummer |                       000000152 |
        | fields              | <fields>                        |
      Dan heeft de response een persoon met de volgende gegevens
        | naam                  | waarde |
        | geslacht.code         | V      |
        | geslacht.omschrijving | vrouw  |

      Voorbeelden:
        | fields                |
        | geslacht              |
        | geslacht.code         |
        | geslacht.omschrijving |
