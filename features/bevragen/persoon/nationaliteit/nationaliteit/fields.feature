# language: nl

Functionaliteit: Persoon: nationaliteit velden vragen met fields

  Abstract Scenario: 'nationaliteit (05.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    | reden opname (63.10)  | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                       | waarde        |
    | type                       | Nationaliteit |
    | nationaliteit.code         | 0001          |
    | nationaliteit.omschrijving | Nederlandse   |

    Voorbeelden:
    | fields                                     |
    | nationaliteiten.nationaliteit              |
    | nationaliteiten.nationaliteit.code         |
    | nationaliteiten.nationaliteit.omschrijving |

  Abstract Scenario: 'reden opname (63.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    | reden opname (63.10)  | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                     | waarde                                            |
    | type                     | Nationaliteit                                     |
    | redenOpname.code         | 001                                               |
    | redenOpname.omschrijving | Wet op het Nederlanderschap 1892, art. 1, onder a |

    Voorbeelden:
    | fields                                   |
    | nationaliteiten.redenOpname              |
    | nationaliteiten.redenOpname.code         |
    | nationaliteiten.redenOpname.omschrijving |

  Abstract Scenario: 'reden opname (63.10)' met standaardwaarde wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    | reden opname (63.10)  | 000    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde        |
    | type | Nationaliteit |

    Voorbeelden:
    | fields                      |
    | nationaliteiten.redenOpname |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde   |
    | nationaliteit (05.10)           | 0001     |
    | datum ingang geldigheid (85.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam                              | waarde        |
    | type                              | Nationaliteit |
    | datumIngangGeldigheid.type        | Datum         |
    | datumIngangGeldigheid.datum       | 2002-07-01    |
    | datumIngangGeldigheid.langFormaat | 1 juli 2002   |

    Voorbeelden:
    | fields                                            |
    | nationaliteiten.datumIngangGeldigheid             |
    | nationaliteiten.datumIngangGeldigheid.type        |
    | nationaliteiten.datumIngangGeldigheid.datum       |
    | nationaliteiten.datumIngangGeldigheid.langFormaat |
    | nationaliteiten.datumIngangGeldigheid.jaar        |
    | nationaliteiten.datumIngangGeldigheid.maand       |
    | nationaliteiten.datumIngangGeldigheid.onbekend    |

  Abstract Scenario: 'datum ingang geldigheid (85.10)' van het type '<type>' wordt gevraagd met field pad 'nationaliteiten.datumIngangGeldigheid'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                            | waarde     |
    | nationaliteit (05.10)           | 0001       |
    | datum ingang geldigheid (85.10) | <GbaDatum> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                |
    | type                | RaadpleegMetBurgerservicenummer       |
    | burgerservicenummer | 000000012                             |
    | fields              | nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response een persoon met een 'nationaliteit' met de volgende gegevens
    | naam                              | waarde        |
    | type                              | Nationaliteit |
    | datumIngangGeldigheid.type        | <type>        |
    | datumIngangGeldigheid.datum       | <datum>       |
    | datumIngangGeldigheid.jaar        | <jaar>        |
    | datumIngangGeldigheid.maand       | <maand>       |
    | datumIngangGeldigheid.onbekend    | <onbekend>    |
    | datumIngangGeldigheid.langFormaat | <langFormaat> |

    Voorbeelden:
    | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
    | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
    | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
    | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
    | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |

  Scenario: alleen field pad 'type' wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'nationaliteit' met de volgende gegevens
    | naam                  | waarde |
    | nationaliteit (05.10) | 0001   |
    | reden opname (63.10)  | 001    |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | nationaliteiten.type            |
    Dan heeft de response een persoon met een 'nationaliteit' met alleen de volgende gegevens
    | naam | waarde        |
    | type | Nationaliteit |
