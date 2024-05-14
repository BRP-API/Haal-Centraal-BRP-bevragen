#language: nl

Functionaliteit: Raadpleeg met burgerservicenummer

Regel: voor het raadplegen van een persoon moet zijn burgerservicenummer worden opgegeven

  Scenario: Raadpleeg één persoon
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) |
    | 0123456789      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024                       |
    | fields              | burgerservicenummer             |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |

Regel: voor het raadplegen van meerdere personen moeten hun burgerservicenummers worden opgegeven

  Scenario: Raadpleeg meerdere personen
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende gegevens
    | anummer (01.10) |
    | 0123456789      |
    En de persoon met burgerservicenummer '000000025' heeft de volgende gegevens
    | anummer (01.10) |
    | 1234567890      |
    En de persoon met burgerservicenummer '000000026' heeft de volgende gegevens
    | anummer (01.10) |
    | 2345678901      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000024,000000025,000000026   |
    | fields              | burgerservicenummer             |
    Dan heeft de response 3 personen
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000025 |
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000026 |

Regel: De optionele 'gemeenteVanInschrijving' parameter kan worden toegevoegd om de zoek criteria aan te scherpen

  Scenario: Raadpleeg persoon met gemeenteVanInschrijving
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                          |
    | type                    | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer     | 000000024                       |
    | gemeenteVanInschrijving | 0599                            |
    | fields                  | burgerservicenummer             |
    Dan heeft de response 1 persoon
    En heeft de response een persoon met alleen de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000024 |

  Scenario: Raadpleeg persoon met gemeenteVanInschrijving
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0599                              |
    Als personen wordt gezocht met de volgende parameters
    | naam                    | waarde                          |
    | type                    | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer     | 000000024                       |
    | gemeenteVanInschrijving | 0518                            |
    | fields                  | burgerservicenummer             |
    Dan heeft de response 0 personen
