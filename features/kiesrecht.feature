# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, Dan wordt die uitsluiting niet opgenomen in de API.

@gba
Rule: Aanduiding uitgesloten kiesrecht (38.10) wordt geleverd als boolean
	- waarde "A" wordt geleverd als boolean waarde true

	@gba
	Abstract Scenario: Aanduiding uitgesloten kiesrecht (38.10) <uitsluiting kiesrecht> vertaald naar boolean
	  Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende kiesrecht gegevens
		| aanduiding uitgesloten kiesrecht (38.10) | <uitgesloten kiesrecht> |
		| einddatum uitsluiting kiesrecht (38.20)  | 20300101                |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | uitsluitingKiesrecht            |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'uitsluitingKiesrecht' gegevens
		| naam                          | waarde                    |
		| uitgeslotenVanKiesrecht       | <uitgeslotenVanKiesrecht> |
		| einddatum                     | 2030-01-01                |

		Voorbeelden:
		| uitgesloten kiesrecht | uitgeslotenVanKiesrecht |
		| A                     | true                    |
		|                       |                         |



@gba
Rule: Uitsluiting van Europees kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en Europees kiesrecht wel, wordt Europees kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.

	@gba
	Abstract Scenario: Europees kiesrecht <omschrijving>
		Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende 'kiesrecht' gegevens
		| naam                                             | waarde                  |
		| Europees kiesrecht (31.10)                       | <Europees kiesrecht>    |
		| einddatum uitsluiting Europees kiesrecht (31.30) | <einddatum uitsluiting> |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | europeesKiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'europeesKiesrecht' gegevens
		| naam                             | waarde                    |
		| aanduiding.code                  | <aanduiding.code          |
		| aanduiding.omschrijving          | omschrijving.omschrijving |
		| einddatumUitsluiting             | <einddatumUitsluiting>    |

		Voorbeelden:
		| omschrijving                       | Europees kiesrecht | einddatum uitsluiting | aanduiding.code | aanduiding.omschrijving | einddatumUitsluiting |
		| niet opgegeven                     |                    |                       |                 |                         |                      |
		| uitgesloten zonder einddatum       | 1                  |                       | 1               | persoon is uitgesloten  |                      |
		| einddatum uitsluiting in toekomst  | 1                  | 20300101              | 1               | persoon is uitgesloten  | 20300101             |
		| einddatum uitsluiting in verleden  | 1                  | 20220301              |                 |                         |                      |
		| einddatum uitsluiting vandaag      | 1                  | 20220315              |                 |                         |                      |
		| einddatum uitsluiting morgen       | 1                  | 20300316              | 1               | persoon is uitgesloten  | 20300316             |
		| einddatum uitsluiting vorige maand | 1                  | 20220200              |                 |                         |                      |
		| einddatum uitsluiting deze maand   | 1                  | 20220300              | 1               | persoon is uitgesloten  | 20220300             |
		| einddatum uitsluiting vorig jaar   | 1                  | 20210000              |                 |                         |                      |
		| einddatum uitsluiting dit jaar     | 1                  | 20220000              | 1               | persoon is uitgesloten  | 20220000             |
		| einddatum uitsluiting onbekend     | 1                  | 00000000              | 1               | persoon is uitgesloten  | 00000000             |
		| persoon ontvangt oproep            | 2                  |                       | 2               | persoon ontvangt oproep |                      |

@gba
Rule: Uitsluiting van kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en uitsluiting kiesrecht wel, wordt uitsluiting kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.

	@gba
	Abstract Scenario: kiesrecht <omschrijving>
		Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende 'kiesrecht' gegevens
		| naam                                  | waarde                  |
		| uitgeslotenVanKiesrecht (38.10)       | <uitsluiting kiesrecht> |
		| einddatumUitsluitingKiesrecht (38.20) | <einddatum uitsluiting> |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | uitsluitingKiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'uitsluitingKiesrecht' gegevens
		| naam                    | waarde                    |
		| uitgeslotenVanKiesrecht | <uitgeslotenVanKiesrecht> |
		| einddatum               | <einddatum>               |

		Voorbeelden:
		| omschrijving                       | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | einddatum  |
		| niet opgegeven                     |                       |                       |                         |            |
		| uitgesloten zonder einddatum       | A                     |                       | true                    |            |
		| einddatum uitsluiting in toekomst  | A                     | 20300101              | true                    | 20300101   |
		| einddatum uitsluiting in verleden  | A                     | 20220301              |                         |            |
		| einddatum uitsluiting vandaag      | A                     | 20220315              |                         |            |
		| einddatum uitsluiting morgen       | A                     | 20300316              | true                    | 20300316   |
		| einddatum uitsluiting vorige maand | A                     | 20220200              |                         |            |
		| einddatum uitsluiting deze maand   | A                     | 20220300              | true                    | 20220300   |
		| einddatum uitsluiting vorig jaar   | A                     | 20210000              |                         |            |
		| einddatum uitsluiting dit jaar     | A                     | 20220000              | true                    | 20220000   |
		| einddatum uitsluiting onbekend     | A                     | 00000000              | true                    | 00000000   |
