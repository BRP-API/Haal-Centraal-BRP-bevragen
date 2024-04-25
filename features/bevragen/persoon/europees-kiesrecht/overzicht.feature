# language: nl

Functionaliteit: Europees kiesrecht

Regel: Europees kiesrecht gegevens wordt geleverd als 'einddatum uitsluiting Europees kiesrecht (31.30)' geen waarde heeft

  Scenario: persoon is uitgesloten van Europees kiesrecht zonder einddatum uitsluiting
		Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) |
    | 1                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | europeesKiesrecht               |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

  Scenario: persoon is niet uitgesloten en ontvangt oproep
		Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) |
    | 2                          |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | europeesKiesrecht               |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                  |
    | aanduiding.code         | 2                       |
    | aanduiding.omschrijving | persoon ontvangt oproep |

Regel: Europees kiesrecht gegevens wordt geleverd als 'einddatum uitsluiting Europees kiesrecht (31.30)' in de toekomst ligt

	Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' ligt in de toekomst
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 1                          | morgen                                           |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht.aanduiding    |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

	Abstract Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' is vandaag of een datum in het verleden
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 1                          | <einddatum uitsluiting>                          |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | einddatum uitsluiting |
    | vandaag               |
    | gisteren              |
    | vandaag - 1 jaar      |
    | vorige maand          |
    | vorig jaar            |

Regel: Bij een 'einddatum uitsluiting Europees kiesrecht (31.30)' waarvan alleen het jaar bekend is, wordt Europees kiesrecht gegevens geleverd als het jaar gelijk is aan het huidig jaar of als het jaar in de toekomst ligt

	Abstract Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' is <einddatum uitsluiting>
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 1                          | <einddatum uitsluiting>                          |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht.aanduiding    |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

    Voorbeelden:
    | einddatum uitsluiting |
    | dit jaar              |
    | volgend jaar          |

Regel: Bij een 'einddatum uitsluiting Europees kiesrecht (31.30)' waarvan de dag niet bekend is, wordt uitsluiting kiesrecht gegevens geleverd als het jaar en maand gelijk is aan de huidige maand of een maand in de toekomst

	Abstract Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' is <einddatum uitsluiting>
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 1                          | <einddatum uitsluiting>                          |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht.aanduiding    |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

    Voorbeelden:
    | einddatum uitsluiting |
    | deze maand            |
    | volgende maand        |

Regel: Europees kiesrecht gegevens wordt geleverd bij een onbekend 'einddatum uitsluiting Europees kiesrecht (31.30)'

	Scenario: 'einddatum uitsluiting Europees kiesrecht (31.30)' is onbekend
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
    | 1                          | 00000000                                         |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht.aanduiding    |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
    | naam                    | waarde                 |
    | aanduiding.code         | 1                      |
    | aanduiding.omschrijving | persoon is uitgesloten |

Regel: Europees kiesrecht gegevens wordt niet geleverd wanneer 'Europees kiesrecht (31.10)' geen waarde heeft

	Scenario: 'Europees kiesrecht (31.10)' heeft geen waarde
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | einddatum uitsluiting Europees kiesrecht (31.30) |
    | morgen                                           |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens

	Scenario: persoon heeft geen Europees kiesrecht gegevens
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Janssen               |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | europeesKiesrecht               |
    Dan heeft de response een persoon zonder gegevens
