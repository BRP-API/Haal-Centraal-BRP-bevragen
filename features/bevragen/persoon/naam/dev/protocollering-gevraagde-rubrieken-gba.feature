#language: nl

@gba @protocollering
Functionaliteit: protocollering van naamgegevens van de persoon 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

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
      | fields                                    | gevraagde rubrieken                            |
      | naam                                      | 010210, 010220, 010230, 010240, 016110         |
      | naam.adellijkeTitelPredicaat              | 010220                                         |
      | naam.adellijkeTitelPredicaat.code         | 010220                                         |
      | naam.adellijkeTitelPredicaat.omschrijving | 010220                                         |
      | naam.adellijkeTitelPredicaat.soort        | 010220                                         |
      | naam                                      | 010210, 010220, 010230, 010240, 010410, 016110 |
      | naam.geslachtsnaam                        | 010240                                         |
      | naam.volledigeNaam                        | 010210, 010220, 010230, 010240, 010410         |
      | naam.voorletters                          | 010210                                         |
      | naam.voornamen                            | 010210                                         |
      | naam.voorvoegsel                          | 010230                                         |
      | naam.aanduidingNaamgebruik                | 016110                                         |
      | naam.aanduidingNaamgebruik.code           | 016110                                         |
      | naam.aanduidingNaamgebruik.omschrijving   | 016110                                         |

