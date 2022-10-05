# language: nl

Functionaliteit: Uitsluiting kiesrecht


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

	Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als de einddatum ontbreekt
		- waarde "A" wordt geleverd als boolean waarde true

	Scenario: Aanduiding uitgesloten kiesrecht (38.10) en geen einddatum uitsluiting kiesrecht
#   Functioneel zou dit moeten zijn :
#   Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'kiesrecht' gegevens
#   De kiesrechtgegevens zijn opgenomen in de lo3_pl tabel. Het toevoegen van kiesrecht gegevens zou in de automation code een update vereisen.
#   Die update is nog niet geïmplementeerd, dus worden de kiesrecht met de insert van de inschrijving meegegeven.

	  Gegeven de persoon met burgerservicenummer '000000139' heeft de volgende 'inschrijving' gegevens
	  | aanduiding uitgesloten kiesrecht (38.10) |
		| A                                        |
		Als gba personen wordt gezocht met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 000000139                       |
		| fields              | uitsluitingKiesrecht            |
		Dan heeft de response een persoon met de volgende 'uitsluitingKiesrecht' gegevens
    | naam                    | waarde   |
    | uitgeslotenVanKiesrecht | true     |

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
			Als gba personen wordt gezocht met de volgende parameters
			| naam                | waarde                          |
			| type                | RaadpleegMetBurgerservicenummer |
			| burgerservicenummer | 000000140                       |
			| fields              | burgerservicenummer,uitsluitingKiesrecht |
			Dan heeft de response een persoon met de volgende gegevens
			| naam                                         | waarde                    |
			| burgerservicenummer                          | 000000140                 |
			| uitsluitingKiesrecht.uitgeslotenVanKiesrecht | <uitgeslotenVanKiesrecht> |
			| uitsluitingKiesrecht.einddatum               | <einddatum>               |

				Voorbeelden:
		  | omschrijving                             | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | einddatum    |
		  | einddatum in toekomst zonder uitsluiting |                       | volgend jaar          | true                    | volgend jaar |
		  | einddatum uitsluiting in toekomst        | A                     | volgend jaar          | true                    | volgend jaar |
		  | einddatum uitsluiting in verleden        | A                     | vorig jaar            |                         |              |
		  | einddatum uitsluiting vandaag            | A                     | vandaag               |                         |              |
		  | einddatum uitsluiting morgen             | A                     | morgen                | true                    | morgen       |
		  | einddatum uitsluiting vorige maand       | A                     | vorige maand          |                         |              |
		  | einddatum uitsluiting deze maand         | A                     | deze maand            | true                    | deze maand   |
		  | einddatum uitsluiting vorig jaar         | A                     | vorig jaar            |                         |              |
		  | einddatum uitsluiting dit jaar           | A                     | dit jaar              | true                    | dit jaar     |
		  | einddatum uitsluiting onbekend           | A                     | 00000000              | true                    | 00000000     |
