#language: nl

Functionaliteit: protocollering van het antwoord voor verblijfplaats Adres

  Rule: In het antwoord geleverde velden worden geprotocolleerd als de elementnummers volgens Logisch ontwerp BRP
    Dit is een 6-cijferige code, met zo nodig voorloopnul voor categorieën.
    Alleen velden die echt geleverd zijn, dus een waarde hebben in de response, worden opgenomen als geleverde rubriek
    Ook alle velden die worden meegeleverd voor het bepalen van het verblijfplaats type worden vastgelegd in het veld 'request_geleverde_rubrieken'.
    
    Abstract Scenario: Protocolleren van geleverde velden voor <fields veld> voor een persoon met BAG adres met huisletter en toevoeging
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 8468619643 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0518     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20190714 |
      | datum ingang geldigheid (85.10)    | 20190714 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                                       | waarde           |
      | gemeente_code                              | 0518             |
      | straatnaam (11.10)                         | Borgesiusstraat  |
      | naam openbare ruimte (11.15)               | Borgesiusstraat  |
      | huisnummer (11.20)                         | 103              |
      | huisletter (11.30)                         | b                |
      | huisnummertoevoeging (11.40)               | 2                |
      | postcode (11.60)                           | 2497BV           |
      | woonplaats (11.70)                         | Scheveningen     |
      | identificatiecode verblijfplaats (11.80)   | 0518010000747448 |
      | identificatiecode nummeraanduiding (11.90) | 0518200000747446 |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000012                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken | request_geleverde_rubrieken |
      | 8468619643 | <zoek rubrieken>       | <geleverde rubrieken>       |

      Voorbeelden:
      | fields                                 | zoek rubrieken                                                                                                                       | geleverde rubrieken                                                                        |
      | verblijfplaats.datumVan                | 081030 081110 081210 081310 081320                                                                                                   | 081030 081110                                                                              |
      | verblijfplaats.verblijfadres           | 081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350                                           | 081110 081115 081120 081130 081140 081160 081170                                           |
      | verblijfplaatsBinnenland.verblijfadres | 081110 081115 081120 081130 081140 081150 081160 081170 081210                                                                       | 081110 081115 081120 081130 081140 081160 081170                                           |
      | verblijfplaats                         | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081320 081330 081340 081350 088510 | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 088510 |
      | verblijfplaatsBinnenland               | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510                                    | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 088510 |

    Abstract Scenario: Protocolleren van geleverde velden voor <fields veld> voor een persoon met niet-BAG adres met aanduiding
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | naam            | waarde     |
      | anummer (01.10) | 4767504128 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0628     |
      | functie adres (10.10)              | W        |
      | datum aanvang adreshouding (10.30) | 20141003 |
      | datum ingang geldigheid (85.10)    | 20141003 |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam                              | waarde   |
      | gemeente_code                     | 0628     |
      | straatnaam (11.10)                | Zijldijk |
      | huisnummer (11.20)                | 11       |
      | aanduiding bij huisnummer (11.50) | by       |
      | postcode (11.60)                  | 2362XJ   |
      Als gba personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | <fields>                        |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken | request_geleverde_rubrieken |
      | 4767504128 | <zoek rubrieken>       | <geleverde rubrieken>       |

      Voorbeelden:
      | fields                                 | zoek rubrieken                                                                                                                       | geleverde rubrieken                              |
      | verblijfplaats.datumVan                | 081030 081110 081210 081310 081320                                                                                                   | 081030 081110                                    |
      | verblijfplaats.verblijfadres           | 081110 081115 081120 081130 081140 081150 081160 081170 081210 081310 081330 081340 081350                                           | 081110 081120 081150 081170                      |
      | verblijfplaatsBinnenland.verblijfadres | 081110 081115 081120 081130 081140 081150 081160 081170 081210                                                                       | 081110 081120 081150 081170                      |
      | verblijfplaats                         | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 081310 081320 081330 081340 081350 088510 | 081010 081030 081110 081120 081150 081170 088510 |
      | verblijfplaatsBinnenland               | 081010 081030 081110 081115 081120 081130 081140 081150 081160 081170 081180 081190 081210 088510                                    | 081010 081030 081110 081120 081150 081170 088510 |
