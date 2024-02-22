#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor adressering in gezag persoon beperkt

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'verblijfplaats' gegevens
      | functie adres (10.10) |
      | W                     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | identificatiecode verblijfplaats (11.80) |
      | 0599010051001502                         |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                | gevraagde rubrieken                                                                                    |
      | adressering           | 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210, 081310, 081330, 081340, 081350 |
      | adresseringBinnenland | 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210                                 |
