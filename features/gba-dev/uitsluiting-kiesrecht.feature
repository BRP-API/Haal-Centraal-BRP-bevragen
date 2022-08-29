# language: nl

Functionaliteit: Uitsluiting kiesrecht


	@gba
	Abstract Scenario: Geen aanduiding uitgesloten kiesrecht (38.10) wel een einddatum uitsluiting kiesrecht
	  Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
    En de persoon heeft de volgende kiesrecht gegevens
    | einddatum uitsluiting kiesrecht (38.20) | 20300101 |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | uitsluitingKiesrecht            |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'uitsluitingKiesrecht' gegevens
    | naam      | waarde   |
    | einddatum | 20300101 |
