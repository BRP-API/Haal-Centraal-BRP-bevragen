#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor gemeente 

  Rule: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
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
      | fields                                  | gevraagde rubrieken |
      | gemeenteVanInschrijving                 | 080910              |
      | gemeenteVanInschrijving.code            | 080910              |
      | gemeenteVanInschrijving.omschrijving    | 080910              |
      | datumInschrijvingInGemeente             | 080920              |
      | datumInschrijvingInGemeente.langFormaat | 080920              |
      | datumInschrijvingInGemeente.type        | 080920              |
      | datumInschrijvingInGemeente.datum       | 080920              |
      | datumInschrijvingInGemeente.onbekend    | 080920              |
      | datumInschrijvingInGemeente.jaar        | 080920              |
      | datumInschrijvingInGemeente.maand       | 080920              |
