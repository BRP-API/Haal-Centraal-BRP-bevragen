#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor persoon 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

    Abstract Scenario: Met fields vragen om <fields> wordt vastgelegd als gevraagde rubrieken <gevraagde rubrieken>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0599                              |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                     | waarde           |
      | gemeentecode (92.10)                     | 0599             |
      | identificatiecode verblijfplaats (11.80) | 0599010051001502 |
      Als personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599010051001502                        |
      | fields                           | <fields>                                |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

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
