# language: nl

Functionaliteit: Kiesrecht

Regel: uitsluiting kiesrecht gegevens wordt geleverd als 'einddatum uitsluiting kiesrecht (38.20)' geen waarde heeft

  Scenario: persoon is uitgesloten van kiesrecht zonder einddatum uitsluiting
		Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) |
    | A                                        |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | uitsluitingKiesrecht            |
		Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

Regel: uitsluiting kiesrecht gegevens wordt geleverd als 'einddatum uitsluiting kiesrecht (38.20)' in de toekomst ligt

  Scenario: 'einddatum uitsluiting kiesrecht (38.20)' ligt in de toekomst
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | morgen                                  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000127                                    |
    | fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

  Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' is vandaag of een datum in het verleden
    Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | <einddatum uitsluiting>                 |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000127                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens

    Voorbeelden:
    | einddatum uitsluiting |
    | vandaag               |
    | gisteren              |
    | vandaag - 1 jaar      |
    | vorige maand          |
    | vorig jaar            |

Regel: Bij een 'einddatum uitsluiting kiesrecht (38.20)' waarvan alleen het jaar bekend is, wordt uitsluiting kiesrecht gegevens geleverd als het jaar gelijk is aan het huidig jaar of als het jaar in de toekomst ligt

	Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' is <einddatum uitsluiting>
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | <einddatum uitsluiting>                 |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

    Voorbeelden:
    | einddatum uitsluiting |
    | dit jaar              |
    | volgend jaar          |

Regel: Bij een 'einddatum uitsluiting kiesrecht (38.20)' waarvan de dag niet bekend is, wordt uitsluiting kiesrecht gegevens geleverd als het jaar en maand gelijk is aan de huidige maand of een maand in de toekomst

	Abstract Scenario: 'einddatum uitsluiting kiesrecht (38.20)' is <einddatum uitsluiting>
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | <einddatum uitsluiting>                 |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

    Voorbeelden:
    | einddatum uitsluiting |
    | deze maand            |
    | volgende maand        |

Regel: uitsluiting kiesrecht gegevens wordt geleverd bij een onbekend 'einddatum uitsluiting kiesrecht (38.20)'

	Scenario: 'einddatum uitsluiting kiesrecht (38.20)' is onbekend
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
    | A                                        | 00000000                                |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                       |
    | type                | RaadpleegMetBurgerservicenummer              |
    | burgerservicenummer | 000000164                                    |
    | fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht |
    Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde |
    | uitgeslotenVanKiesrecht | true   |

Regel: uitsluiting kiesrecht gegevens wordt niet geleverd wanneer 'aanduiding uitgesloten kiesrecht (38.10)' geen waarde heeft

	Scenario: 'aanduiding uitgesloten kiesrecht (38.10)' heeft geen waarde
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende 'kiesrecht' gegevens
    | einddatum uitsluiting kiesrecht (38.20) |
    | morgen                                  |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens

	Scenario: persoon heeft geen uitsluiting kiesrecht gegevens
		Gegeven de persoon met burgerservicenummer '000000164' heeft de volgende gegevens
    | geslachtsnaam (02.40) |
    | Janssen               |
		Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000164                       |
    | fields              | uitsluitingKiesrecht            |
    Dan heeft de response een persoon zonder gegevens
