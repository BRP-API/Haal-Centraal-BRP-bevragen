# language: nl

Functionaliteit: Persoon - verblijfplaats binnenland (locatie): verblijfadres velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                               | waarde   |
    | datum aanvang adreshouding (10.30) | 20150808 |
    | datum ingang geldigheid (85.10)    | 20220222 |
    | functie adres (10.10)              | W        |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | naam                        | waarde                      |
    | gemeentecode (92.10)        | 0518                        |
    | locatiebeschrijving (12.10) | Woonboot bij de Grote Sloot |

  Scenario: 'locatiebeschrijving (12.10)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.locatiebeschrijving'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                           |
    | type                | RaadpleegMetBurgerservicenummer                  |
    | burgerservicenummer | 000000152                                        |
    | fields              | verblijfplaats.verblijfadres.locatiebeschrijving |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                      |
    | type                              | Locatie                     |
    | verblijfadres.locatiebeschrijving | Woonboot bij de Grote Sloot |

  Scenario: alle adres velden wordt gevraagd met field pad 'verblijfplaats.verblijfadres'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                              | waarde                      |
    | type                              | Locatie                     |
    | verblijfadres.locatiebeschrijving | Woonboot bij de Grote Sloot |
