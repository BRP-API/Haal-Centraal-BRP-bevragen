# language: nl

@post-assert
Functionaliteit: Ouder

  Abstract Scenario: overnemen veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<naam>                   |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam   | waarde   |
    | type   | Ouder    |
    | <naam> | <waarde> |

    Voorbeelden:
    | gba naam                    | naam                | waarde    |
    | burgerservicenummer         | burgerservicenummer | 123456789 |
    | geslachtsaanduiding (04.10) | geslacht.code       | M         |
    | ouderAanduiding             | ouderAanduiding     | 1         |

  Abstract Scenario: overnemen <gegevensgroep> veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde   |
    | <gba naam> | <waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<gegevensgroep>.<naam>   |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam | waarde |
    | type | Ouder  |
    En heeft de 'ouder' alleen de volgende '<gegevensgroep>' gegevens
    | naam   | waarde   |
    | <naam> | <waarde> |

    Voorbeelden:
    | gegevensgroep | gba naam                             | naam                                 | waarde                       |
    | naam          | voornamen (02.10)                    | voornamen                            | Jan                          |
    | naam          | voorvoegsel (02.30)                  | voorvoegsel                          | de                           |
    | naam          | geslachtsnaam (02.40)                | geslachtsnaam                        | Groen                        |
    | naam          | adellijke titel of predicaat (02.20) | adellijkeTitelPredicaat.code         | JH                           |
    | naam          | adellijkeTitelPredicaat.omschrijving | adellijkeTitelPredicaat.omschrijving | ridder                       |
    | geboorte      | geboorteplaats (03.20)               | plaats.code                          | 0518                         |
    | geboorte      | plaats.omschrijving                  | plaats.omschrijving                  | 's-Gravenhage                |
    | geboorte      | geboorteland (03.30)                 | land.code                            | 6014                         |
    | geboorte      | land.omschrijving                    | land.omschrijving                    | Verenigde Staten van Amerika |

  Abstract Scenario: omzetten datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<naam>                   |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam         | waarde   |
    | type         | Ouder    |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gba naam                                           | gba waarde | naam                                    | waarde     |
    | datum ingang familierechtelijke betrekking (62.10) | 20020701   | datumIngangFamilierechtelijkeBetrekking | 2002-07-01 |

  Abstract Scenario: omzetten <gegevensgroep> datum veld: <gba naam>
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft een 'ouder' met alleen de volgende '<gegevensgroep>' gegevens
    | naam       | waarde       |
    | <gba naam> | <gba waarde> |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 555550001                       |
    | fields              | ouders.<gegevensgroep>.<naam>   |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam | waarde |
    | type | Ouder  |
    En heeft de 'ouder' alleen de volgende '<gegevensgroep>' gegevens
    | naam         | waarde   |
    | <naam>.type  | Datum    |
    | <naam>.datum | <waarde> |

    Voorbeelden:
    | gegevensgroep | gba naam              | gba waarde | naam  | waarde     |
    | geboorte      | geboortedatum (03.10) | 20020701   | datum | 2002-07-01 |
