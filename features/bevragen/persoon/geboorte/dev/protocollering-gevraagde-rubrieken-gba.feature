#language: nl

@gba @protocollering
Functionaliteit: protocollering van geboortegegevens van de persoon

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

