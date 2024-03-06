#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor kinderen 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
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
      | fields                                             | gevraagde rubrieken                                                    |
      | kinderen                                           | 090120, 090210, 090220, 090230, 090240, 090310, 090320, 090330, PAKD01 |
      | kinderen.burgerservicenummer                       | 090120                                                                 |
      | kinderen.geboorte                                  | 090310, 090320, 090330                                                 |
      | kinderen.geboorte.datum                            | 090310                                                                 |
      | kinderen.geboorte.datum.langFormaat                | 090310                                                                 |
      | kinderen.geboorte.datum.type                       | 090310                                                                 |
      | kinderen.geboorte.datum.datum                      | 090310                                                                 |
      | kinderen.geboorte.datum.onbekend                   | 090310                                                                 |
      | kinderen.geboorte.datum.jaar                       | 090310                                                                 |
      | kinderen.geboorte.datum.maand                      | 090310                                                                 |
      | kinderen.geboorte.land                             | 090330                                                                 |
      | kinderen.geboorte.land.code                        | 090330                                                                 |
      | kinderen.geboorte.land.omschrijving                | 090330                                                                 |
      | kinderen.geboorte.plaats                           | 090320                                                                 |
      | kinderen.geboorte.plaats.code                      | 090320                                                                 |
      | kinderen.geboorte.plaats.omschrijving              | 090320                                                                 |
      | kinderen.naam                                      | 090210, 090220, 090230, 090240, PAKD01                                 |
      | kinderen.naam.adellijkeTitelPredicaat              | 090220                                                                 |
      | kinderen.naam.adellijkeTitelPredicaat.code         | 090220                                                                 |
      | kinderen.naam.adellijkeTitelPredicaat.omschrijving | 090220                                                                 |
      | kinderen.naam.adellijkeTitelPredicaat.soort        | 090220                                                                 |
      | kinderen.naam.geslachtsnaam                        | 090240                                                                 |
      | kinderen.naam.voorletters                          | PAKD01                                                                 |
      | kinderen.naam.voornamen                            | 090210                                                                 |
      | kinderen.naam.voorvoegsel                          | 090230                                                                 |
