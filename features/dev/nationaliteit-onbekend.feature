# language: nl

@post-assert
Functionaliteit: onbekende nationaliteit

  Scenario: persoon heeft 'onbekende nationaliteit'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0000   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                |
    | type | NationaliteitOnbekend |

  Abstract Scenario: persoon heeft 'onbekende nationaliteit' veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde   |
    | nationaliteit (05.10) | 0000     |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam   | waarde                |
    | type   | NationaliteitOnbekend |
    | <naam> | <waarde>              |

    Voorbeelden:
    | gba naam                 | naam                     | waarde           |
    | reden opname (63.10)     | redenOpname.code         | 1234             |
    | redenOpname.omschrijving | redenOpname.omschrijving | een omschrijving |

  Abstract Scenario: persoon heeft 'onbekende nationaliteit' veld: '<gba naam>' met waarde '<waarde>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde   |
    | nationaliteit (05.10) | 0000     |
    | <gba naam>            | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde                |
    | type | NationaliteitOnbekend |

    Voorbeelden:
    | gba naam             | naam             | waarde |
    | reden opname (63.10) | redenOpname.code | 000    |

  Abstract Scenario: persoon heeft 'onbekende nationaliteit' datum veld: '<gba naam>'
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde       |
    | nationaliteit (05.10) | 0000         |
    | <gba naam>            | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | nationaliteiten                 |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam         | waarde                |
    | type         | NationaliteitOnbekend |
    | <naam>.type  | <type>                |
    | <naam>.datum | <waarde>              |

    Voorbeelden:
    | gba naam                        | gba waarde | naam                  | type  | waarde     |
    | ingangsdatum geldigheid (85.10) | 20020701   | datumIngangGeldigheid | Datum | 2002-07-01 |

  Abstract Scenario: persoon's 'onbekende nationaliteit' velden is in onderzoek
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'nationaliteit' met de volgende gegevens
    | naam                                     | waarde                    |
    | nationaliteit (05.10)                    | 0000                      |
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
    | type                                   | NationaliteitOnbekend       |
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
