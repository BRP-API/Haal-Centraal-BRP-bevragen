# language: nl

Functionaliteit: Persoon: ouder velden vragen met fields

  Abstract Scenario: 'burgerservicenummer (01.20)' wordt gevraagd met field pad 'ouders.burgerservicenummer'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                        | waarde   |
    | burgerservicenummer (01.20) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.burgerservicenummer      |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                | waarde   |
    | burgerservicenummer | <waarde> |

    Voorbeelden:
    | ouder aanduiding | waarde    |
    | 1                | 000000013 |
    | 2                | 000000014 |

  Abstract Scenario: 'geslachtsaanduiding (04.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                        | waarde |
    | geslachtsaanduiding (04.10) | M      |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                  | waarde |
    | geslacht.code         | M      |
    | geslacht.omschrijving | man    |

    Voorbeelden:
    | ouder aanduiding | fields                       |
    | 1                | ouders.geslacht              |
    | 1                | ouders.geslacht.code         |
    | 2                | ouders.geslacht.omschrijving |

  Abstract Scenario: 'ouder aanduiding' wordt gevraagd met field pad 'ouders.ouderAanduiding'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder aanduiding>' met de volgende gegevens
    | naam                        | waarde   |
    | burgerservicenummer (01.20) | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding          |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde             |
    | ouderAanduiding | <ouder aanduiding> |

    Voorbeelden:
    | ouder aanduiding | waarde    |
    | 1                | 000000013 |
    | 2                | 000000014 |

  Abstract Scenario: 'datum ingang familierechtelijke betrekking (62.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                                               | waarde   |
    | datum ingang familierechtelijke betrekking (62.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam                                                | waarde      |
    | datumIngangFamilierechtelijkeBetrekking.type        | Datum       |
    | datumIngangFamilierechtelijkeBetrekking.datum       | 2002-07-01  |
    | datumIngangFamilierechtelijkeBetrekking.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                                                     |
    | ouders.datumIngangFamilierechtelijkeBetrekking             |
    | ouders.datumIngangFamilierechtelijkeBetrekking.type        |
    | ouders.datumIngangFamilierechtelijkeBetrekking.datum       |
    | ouders.datumIngangFamilierechtelijkeBetrekking.langFormaat |
    | ouders.datumIngangFamilierechtelijkeBetrekking.jaar        |
    | ouders.datumIngangFamilierechtelijkeBetrekking.maand       |
    | ouders.datumIngangFamilierechtelijkeBetrekking.onbekend    |

  Abstract Scenario: 'datum ingang familierechtelijke betrekking (62.10)' van het type '<type>' wordt gevraagd met field pad 'ouders.datumIngangFamilierechtelijkeBetrekking'
    Gegeven de persoon met burgerservicenummer '000000218' heeft een ouder '1' met de volgende gegevens
      | naam                                               | waarde     |
      | datum ingang familierechtelijke betrekking (62.10) | <GbaDatum> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                         |
      | type                | RaadpleegMetBurgerservicenummer                |
      | burgerservicenummer | 000000218                                      |
      | fields              | ouders.datumIngangFamilierechtelijkeBetrekking |
      Dan heeft de response een persoon met een 'ouder' met de volgende gegevens
      | naam                                                | waarde        |
      | datumIngangFamilierechtelijkeBetrekking.type        | <type>        |
      | datumIngangFamilierechtelijkeBetrekking.datum       | <datum>       |
      | datumIngangFamilierechtelijkeBetrekking.jaar        | <jaar>        |
      | datumIngangFamilierechtelijkeBetrekking.maand       | <maand>       |
      | datumIngangFamilierechtelijkeBetrekking.onbekend    | <onbekend>    |
      | datumIngangFamilierechtelijkeBetrekking.langFormaat | <langFormaat> |

      Voorbeelden:
      | type           | GbaDatum | datum      | jaar | maand | onbekend | langFormaat  |
      | Datum          | 20200308 | 2020-03-08 |      |       |          | 8 maart 2020 |
      | DatumOnbekend  | 00000000 |            |      |       | true     | onbekend     |
      | JaarDatum      | 20200000 |            | 2020 |       |          | 2020         |
      | JaarMaandDatum | 20200300 |            | 2020 | 3     |          | maart 2020   |
