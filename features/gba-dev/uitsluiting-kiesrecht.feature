# language: nl

Functionaliteit: Uitsluiting kiesrecht


	@gba
	Abstract Scenario: Geen aanduiding uitgesloten kiesrecht (38.10) wel een einddatum uitsluiting kiesrecht
	  Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 000000085  |
    En de persoon heeft de volgende kiesrecht gegevens
		| naam                                    | waarde   |
		| einddatum uitsluiting kiesrecht (38.20) | 20300101 |
		Als personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000085                       |
		| fields              | uitsluitingKiesrecht            |
		Dan bevat de persoon met burgerservicenummer '000000085' de volgende 'uitsluitingKiesrecht' gegevens
    | naam      | waarde   |
    | einddatum | 20300101 |
