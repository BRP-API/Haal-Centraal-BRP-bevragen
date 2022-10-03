# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, dan wordt die uitsluiting niet opgenomen in de API.


Rule: 	Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als de einddatum ontbreekt
	- waarde "A" wordt geleverd als boolean waarde true

	Scenario: 	Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als de einddatum ontbreekt
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

Rule: Uitsluiting van Europees kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en Europees kiesrecht wel, wordt Europees kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.

	Abstract Scenario: Europees kiesrecht <omschrijving>
		Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'inschrijving' gegevens
		| Europees kiesrecht (31.10) |
		| <Europees kiesrecht>       |
		Als personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000164                       |
		| fields              | europeesKiesrecht               |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
		| naam                             | waarde                    |
		| aanduiding.code                  | <aanduiding.code>         |
		| aanduiding.omschrijving          | <aanduiding.omschrijving> |

		Voorbeelden:
  | omschrijving                       | Europees kiesrecht | aanduiding.code | aanduiding.omschrijving |
  | uitgesloten zonder einddatum       | 1                  | 1               | persoon is uitgesloten  |
  | persoon ontvangt oproep            | 2                  | 2               | persoon ontvangt oproep |

	Abstract Scenario: Europees kiesrecht <omschrijving>
		Gegeven de persoon met burgerservicenummer '000000127' heeft de volgende 'inschrijving' gegevens
		| Europees kiesrecht (31.10) | einddatum uitsluiting Europees kiesrecht (31.30) |
		| <Europees kiesrecht>       | <einddatum uitsluiting>                          |
		Als personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000164                       |
		| fields              | europeesKiesrecht               |
		Dan heeft de response een persoon met de volgende 'europeesKiesrecht' gegevens
		| naam                             | waarde                    |
		| aanduiding.code                  | <aanduiding.code          |
		| aanduiding.omschrijving          | <aanduiding.omschrijving> |
		| einddatumUitsluiting             | <einddatumUitsluiting>    |

		Voorbeelden:
  | omschrijving                       | Europees kiesrecht | einddatum uitsluiting | aanduiding.code | aanduiding.omschrijving | einddatumUitsluiting |
  | uitgesloten zonder einddatum       | 1                  |                       | 1               | persoon is uitgesloten  |                      |
  | einddatum uitsluiting in toekomst  | 1                  | volgend jaar          | 1               | persoon is uitgesloten  | volgend jaar         |
  | einddatum uitsluiting in verleden  | 1                  | gisteren              |                 |                         |                      |
  | einddatum uitsluiting vandaag      | 1                  | vandaag               |                 |                         |                      |
  | einddatum uitsluiting morgen       | 1                  | morgen                | 1               | persoon is uitgesloten  | 20300316             |
  | einddatum uitsluiting vorige maand | 1                  | vorige maand          |                 |                         |                      |
  | einddatum uitsluiting deze maand   | 1                  | deze maand            | 1               | persoon is uitgesloten  | 20220300             |
  | einddatum uitsluiting vorig jaar   | 1                  | vorig jaar            |                 |                         |                      |
  | einddatum uitsluiting dit jaar     | 1                  | dit jaar              | 1               | persoon is uitgesloten  | 20220000             |
  | einddatum uitsluiting onbekend     | 1                  | 00000000              | 1               | persoon is uitgesloten  | 00000000             |
  | persoon ontvangt oproep            | 2                  |                       | 2               | persoon ontvangt oproep |                      |

Rule: Uitsluiting van kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en uitsluiting kiesrecht wel, wordt uitsluiting kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.
	- Als er wel een einddatum uitsluiting in de toekomst aanwezig is, maar geen uitsluiting wordt verondersteld dat er wel uitsluiting is.

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
			| fields              | burgerservicenummer,uitsluitingKiesrecht |
			Dan heeft de response een persoon met de volgende  'uitsluitingKiesrecht' gegevens
			|naam                 | waarde    |
			| burgerservicenummer | 000000140 |
			| uitgeslotenVanKiesrecht | <uitgeslotenVanKiesrecht> |
			| einddatum.type          | <einddatumtype>           |

		Voorbeelden:
			| omschrijving                             | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | einddatum    | einddatumtype |
			| einddatum in toekomst zonder uitsluiting |                       | volgend jaar          | true                    | volgend jaar | JaarDatum      |
			| einddatum uitsluiting in toekomst        | A                     | volgend jaar          | true                    | volgend jaar | JaarDatum      |
			| einddatum uitsluiting in verleden        | A                     | vorig jaar            |                         |              |                |
			| einddatum uitsluiting vandaag            | A                     | vandaag               |                         |              |                |
			| einddatum uitsluiting morgen             | A                     | morgen                | true                    | morgen       |                |
			| einddatum uitsluiting vorige maand       | A                     | vorige maand          |                         |              |                |
			| einddatum uitsluiting deze maand         | A                     | deze maand            | true                    | deze maand   |                |
			| einddatum uitsluiting vorig jaar         | A                     | vorig jaar            |                         |              |                |
			| einddatum uitsluiting dit jaar           | A                     | dit jaar              | true                    | dit jaar     |                |
			| einddatum uitsluiting onbekend           | A                     | 00000000              | true                    | 00000000     |                |
