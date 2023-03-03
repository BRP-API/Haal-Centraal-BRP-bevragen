#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor adressering

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde     |
      | anummer (01.10)       | 8016043787 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan heeft de persoon met anummer '8016043787' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 8016043787 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                | gevraagde rubrieken                                                                                    |
      | adressering           | 010210, 010220, 010230, 010240, 010410, 016110, 050220, 050230, 050240, 050610, 050710, 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210, 081310, 081330, 081340, 081350 |
      | adresseringBinnenland | 010210, 010220, 010230, 010240, 010410, 016110, 050220, 050230, 050240, 050610, 050710, 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210                                 |
