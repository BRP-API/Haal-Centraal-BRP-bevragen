# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland - verblijfadres velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                                   | waarde                      |
    | datum aanvang adres buitenland (13.20) | 20150808                    |
    | land adres buitenland (13.10)          | 6014                        |
    | regel 1 adres buitenland (13.30)       | 1600 Pennsylvania Avenue NW |
    | regel 2 adres buitenland (13.40)       | Washington, DC 20500        |
    | regel 3 adres buitenland (13.50)       | Selangor                    |

  Scenario: 'regel 1 adres buitenland (13.30)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.regel1'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel1 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                      |
    | type                 | VerblijfplaatsBuitenland    |
    | verblijfadres.regel1 | 1600 Pennsylvania Avenue NW |

  Scenario: 'regel 2 adres buitenland (13.40)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.regel2'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel2 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.regel2 | Washington, DC 20500     |

  Scenario: 'regel 3 adres buitenland (13.50)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.regel3'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.regel3 |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.regel3 | Selangor                 |

  Scenario: 'land adres buitenland (13.10)' wordt gevraagd met field pad 'verblijfplaats.verblijfadres.land'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                            |
    | type                | RaadpleegMetBurgerservicenummer   |
    | burgerservicenummer | 000000152                         |
    | fields              | verblijfplaats.verblijfadres.land |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                       |
    | type                            | VerblijfplaatsBuitenland     |
    | verblijfadres.land.code         | 6014                         |
    | verblijfadres.land.omschrijving | Verenigde Staten van Amerika |

  Scenario: alle verblijfadres velden wordt gevraagd met field pad 'verblijfplaats.verblijfadres'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | verblijfplaats.verblijfadres    |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                       |
    | type                            | VerblijfplaatsBuitenland     |
    | verblijfadres.regel1            | 1600 Pennsylvania Avenue NW  |
    | verblijfadres.regel2            | Washington, DC 20500         |
    | verblijfadres.regel3            | Selangor                     |
    | verblijfadres.land.code         | 6014                         |
    | verblijfadres.land.omschrijving | Verenigde Staten van Amerika |
