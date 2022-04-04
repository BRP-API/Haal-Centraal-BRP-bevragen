# language: nl

@proxy @post-assert
Functionaliteit: leveren van een verblijfplaats

  Abstract Scenario: waarde land (13.10) is ongelijk aan '0000'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam         | waarde |
    | land (13.10) | <land> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 555550001                          |
    | fields              | burgerservicenummer,verblijfplaats |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    Dan heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam      | waarde                   |
    | type      | VerblijfplaatsBuitenland |
    | land.code | <land>                   |

    Voorbeelden:
    | land |
    | 6014 |
    | 9999 |

  Abstract Scenario: verblijfplaats buitenland. Overnemen veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam         | waarde   |
    | land (13.10) | 6014     |
    | <gba naam>   | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | burgerservicenummer,verblijfplaats.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam   | waarde                   |
    | type   | VerblijfplaatsBuitenland |
    | <naam> | <waarde>                 |

    Voorbeelden:
    | gba naam                             | naam                                 | waarde                             |
    | adresregel1 (13.30)                  | adresregel1                          | 1600 Pennsylvania Avenue NW        |
    | adresregel2 (13.40)                  | adresregel2                          | Washington, DC 20500               |
    | adresregel3 (13.50)                  | adresregel3                          | Selangor                           |
    | gemeente van inschrijving (09.10)    | gemeenteVanInschrijving.code         | 1999                               |
    | gemeenteVanInschrijving.omschrijving | gemeenteVanInschrijving.omschrijving | Registratie Niet Ingezetenen (RNI) |
    | land.omschrijving                    | land.omschrijving                    | Verenigde Staten van Amerika       |

  Abstract Scenario: verblijfplaats buitenland. Omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | naam         | waarde       |
    | land (13.10) | 6014         |
    | <gba naam>   | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                    |
    | type                | RaadpleegMetBurgerservicenummer           |
    | burgerservicenummer | 555550001                                 |
    | fields              | burgerservicenummer,verblijfplaats.<naam> |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    Dan heeft de persoon de volgende 'verblijfplaats' gegevens
    | naam         | waarde                   |
    | type         | VerblijfplaatsBuitenland |
    | <naam>.type  | Datum                    |
    | <naam>.datum | <waarde>                 |

    Voorbeelden:
    | gba naam                            | gba waarde | naam                        | waarde     |
    | datumInschrijvingInGemeente (09.20) | 20020701   | datumInschrijvingInGemeente | 2002-07-01 |
    | datumAanvangAdresBuitenland (13.20) | 20220128   | datumVan                    | 2022-01-28 |
