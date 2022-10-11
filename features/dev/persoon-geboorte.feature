#language: nl

Functionaliteit: Persoon Geboorte

  Abstract Scenario: persoon heeft 'geboorte' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
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
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | geboorte.<field>                |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam    | waarde   |
    | <field> | <waarde> |

    Voorbeelden:
    | gba naam               | field               | gba waarde | waarde                       |
    | geboorteplaats (03.20) | plaats.code         | 0518       | 0518                         |
    | geboorteplaats (03.20) | plaats.omschrijving | 0518       | 's-Gravenhage                |
    | geboorteland (03.30)   | land.code           | 6014       | 6014                         |
    | geboorteland (03.30)   | land.omschrijving   | 6014       | Verenigde Staten van Amerika |
