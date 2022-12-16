#language: nl

Functionaliteit: protocollering van het antwoord voor verblijfplaats onbekend

  Rule: Geleverde velden worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_geleverde_rubrieken'.
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Alleen velden die echt geleverd zijn, dus een waarde hebben in de response, worden opgenomen als geleverde rubriek
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_geleverde_rubrieken'.
    
    Abstract Scenario: Protocolleren van geleverde velden voor <fields veld> voor een persoon met onbekende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000061' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 1041968780 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                                   | waarde   |
      | gemeente van inschrijving (09.10)      | 1999     |
      | land (13.10)                           | 0000     |
      | datum aanvang adres buitenland (13.20) | 00000000 |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000061                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken | request_geleverde_rubrieken |
      | 1041968780 | <zoek rubrieken>       | <geleverde rubrieken>       |

      Voorbeelden:
      | fields                                 | zoek rubrieken                                                                                                                       | geleverde rubrieken  |
      | verblijfplaats.datumVan                | 081030 081110 081210 081310 081320                                                                                                   | 081310 081320        |
      | verblijfplaats.verblijfadres           | 081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350                                           | 081310               |
      | verblijfplaatsBinnenland.verblijfadres | 081110 081115 081120 081130 081140 081150 081160 081170 081210                                                                       |                      |
      | verblijfplaats                         | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081320 081330 081340 081350 088510 | 081310 081320 088510 |
      | verblijfplaatsBinnenland               | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510                                    |                      |
