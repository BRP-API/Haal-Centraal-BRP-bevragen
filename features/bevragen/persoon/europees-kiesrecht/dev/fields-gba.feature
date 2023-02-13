# language: nl

@gba
Functionaliteit: Europees kiesrecht velden vragen met fields

	Scenario: persoon heeft geen Europees kiesrecht gegevens
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Janssen               |
		Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

	Scenario: 'Europees kiesrecht (31.10)' heeft geen waarde
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | einddatum uitsluiting Europees kiesrecht (31.30) |
    | morgen                                           |
		Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

  Abstract Scenario: einddatum uitsluiting europees kiesrecht (31.30) heeft geen waarde
    Gegeven de persoon met burgerservicenummer '000000115' heeft de volgende 'kiesrecht' gegevens
    | europees kiesrecht (31.10) |
    | <Europees kiesrecht>       |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000115                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                    |
    | aanduiding.code         | <Europees kiesrecht>      |
    | aanduiding.omschrijving | <aanduiding.omschrijving> |

    Voorbeelden:
   | omschrijving                 | Europees kiesrecht | aanduiding.omschrijving |
   | uitgesloten zonder einddatum | 1                  | persoon is uitgesloten  |
   | persoon ontvangt oproep      | 2                  | persoon ontvangt oproep |

  Abstract Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' wordt gevraagd met field pad '<fields>'
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'kiesrecht' gegevens
    | naam                                             | waarde   |
    | Europees kiesrecht (31.10)                       | 1        |
    | einddatum uitsluiting Europees kiesrecht (31.30) | 20270101 |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met alleen de volgende 'europeesKiesrecht' gegevens
    | naam                 | waarde   |
    | einddatumUitsluiting | 20270101 |

    Voorbeelden:
    | fields                                             |
    | europeesKiesrecht.einddatumUitsluiting             |
    | europeesKiesrecht.einddatumUitsluiting.type        |
    | europeesKiesrecht.einddatumUitsluiting.datum       |
    | europeesKiesrecht.einddatumUitsluiting.langFormaat |
    | europeesKiesrecht.einddatumUitsluiting.jaar        |
    | europeesKiesrecht.einddatumUitsluiting.maand       |
    | europeesKiesrecht.einddatumUitsluiting.onbekend    |

  Abstract Scenario: einddatum uitsluiting europees kiesrecht (31.30) is vandaag of ligt in het verleden
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | europees kiesrecht (31.10) | einddatum uitsluiting europees kiesrecht (31.30) |
    | 1                          | <einddatum uitsluiting>                          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | einddatum uitsluiting |
    | vandaag               |
    | gisteren              |
    | vorige maand          |
    | vorig jaar            |

  Abstract Scenario: einddatum uitsluiting europees kiesrecht (31.30) ligt in de toekomst
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | europees kiesrecht (31.10) | einddatum uitsluiting europees kiesrecht (31.30) |
    | 1                          | <einddatum uitsluiting>                          |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                      | waarde                  |
    | europeesKiesrecht.aanduiding.code         | 1                       |
    | europeesKiesrecht.aanduiding.omschrijving | persoon is uitgesloten  |
    | europeesKiesrecht.einddatumUitsluiting    | <einddatum uitsluiting> |

    Voorbeelden:
    | einddatum uitsluiting |
    | morgen                |
    | deze maand            |
    | dit jaar              |
    | volgende maand        |
    | volgend jaar          |

  Scenario: einddatum uitsluiting europees kiesrecht (31.30) is onbekend
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | europees kiesrecht (31.10) | einddatum uitsluiting europees kiesrecht (31.30) |
    | 1                          | 00000000                                         |
    Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                                      | waarde                 |
    | europeesKiesrecht.aanduiding.code         | 1                      |
    | europeesKiesrecht.aanduiding.omschrijving | persoon is uitgesloten |
    | europeesKiesrecht.einddatumUitsluiting    | 00000000               |
