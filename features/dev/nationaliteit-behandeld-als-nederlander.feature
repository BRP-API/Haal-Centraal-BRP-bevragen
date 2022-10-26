# language: nl

Functionaliteit: Persoon: nationaliteit - behandeld als Nederlander

  Abstract Scenario: persoon wordt 'behandeld als Nederlander'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                  |
    | type | BehandeldAlsNederlander |

    Voorbeelden:
    | gba naam                           | waarde |
    | bijzonder Nederlanderschap (65.10) | B      |
    | nationaliteit (05.10)              | 0002   |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde |
    | bijzonder Nederlanderschap (65.10) | B      |
    | reden opname (63.10)               | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.<naam>          |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam   | waarde                  |
    | type   | BehandeldAlsNederlander |
    | <naam> | <waarde>                |

    Voorbeelden:
    | naam                     | waarde                                          |
    | redenOpname.code         | 001                                             |
    | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art.1, lid 1a |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' veld: '<gba naam>' met waarde '<waarde>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde   |
    | bijzonder Nederlanderschap (65.10) | B        |
    | <gba naam>                         | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                  |
    | type | BehandeldAlsNederlander |

    Voorbeelden:
    | gba naam             | naam             | waarde |
    | reden opname (63.10) | redenOpname.code | 000    |

  Abstract Scenario: persoon heeft 'behandeld als Nederlander' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde       |
    | bijzonder Nederlanderschap (65.10) | B            |
    | <gba naam>                         | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde                  |
    | type               | BehandeldAlsNederlander |
    | <naam>.type        | <type>                  |
    | <naam>.datum       | <waarde>                |
    | <naam>.langFormaat | <lang formaat>          |

    Voorbeelden:
    | gba naam                        | gba waarde | naam                  | type  | waarde     | lang formaat |
    | datum ingang geldigheid (85.10) | 20020701   | datumIngangGeldigheid | Datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: 'behandeld als Nederlander' velden van persoon is/zijn in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                               | waarde                    |
    | bijzonder Nederlanderschap (65.10) | B                         |
    | reden opname (63.10)               | 001                       |
    | aanduiding in onderzoek (83.10)    | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)     | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                                          |
    | type                                         | BehandeldAlsNederlander                         |
    | redenOpname.code                             | 001                                             |
    | redenOpname.omschrijving                     | Wet op het Nederlanderschap 1892, art.1, lid 1a |
    | inOnderzoek.type                             | <type in onderzoek>                             |
    | inOnderzoek.redenOpname                      | <reden opname in onderzoek>                     |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                     |

    Voorbeelden:
    | gba in onderzoek waarde | reden opname in onderzoek | type in onderzoek |
    | 040000                  | true                      | true              |
    | 040500                  |                           | true              |
    | 040510                  |                           | true              |
    | 046300                  | true                      |                   |
    | 046310                  | true                      |                   |
    | 046500                  |                           | true              |
    | 046510                  |                           | true              |
