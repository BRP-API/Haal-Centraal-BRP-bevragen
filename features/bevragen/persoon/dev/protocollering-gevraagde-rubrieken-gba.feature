#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor persoon 

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
      | aNummer                                   | 010110                                         |
      | burgerservicenummer                       | 010120                                         |
      | geboorte                                  | 010310, 010320, 010330                         |
      | geboorte.datum                            | 010310                                         |
      | geboorte.datum.langFormaat                | 010310                                         |
      | geboorte.datum.type                       | 010310                                         |
      | geboorte.datum.datum                      | 010310                                         |
      | geboorte.datum.onbekend                   | 010310                                         |
      | geboorte.datum.jaar                       | 010310                                         |
      | geboorte.datum.maand                      | 010310                                         |
      | geboorte.land                             | 010330                                         |
      | geboorte.land.code                        | 010330                                         |
      | geboorte.land.omschrijving                | 010330                                         |
      | geboorte.plaats                           | 010320                                         |
      | geboorte.plaats.code                      | 010320                                         |
      | geboorte.plaats.omschrijving              | 010320                                         |
      | geslacht                                  | 010410                                         |
      | geslacht.code                             | 010410                                         |
      | geslacht.omschrijving                     | 010410                                         |
      | leeftijd                                  | 010310                                         |
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

