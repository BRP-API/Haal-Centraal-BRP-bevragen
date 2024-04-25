#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor immigratie 

  Regel: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_gevraagde_rubrieken'.

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
      | fields                                           | gevraagde rubrieken            |
      | immigratie                                       | 081410, 081420, PAVP05, PAVP06 |
      | immigratie.datumVestigingInNederland             | 081420                         |
      | immigratie.datumVestigingInNederland.langFormaat | 081420                         |
      | immigratie.datumVestigingInNederland.type        | 081420                         |
      | immigratie.datumVestigingInNederland.datum       | 081420                         |
      | immigratie.datumVestigingInNederland.onbekend    | 081420                         |
      | immigratie.datumVestigingInNederland.jaar        | 081420                         |
      | immigratie.datumVestigingInNederland.maand       | 081420                         |
      | immigratie.landVanwaarIngeschreven               | 081410                         |
      | immigratie.landVanwaarIngeschreven.code          | 081410                         |
      | immigratie.landVanwaarIngeschreven.omschrijving  | 081410                         |
      | immigratie.indicatieVestigingVanuitBuitenland    | PAVP05                         |
      | immigratie.vanuitVerblijfplaatsOnbekend          | PAVP06                         |
