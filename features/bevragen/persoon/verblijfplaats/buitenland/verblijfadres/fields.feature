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

  Abstract Scenario: 'regel 1 adres buitenland (13.30)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                      |
    | type                 | VerblijfplaatsBuitenland    |
    | verblijfadres.regel1 | 1600 Pennsylvania Avenue NW |

    Voorbeelden:
    | fields                              |
    | verblijfplaats.verblijfadres.regel1 |

  Abstract Scenario: 'regel 2 adres buitenland (13.40)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.regel2 | Washington, DC 20500     |

    Voorbeelden:
    | fields                              |
    | verblijfplaats.verblijfadres.regel2 |

  Abstract Scenario: 'regel 3 adres buitenland (13.50)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                 | waarde                   |
    | type                 | VerblijfplaatsBuitenland |
    | verblijfadres.regel3 | Selangor                 |

    Voorbeelden:
    | fields                              |
    | verblijfplaats.verblijfadres.regel3 |

  Abstract Scenario: 'land adres buitenland (13.10)' wordt gevraagd met field pad '<fields>'
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                       |
    | type                            | VerblijfplaatsBuitenland     |
    | verblijfadres.land.code         | 6014                         |
    | verblijfadres.land.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                            |
    | verblijfplaats.verblijfadres.land |
