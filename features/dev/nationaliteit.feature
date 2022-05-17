# language: nl

@post-assert
Functionaliteit: Nationaliteit

  Scenario: persoon heeft een nationaliteit
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |

  Scenario: persoon heeft meerdere nationaliteiten
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0455   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0455          |

  Abstract Scenario: persoon heeft 'nationaliteit' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde   |
    | nationaliteit (05.10) | 0001     |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |
    | <naam>             | <waarde>      |

    Voorbeelden:
    | gba naam                 | naam                     | waarde           |
    | reden opname (63.10)     | redenOpname.code         | 1234             |
    | redenOpname.omschrijving | redenOpname.omschrijving | een omschrijving |

  Abstract Scenario: persoon heeft 'nationaliteit' veld: '<gba naam>' met waarde '<waarde>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde   |
    | nationaliteit (05.10) | 0001     |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |

    Voorbeelden:
    | gba naam             | naam             | waarde |
    | reden opname (63.10) | redenOpname.code | 000    |

  Abstract Scenario: persoon heeft 'nationaliteit' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde       |
    | nationaliteit (05.10) | 0001         |
    | <gba naam>            | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde         |
    | type               | Nationaliteit  |
    | nationaliteit.code | 0001           |
    | <naam>.type        | <type>         |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                        | gba waarde | naam                  | type  | waarde     | lang formaat |
    | datum ingang geldigheid (85.10) | 20020701   | datumIngangGeldigheid | Datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: persoon's 'nationaliteit' velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                                     | waarde                    |
    | nationaliteit (05.10)                    | 0001                      |
    | reden opname (63.10)                     | 001                       |
    | aanduiding gegevens in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)           | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                       |
    | type                                         | Nationaliteit                |
    | nationaliteit.code                           | 0001                         |
    | redenOpname.code                             | 001                          |
    | inOnderzoek.type                             | <type in onderzoek>          |
    | inOnderzoek.nationaliteit                    | <nationaliteit in onderzoek> |
    | inOnderzoek.redenOpname                      | <reden opname in onderzoek>  |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                  |

    Voorbeelden:
    | gba in onderzoek waarde | nationaliteit in onderzoek | reden opname in onderzoek | type in onderzoek |
    | 040000                  | true                       | true                      | true              |
    | 040500                  | true                       |                           | true              |
    | 040510                  | true                       |                           | true              |
    | 046300                  |                            | true                      |                   |
    | 046310                  |                            | true                      |                   |
