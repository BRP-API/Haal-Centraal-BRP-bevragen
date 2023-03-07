#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor adressering

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam                  | waarde     |
      | anummer (01.10)       | 8016043787 |
      | geslachtsnaam (02.40) | Maassen    |
      | geboortedatum (03.10) | 19830526   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam          | waarde                              |
      | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
      | geslachtsnaam | Maassen                             |
      | geboortedatum | 1983-05-26                          |
      | fields        | <fields>                            |
      Dan heeft de persoon met anummer '8016043787' de volgende 'protocollering' gegevens
      | anummer    | request_gevraagde_rubrieken |
      | 8016043787 | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                | gevraagde rubrieken                                                                                    |
      | adressering           | 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210, 081310, 081330, 081340, 081350 |
      | adresseringBinnenland | 080910, 081110, 081120, 081130, 081140, 081150, 081160, 081170, 081210                                 |
