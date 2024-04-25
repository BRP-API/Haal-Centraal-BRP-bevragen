#language: nl

@protocollering
Functionaliteit: protocollering van de gevraagde gegevens voor verblijfstitel 

  Regel: Met fields gevraagde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.

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
      | fields                                 | gevraagde rubrieken    |
      | verblijfstitel                         | 103910, 103920, 103930 |
      | verblijfstitel.aanduiding              | 103910                 |
      | verblijfstitel.aanduiding.code         | 103910                 |
      | verblijfstitel.aanduiding.omschrijving | 103910                 |
      | verblijfstitel.datumEinde              | 103920                 |
      | verblijfstitel.datumEinde.langFormaat  | 103920                 |
      | verblijfstitel.datumEinde.type         | 103920                 |
      | verblijfstitel.datumEinde.datum        | 103920                 |
      | verblijfstitel.datumEinde.onbekend     | 103920                 |
      | verblijfstitel.datumEinde.jaar         | 103920                 |
      | verblijfstitel.datumEinde.maand        | 103920                 |
      | verblijfstitel.datumIngang             | 103930                 |
      | verblijfstitel.datumIngang.langFormaat | 103930                 |
      | verblijfstitel.datumIngang.type        | 103930                 |
      | verblijfstitel.datumIngang.datum       | 103930                 |
      | verblijfstitel.datumIngang.onbekend    | 103930                 |
      | verblijfstitel.datumIngang.jaar        | 103930                 |
      | verblijfstitel.datumIngang.maand       | 103930                 |
