#language: nl

@gba @protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor Europees kiesrecht 

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
      | fields                                             | gevraagde rubrieken |
      | europeesKiesrecht                                  | 133110, 133130      |
      | europeesKiesrecht.aanduiding                       | 133110              |
      | europeesKiesrecht.aanduiding.code                  | 133110              |
      | europeesKiesrecht.aanduiding.omschrijving          | 133110              |
      | europeesKiesrecht.einddatumUitsluiting             | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.langFormaat | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.type        | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.datum       | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.onbekend    | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.jaar        | 133130              |
      | europeesKiesrecht.einddatumUitsluiting.maand       | 133130              |
