#language: nl

Functionaliteit: Protocollering zoekrubrieken RaadpleegMetBurgerservicenummer

  Rule: Gebruikte parameters worden vertaald naar elementnummers volgens Logisch ontwerp BRP en vastgelegd in het veld 'request_zoek_rubrieken'.

    Scenario: Raadpleeg één persoon op burgerservicenummer
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 3082507314      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024                       |
      | fields              | naam                            |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken |
      | 3082507314 | 010120                 |

    Scenario: Raadpleeg meerdere personen op burgerservicenummer
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 3082507314      |
      En de persoon met burgerservicenummer '000000048' heeft de volgende gegevens
      | anummer (01.10) |
      | 6181490645      |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 000000024,000000048             |
      | fields              | naam                            |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken |
      | 3082507314 | 010120                 |
      En is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken |
      | 6181490645 | 010120                 |

    Scenario: Raadpleeg één persoon op burgerservicenummer
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
      | anummer (01.10) |
      | 3082507314      |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | naam                               | waarde   |
      | gemeente van inschrijving (09.10)  | 0599     |
      En de 'verblijfplaats' heeft de volgende 'adres' gegevens
      | naam          | waarde |
      | gemeente_code | 0599   |
      Als personen wordt gezocht met de volgende parameters
      | naam                    | waarde                          |
      | type                    | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer     | 000000024                       |
      | gemeenteVanInschrijving | 0599                            |
      | fields                  | naam                            |
      Dan is protocollering opgeslagen met de volgende gegevens
      | anummer    | request_zoek_rubrieken |
      | 3082507314 | 010120, 080910         |
