# language: nl

@gba
Functionaliteit: uitsluiting kiesrecht velden vragen met fields (persoon)

	Scenario: persoon heeft geen uitsluiting kiesrecht gegevens
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Janssen               |
		Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens

	Scenario: 'aanduiding uitgesloten kiesrecht (38.10)' heeft geen waarde
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | einddatum uitsluiting Europees kiesrecht (31.30) |
    | morgen                                           |
		Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens

  Scenario: einddatum uitsluiting kiesrecht (38.20) heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) |
    | A                                        |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000115                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

  Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'kiesrecht' gegevens
    | naam                                     | waarde   |
    | aanduiding uitgesloten kiesrecht (38.10) | A        |
    | einddatum uitsluiting kiesrecht (38.20)  | 20270101 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'uitsluitingKiesrecht' gegevens
    | naam      | waarde   |
    | einddatum | 20270101 |

    Voorbeelden:
    | fields                                     |
    | uitsluitingKiesrecht.einddatum             |
    | uitsluitingKiesrecht.einddatum.type        |
    | uitsluitingKiesrecht.einddatum.datum       |
    | uitsluitingKiesrecht.einddatum.langFormaat |
    | uitsluitingKiesrecht.einddatum.jaar        |
    | uitsluitingKiesrecht.einddatum.maand       |
    | uitsluitingKiesrecht.einddatum.onbekend    |

  Abstract Scenario: einddatum uitsluiting kiesrecht (38.20) is vandaag of ligt in het verleden
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | <einddatum uitsluiting>                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | einddatum uitsluiting |
    | vandaag               |
    | gisteren              |
    | vorige maand          |
    | vorig jaar            |

  Abstract Scenario: einddatum uitsluiting kiesrecht (38.20) ligt in de toekomst
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | <einddatum uitsluiting>                 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                         | waarde                  |
    | uitsluitingKiesrecht.uitgeslotenVanKiesrecht | true                    |
    | uitsluitingKiesrecht.einddatum               | <einddatum uitsluiting> |

    Voorbeelden:
    | einddatum uitsluiting |
    | morgen                |
    | deze maand            |
    | dit jaar              |
    | volgende maand        |
    | volgend jaar          |

  Scenario: einddatum uitsluiting kiesrecht (38.20) is onbekend
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | 00000000                                |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                         | waarde   |
    | uitsluitingKiesrecht.uitgeslotenVanKiesrecht | true     |
    | uitsluitingKiesrecht.einddatum               | 00000000 |
