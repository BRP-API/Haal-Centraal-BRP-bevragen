#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor persoon 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde     |
      | anummer (01.10)       | 8016043787 |
      | geslachtsnaam (02.40) | Maassen    |
      | geboortedatum (03.10) | 19830526   |
      Als personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | <fields>                            |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                    | gevraagde rubrieken                            |
      | naam.voornamen                            | 010210                                         |
      | naam.adellijkeTitelPredicaat              | 010220                                         |
      | naam.adellijkeTitelPredicaat.code         | 010220                                         |
      | naam.adellijkeTitelPredicaat.omschrijving | 010220                                         |
      | naam.adellijkeTitelPredicaat.soort        | 010220                                         |
      | naam.voorvoegsel                          | 010230                                         |
      | naam.geslachtsnaam                        | 010240                                         |
      | naam.voorletters                          | PANM01                                         |
      | naam.volledigeNaam                        | PANM02                                         |
      | naam                                      | 010210, 010220, 010230, 010240, PANM01, PANM02 |
