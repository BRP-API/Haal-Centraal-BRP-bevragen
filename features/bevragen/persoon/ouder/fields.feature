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
