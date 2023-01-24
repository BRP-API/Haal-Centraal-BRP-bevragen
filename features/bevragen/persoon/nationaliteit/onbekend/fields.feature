# language: nl

Functionaliteit: Persoon: nationaliteit - onbekende nationaliteit

  Abstract Scenario: 'reden opname (63.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0000   |
    | reden opname (63.10)  | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                     | waarde                                            |
    | type                     | NationaliteitOnbekend                             |
    | redenOpname.code         | 001                                               |
    | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |

    Voorbeelden:
    | fields                                   |
    | nationaliteiten.redenOpname              |
    | nationaliteiten.redenOpname.code         |
    | nationaliteiten.redenOpname.omschrijving |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0000     |
    | datum ingang geldigheid (85.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde                |
    | type                              | NationaliteitOnbekend |
    | datumIngangGeldigheid.type        | Datum                 |
    | datumIngangGeldigheid.datum       | 2002-07-01            |
    | datumIngangGeldigheid.langFormaat | 1 juli 2002           |

    Voorbeelden:
    | fields                                            |
    | nationaliteiten.datumIngangGeldigheid             |
    | nationaliteiten.datumIngangGeldigheid.type        |
    | nationaliteiten.datumIngangGeldigheid.datum       |
    | nationaliteiten.datumIngangGeldigheid.langFormaat |
