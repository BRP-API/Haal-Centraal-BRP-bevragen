# language: nl

Functionaliteit: GBA persoon: uitsluiting kiesrecht

	Abstract Scenario: Geen aanduiding uitgesloten kiesrecht (38.10) wel een einddatum uitsluiting kiesrecht
    Gegeven de persoon met burgerservicenummer '00000005' heeft de volgende 'inschrijving' gegevens
    | naam                                    | waarde   |
    | einddatum uitsluiting kiesrecht (38.20) | 20300101 |
		Als gba personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000085                       |
    | fields              | uitsluitingKiesrecht            |
		Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam      | waarde   |
    | einddatum | 20300101 |
