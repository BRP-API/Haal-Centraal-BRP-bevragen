# language: nl

Functionaliteit: Persoon: verblijfplaats buitenland -verblijfadres

  Abstract Scenario: persoon heeft 'verblijfplaats' veld: 'land adres buitenland (13.10)' met waarde ongelijk aan '0000'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                          | waarde |
    | land adres buitenland (13.10) | <code> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <field>                         |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam                            | waarde                   |
    | type                            | VerblijfplaatsBuitenland |
    | verblijfadres.land.code         | <code>                   |
    | verblijfadres.land.omschrijving | <omschrijving>           |

    Voorbeelden:
    | field                                          | code | omschrijving                 |
    | verblijfplaats.verblijfadres.land              | 5034 | Albanië                      |
    | verblijfplaats.verblijfadres.land.code         | 6014 | Verenigde Staten van Amerika |
    | verblijfplaats.verblijfadres.land.omschrijving | 9999 | Internationaal gebied        |

  Abstract Scenario: persoon heeft 'verblijfplaats buitenland' veld met onbekend waarde: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'verblijfplaats' gegevens
    | naam                             | waarde                      |
    | regel 1 adres buitenland (13.30) | 1600 Pennsylvania Avenue NW |
    | <gba naam>                       | <waarde>                    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                              |
    | type                | RaadpleegMetBurgerservicenummer     |
    | burgerservicenummer | 000000152                           |
    | fields              | verblijfplaats.verblijfadres.<naam> |
    Dan heeft de response een persoon met de volgende 'verblijfplaats' gegevens
    | naam | waarde                   |
    | type | VerblijfplaatsBuitenland |

    Voorbeelden:
    | gba naam                      | naam | waarde |
    | land adres buitenland (13.10) | land | 0000   |
