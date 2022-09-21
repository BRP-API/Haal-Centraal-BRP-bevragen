# language: nl

@post-assert
Functionaliteit: Nationaliteit

  Scenario: persoon heeft een nationaliteit
  Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 001                   | 19750707                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | nationaliteiten   |
  Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
  | naam                       | waarde                                           |
  | nationaliteit.code         | 0001                                             |
  | nationaliteit.omschrijving | Nederlandse                                      |
  | redenopname.code           | 001                                              |
  | redenopname.omschrijving   | Wet op het Nederlanderschap 1892,art. 1, onder a |

  Scenario: persoon heeft meerdere nationaliteiten
  Gegeven de persoon met burgerservicenummer '000000024' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 001                   | 19750707                        |
  En de persoon heeft nog een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0455                  | 311                   | 19620107                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000024                       |
  | fields              | nationaliteiten                 |
  Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
  | naam                       | waarde        |
  | nationaliteit.code         | 0001          |
  | nationaliteit.omschrijving | Nederlandse   |
  | redenopname.code           | 001                                              |
  | redenopname.omschrijving   | Wet op het Nederlanderschap 1892,art. 1, onder a |
  En heeft de persoon een 'nationaliteit' met alleen de volgende gegevens
  | naam                       | waarde                                   |
  | nationaliteit.code         | 0301                                     |
  | nationaliteit.omschrijving | Surinaamse                               |
  | redenOpname.code           | 301                                      |
  | redenOpname.omschrijving   | Vaststelling bezit vreemde nationaliteit |

  Scenario: persoon heeft een nationaliteit met reden opname = onbekend
  Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
  | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
  | 0001                  | 000                   | 19750707                        |
  Als gba personen wordt gezocht met de volgende parameters
  | naam                | waarde                          |
  | type                | RaadpleegMetBurgerservicenummer |
  | burgerservicenummer | 000000012                       |
  | fields              | nationaliteiten   |
  Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
  | naam                       | waarde                                           |
  | nationaliteit.code         | 0001                                             |
  | nationaliteit.omschrijving | Nederlandse                                      |
  | redenopname.code           | 000                                              |
  | redenopname.omschrijving   | Onbekend                                         |





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
    | fields              | nationaliteiten.<naam>          |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam               | waarde        |
    | type               | Nationaliteit |

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
