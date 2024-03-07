#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor overlijden 

  Rule: Gebruikte parameters worden vertaald naar rubrieknummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

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
      | fields                         | gevraagde rubrieken    |
      | overlijden                     | 060810, 060820, 060830 |
      | overlijden.datum               | 060810                 |
      | overlijden.datum.langFormaat   | 060810                 |
      | overlijden.datum.type          | 060810                 |
      | overlijden.datum.datum         | 060810                 |
      | overlijden.datum.onbekend      | 060810                 |
      | overlijden.datum.jaar          | 060810                 |
      | overlijden.datum.maand         | 060810                 |
      | overlijden.land                | 060830                 |
      | overlijden.land.code           | 060830                 |
      | overlijden.land.omschrijving   | 060830                 |
      | overlijden.plaats              | 060820                 |
      | overlijden.plaats.code         | 060820                 |
      | overlijden.plaats.omschrijving | 060820                 |
