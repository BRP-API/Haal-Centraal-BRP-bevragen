# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, dan wordt die uitsluiting niet opgenomen in de API.

	Scenario: Geen aanduiding uitgesloten kiesrecht (38.10) en geen einddatum uitsluiting kiesrecht
		Gegeven de persoon met burgerservicenummer '000000103' heeft de volgende gegevens
		| geslachtsnaam (02.40) |
		| Janssen               |
		Als gba personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000103                       |
		| fields              | uitsluitingKiesrecht            |
		Dan heeft de response een persoon zonder gegevens

Rule: 	Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als de einddatum ontbreekt
	- waarde "A" wordt geleverd als boolean waarde true

	Scenario: 	Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als de einddatum ontbreekt
	#   Functioneel zou dit moeten zijn :
	#   Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'kiesrecht' gegevens
	#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
	#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
		Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'inschrijving' gegevens
		| aanduiding uitgesloten kiesrecht (38.10) |
		| A                                        |
		Als personen wordt gezocht met de volgende parameters
		| naam                    | waarde                          |
		| type                    | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer     | 000000139                       |
		| fields                  | uitsluitingKiesrecht            |
		Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
		| naam                    | waarde |
		| uitgeslotenVanKiesrecht | true   |

Rule: Uitsluiting van kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en uitsluiting kiesrecht wel, wordt uitsluiting kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.


	Abstract Scenario: kiesrecht <omschrijving>
	#   Functioneel zou dit moeten zijn :
	#   Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'kiesrecht' gegevens
	#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
	#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
			Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
			| aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
			| <uitsluiting kiesrecht>                  | <einddatum uitsluiting>                 |
			Als personen wordt gezocht met de volgende parameters
			| naam                | waarde                                   |
			| type                | RaadpleegMetBurgerservicenummer          |
			| burgerservicenummer | 000000140                                |
			| fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht,uitsluitingKiesrecht.einddatum |
			Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
			| naam                             | waarde                    |
			| uitgeslotenVanKiesrecht          | <uitgeslotenVanKiesrecht> |
			| einddatum.type                   | JaarDatum                 |
			| einddatum.jaar                   | <einddatum uitsluiting>   |
			| einddatum.langFormaat            | <einddatum uitsluiting>   |

			Voorbeelden:
			| omschrijving                             | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | einddatum    | einddatumtype  |
			| einddatum uitsluiting jaar in toekomst   | A                     | volgend jaar          | true                    | volgend jaar | JaarDatum      |
			| einddatum uitsluiting dit jaar           | A                     | dit jaar              | true                    | dit jaar     | JaarDatum      |

	Abstract Scenario: kiesrecht einddatum uitsluiting in de toekomst
	#   Functioneel zou dit moeten zijn :
	#   Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'kiesrecht' gegevens
	#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
	#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
			Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
			| aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
			| A                                        | 20270101                                |
			Als personen wordt gezocht met de volgende parameters
			| naam                | waarde                                   |
			| type                | RaadpleegMetBurgerservicenummer          |
			| burgerservicenummer | 000000140                                |
			| fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht,uitsluitingKiesrecht.einddatum |
			Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
			| naam                       | waarde                    |
			| uitgeslotenVanKiesrecht    | true                      |
			| einddatum.type             | Datum                     |
			| einddatum.datum            | 2027-01-01                |
			| einddatum.langFormaat      | 1 januari 2027            |

		Abstract Scenario: kiesrecht einddatum onbekend
		#   Functioneel zou dit moeten zijn :
		#   Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'kiesrecht' gegevens
		#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
		#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
				Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
				| aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
				| A                                        | 00000000                                |
				Als personen wordt gezocht met de volgende parameters
				| naam                | waarde                                   |
				| type                | RaadpleegMetBurgerservicenummer          |
				| burgerservicenummer | 000000140                                |
				| fields              | uitsluitingKiesrecht.uitgeslotenVanKiesrecht,uitsluitingKiesrecht.einddatum |
				Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
				| naam                       | waarde                    |
				| uitgeslotenVanKiesrecht    | true                      |
				| einddatum.type             | DatumOnbekend             |
				| einddatum.onbekend         | true                      |
				| einddatum.langFormaat      | onbekend                  |

		Abstract Scenario: kiesrecht <omschrijving>
		#   Functioneel zou dit moeten zijn :
		#   Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'kiesrecht' gegevens
		#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
		#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
				Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
				| aanduiding uitgesloten kiesrecht (38.10) | einddatum uitsluiting kiesrecht (38.20) |
				| <uitsluiting kiesrecht>                  | <einddatum uitsluiting>                 |
				Als personen wordt gezocht met de volgende parameters
				| naam                | waarde                                   |
				| type                | RaadpleegMetBurgerservicenummer          |
				| burgerservicenummer | 000000140                                |
				| fields              | uitsluitingKiesrecht                     |
				Dan heeft de response een persoon zonder gegevens

				Voorbeelden:
				| omschrijving                             | uitsluiting kiesrecht | einddatum uitsluiting |
				| einddatum uitsluiting in verleden        | A                     | gisteren              |
				| einddatum uitsluiting vandaag            | A                     | vandaag               |
				| einddatum uitsluiting vorige maand       | A                     | vorige maand          |
				| einddatum uitsluiting vorig jaar         | A                     | vorig jaar            |

		Scenario: kiesrecht zonder aanduiding, maar met einddatum uitsluiting wordt niet geleverd.
		#   Functioneel zou dit moeten zijn :
		#   Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'kiesrecht' gegevens
		#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
		#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.
				Gegeven de persoon met burgerservicenummer '000000140' heeft de volgende 'inschrijving' gegevens
				| einddatum uitsluiting kiesrecht (38.20) |
				| morgen                                  |
				Als personen wordt gezocht met de volgende parameters
				| naam                | waarde                                   |
				| type                | RaadpleegMetBurgerservicenummer          |
				| burgerservicenummer | 000000140                                |
				| fields              | uitsluitingKiesrecht                     |
				Dan heeft de response een persoon zonder gegevens
