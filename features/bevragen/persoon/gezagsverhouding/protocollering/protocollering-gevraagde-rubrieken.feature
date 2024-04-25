#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor gezagsverhouding 

  Regel: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8016043787 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                  | gevraagde rubrieken |
      | indicatieCurateleRegister               | 113310              |
      | indicatieGezagMinderjarige              | 113210              |
      | indicatieGezagMinderjarige.code         | 113210              |
      | indicatieGezagMinderjarige.omschrijving | 113210              |
