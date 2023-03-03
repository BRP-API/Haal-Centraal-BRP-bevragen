#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor persoon 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

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
      | fields                     | gevraagde rubrieken |
      | geboorte                   | 010310              |
      | geboorte.datum             | 010310              |
      | geboorte.datum.langFormaat | 010310              |
      | geboorte.datum.type        | 010310              |
      | geboorte.datum.datum       | 010310              |
      | geboorte.datum.onbekend    | 010310              |
      | geboorte.datum.jaar        | 010310              |
      | geboorte.datum.maand       | 010310              |
