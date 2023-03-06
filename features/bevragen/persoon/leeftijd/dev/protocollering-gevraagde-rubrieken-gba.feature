#language: nl

@gba @protocollering
Functionaliteit: protocollering van leeftijd van de persoon

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '8016043787' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 8016043787 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields         | gevraagde rubrieken |
      | geboorte.datum | 010310              |
      | leeftijd       | 010310              |
