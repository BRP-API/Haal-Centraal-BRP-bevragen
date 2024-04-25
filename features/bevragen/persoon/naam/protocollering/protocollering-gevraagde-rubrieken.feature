#language: nl

@protocollering
Functionaliteit: protocollering van naamgegevens van de persoon 

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
      | fields                                    | gevraagde rubrieken                                    |
      | naam.adellijkeTitelPredicaat              | 010220                                                 |
      | naam.adellijkeTitelPredicaat.code         | 010220                                                 |
      | naam.adellijkeTitelPredicaat.omschrijving | 010220                                                 |
      | naam.adellijkeTitelPredicaat.soort        | 010220                                                 |
      | naam.geslachtsnaam                        | 010240                                                 |
      | naam.voornamen                            | 010210                                                 |
      | naam.voorvoegsel                          | 010230                                                 |
      | naam.aanduidingNaamgebruik                | 016110                                                 |
      | naam.aanduidingNaamgebruik.code           | 016110                                                 |
      | naam.aanduidingNaamgebruik.omschrijving   | 016110                                                 |
      | naam.voorletters                          | PANM01                                                 |
      | naam.volledigeNaam                        | PANM02                                                 |
      | naam                                      | 010210, 010220, 010230, 010240, 016110, PANM01, PANM02 |

