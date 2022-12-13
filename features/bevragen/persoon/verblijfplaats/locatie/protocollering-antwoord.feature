#language: nl

Functionaliteit: protocollering van het antwoord voor verblijfplaats locatie

  Rule: In het antwoord geleverde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Alleen velden die echt geleverd zijn, dus een waarde hebben in de response, worden opgenomen als geleverde rubriek
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden opgenomen.
    
    Abstract Scenario: Protocolleren van geleverde velden voor <fields veld> voor een persoon met locatiebeschrijving
      Gegeven de persoon met burgerservicenummer '000000036' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 5875306514 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0628     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20141003 |
      | datum ingang geldigheid (85.10)    | 20141003 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                        | waarde                            |
      | gemeente_code               | 0530                              |
      | locatiebeschrijving (12.10) | Woonboot tegenover de Grote Sloot |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000036                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_geleverde_rubrieken |
      | 5875306514 | <geleverde rubrieken>       |

      Voorbeelden:
      | fields                                 | zoek rubrieken                                                                                                                       | geleverde rubrieken         |
      | verblijfplaats.datumVan                | 081030 081110 081210 081310 081320                                                                                                   | 081030 081210               |
      | verblijfplaats.verblijfadres           | 081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350                                           | 081210                      |
      | verblijfplaatsBinnenland.verblijfadres | 081110 081115 081120 081130 081140 081150 081160 081170 081210                                                                       | 081210                      |
      | verblijfplaats                         | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081320 081330 081340 081350 088510 | 081010 081030 081210 088510 |
      | verblijfplaatsBinnenland               | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510                                    | 081010 081030 081210 088510 |
