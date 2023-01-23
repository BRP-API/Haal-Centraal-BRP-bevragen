#language: nl

Functionaliteit: Persoon: ouder geboorte velden vragen met fields

  Abstract Scenario: 'geboortedatum (03.10)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde   |
    | geboortedatum (03.10) | 20020701 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende 'geboorte' gegevens
    | naam              | waarde      |
    | datum.type        | Datum       |
    | datum.datum       | 2002-07-01  |
    | datum.langFormaat | 1 juli 2002 |

    Voorbeelden:
    | fields                            |
    | ouders.geboorte.datum             |
    | ouders.geboorte.datum.type        |
    | ouders.geboorte.datum.datum       |
    | ouders.geboorte.datum.langFormaat |
    | ouders.geboorte.datum.jaar        |
    | ouders.geboorte.datum.maand       |
    | ouders.geboorte.datum.onbekend    |

  Abstract Scenario: 'geboorteplaats (03.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                   | waarde |
    | geboorteplaats (03.20) | 0518   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding,<fields> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de 'ouder' de volgende 'geboorte' gegevens
    | naam                | waarde        |
    | plaats.code         | 0518          |
    | plaats.omschrijving | 's-Gravenhage |

    Voorbeelden:
    | fields                              |
    | ouders.geboorte.plaats              |
    | ouders.geboorte.plaats.code         |
    | ouders.geboorte.plaats.omschrijving |

  Abstract Scenario: 'geboorteland (03.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '2' met de volgende gegevens
    | naam                 | waarde |
    | geboorteland (03.30) | 6014   |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000012                       |
    | fields              | ouders.ouderAanduiding,<fields> |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 2      |
    En heeft de 'ouder' de volgende 'geboorte' gegevens
    | naam              | waarde                       |
    | land.code         | 6014                         |
    | land.omschrijving | Verenigde Staten van Amerika |

    Voorbeelden:
    | fields                            |
    | ouders.geboorte.land              |
    | ouders.geboorte.land.code         |
    | ouders.geboorte.land.omschrijving |
