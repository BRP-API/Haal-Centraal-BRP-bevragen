# language: nl

@post-assert
Functionaliteit: behandeld als Nederlander

  Scenario: persoon wordt 'behandeld als Nederlander'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde |
    | bijzonder Nederlanderschap (65.10) | B      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                  |
    | type | BehandeldAlsNederlander |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde   |
    | bijzonder Nederlanderschap (65.10) | B        |
    | <gba naam>                         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam   | waarde                  |
    | type   | BehandeldAlsNederlander |
    | <naam> | <waarde>                |

    Voorbeelden:
    | gba naam                 | naam                     | waarde           |
    | reden opname (63.10)     | redenOpname.code         | 1234             |
    | redenOpname.omschrijving | redenOpname.omschrijving | een omschrijving |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' veld: '<gba naam>' met waarde '<waarde>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde   |
    | bijzonder Nederlanderschap (65.10) | B        |
    | <gba naam>                         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                  |
    | type | BehandeldAlsNederlander |

    Voorbeelden:
    | gba naam             | naam             | waarde |
    | reden opname (63.10) | redenOpname.code | 000    |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde       |
    | bijzonder Nederlanderschap (65.10) | B            |
    | <gba naam>                         | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam         | waarde                  |
    | type         | BehandeldAlsNederlander |
    | <naam>.type  | <type>                  |
    | <naam>.datum | <waarde>                |

    Voorbeelden:
    | gba naam                        | gba waarde | naam                  | type  | waarde     |
    | ingangsdatum geldigheid (85.10) | 20020701   | datumIngangGeldigheid | Datum | 2002-07-01 |

  Abstract Scenario: persoon's 'behandeld als Nederlander' nationaliteit is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                                     | waarde                    |
    | bijzonder Nederlanderschap (65.10)       | B                         |
    | reden opname (63.10)                     | 001                       |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                   | waarde                      |
    | type                                   | BehandeldAlsNederlander     |
    | redenOpname.code                       | 001                         |
    | inOnderzoek.type                       | <type in onderzoek>         |
    | inOnderzoek.redenOpname                | <reden opname in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek.type  | Datum                       |
    | inOnderzoek.datumIngangOnderzoek.datum | 2002-07-01                  |

    Voorbeelden:
    | gba in onderzoek waarde | reden opname in onderzoek | type in onderzoek |
    | 040000                  | true                      | true              |
    | 040500                  |                           | true              |
    | 040510                  |                           | true              |
    | 046300                  | true                      |                   |
    | 046310                  | true                      |                   |
    | 046500                  |                           | true              |
    | 046510                  |                           | true              |
