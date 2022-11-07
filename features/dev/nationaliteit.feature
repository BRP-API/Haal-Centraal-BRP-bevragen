# language: nl

Functionaliteit: Persoon: nationaliteit

  Scenario: persoon heeft een nationaliteit
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000012                          |
    | fields              | nationaliteiten.nationaliteit.code |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |

  Scenario: persoon heeft meerdere nationaliteiten
   Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0455   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000012                          |
    | fields              | nationaliteiten.nationaliteit.code |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0001          |
    En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |
    | nationaliteit.code | 0455          |

  Scenario: persoon heeft alleen een beëindigde nationaliteit
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    En de 'nationaliteit' is gewijzigd naar de volgende gegevens
    | naam                            | waarde |
    | reden beëindigen (64.10)        | 410    |
    | datum ingang geldigheid (85.10) | morgen |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                             |
    | type                | RaadpleegMetBurgerservicenummer    |
    | burgerservicenummer | 000000012                          |
    | fields              | nationaliteiten.nationaliteit.code |
    Dan heeft de response een persoon zonder 'nationaliteit' gegevens

  Abstract Scenario: persoon heeft 'nationaliteit' veld: 'reden opname (63.10)'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    | reden opname (63.10)  | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.<naam>          |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam   | waarde        |
    | type   | Nationaliteit |
    | <naam> | <waarde>      |

    Voorbeelden:
    | naam                     | waarde                                            |
    | redenOpname.code         | 001                                               |
    | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |

  Abstract Scenario: persoon heeft 'nationaliteit' veld: '<gba naam>' met waarde '<waarde>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde   |
    | nationaliteit (05.10) | 0001     |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.<naam>          |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde        |
    | type | Nationaliteit |

    Voorbeelden:
    | gba naam             | naam             | waarde |
    | reden opname (63.10) | redenOpname.code | 000    |

  Abstract Scenario: persoon heeft 'nationaliteit' datum veld: '<gba naam>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde       |
    | nationaliteit (05.10) | 0001         |
    | <gba naam>            | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.<naam>          |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde         |
    | type               | Nationaliteit  |
    | <naam>.type        | <type>         |
    | <naam>.datum       | <waarde>       |
    | <naam>.langFormaat | <lang formaat> |

    Voorbeelden:
    | gba naam                        | gba waarde | naam                  | type  | waarde     | lang formaat |
    | datum ingang geldigheid (85.10) | 20020701   | datumIngangGeldigheid | Datum | 2002-07-01 | 1 juli 2002  |

  Abstract Scenario: persoon's 'nationaliteit' velden is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde                    |
    | nationaliteit (05.10)           | 0001                      |
    | reden opname (63.10)            | 001                       |
    | aanduiding in onderzoek (83.10) | <gba in onderzoek waarde> |
    | datum ingang onderzoek (83.20)  | 20020701                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                                         | waarde                                            |
    | type                                         | Nationaliteit                                     |
    | nationaliteit.code                           | 0001                                              |
    | nationaliteit.omschrijving                   | Nederlandse                                       |
    | redenOpname.code                             | 001                                               |
    | redenOpname.omschrijving                     | Wet op het Nederlanderschap 1892, art. 1, onder a |
    | inOnderzoek.type                             | <type in onderzoek>                               |
    | inOnderzoek.nationaliteit                    | <nationaliteit in onderzoek>                      |
    | inOnderzoek.redenOpname                      | <reden opname in onderzoek>                       |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                                             |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2002-07-01                                        |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 juli 2002                                       |

    Voorbeelden:
    | gba in onderzoek waarde | nationaliteit in onderzoek | reden opname in onderzoek | type in onderzoek |
    | 040000                  | true                       | true                      | true              |
    | 040500                  | true                       |                           | true              |
    | 040510                  | true                       |                           | true              |
    | 046300                  |                            | true                      |                   |
    | 046310                  |                            | true                      |                   |
