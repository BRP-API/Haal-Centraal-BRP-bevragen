#language: nl

@post-assert
Functionaliteit: Persoon Geboorte

  Abstract Scenario: persoon heeft 'geboorte' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | geboorte                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam               | waarde         |
    | <naam>.type        | Datum          |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam              | gba waarde | naam  | waarde     | lang formaat |
    | geboortedatum (03.10) | 20020701   | datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: persoon heeft 'geboorte' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende 'geboorte' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | geboorte.<field>                |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam    | waarde   |
    | <field> | <waarde> |

    Voorbeelden:
    | gba naam               | field               | waarde                       |
    | geboorteplaats (03.20) | plaats.code         | 0518                         |
    | plaats.omschrijving    | plaats.omschrijving | 's-Gravenhage                |
    | geboorteland (03.30)   | land.code           | 6014                         |
    | land.omschrijving      | land.omschrijving   | Verenigde Staten van Amerika |