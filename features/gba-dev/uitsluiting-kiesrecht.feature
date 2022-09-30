# language: nl

Functionaliteit: Uitsluiting kiesrecht


	@gba
	Scenario: Geen aanduiding uitgesloten kiesrecht (38.10) wel een einddatum uitsluiting kiesrecht
#   Functioneel zou dit moeten zijn :
#   Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende 'kiesrecht' gegevens
#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.

	  Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende 'inschrijving' gegevens
		| einddatum uitsluiting kiesrecht (38.20) |
		| 20300101                                |
		Als gba personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000103                       |
		| fields              | uitsluitingKiesrecht            |
		Dan heeft de response een persoon met een 'uitsluitingKiesrecht' met de volgende gegevens
    | naam      | waarde   |
    | einddatum | 20300101 |
