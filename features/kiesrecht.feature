# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, Dan wordt die uitsluiting niet opgenomen in de API.

Rule: Uitsluiting van Europees kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende datum wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.

	Abstract Scenario: Europees kiesrecht <omschrijving>
		Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende kiesrecht gegevens
		| naam                                          | waarde                                  |
		| europeesKiesrecht (31.10)                     | <Europees kiesrecht>                |
		| einddatumUitsluitingEuropeesKiesrecht (31.30) | <einddatumUitsluitingEuropeesKiesrecht> |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | kiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'kiesrecht' gegevens
		| naam                                        | waarde                                        |
		| europeesKiesrecht                           | <europeesKiesrecht>                           |
		| einddatumUitsluitingEuropeesKiesrecht.type  | <type>                                        |
		| einddatumUitsluitingEuropeesKiesrecht.datum | <einddatum>                                   |
		| einddatumUitsluitingEuropeesKiesrecht.jaar  | <einddatum jaar>                              |
		| einddatumUitsluitingEuropeesKiesrecht.maand | <einddatum maand>                             |

		Voorbeelden:
		| omschrijving                       | 31.10 | Europees kiesrecht | einddatumUitsluitingEuropeesKiesrecht | europeesKiesrecht | type           | einddatum  | einddatum jaar | einddatum maand |
		| niet opgegeven                     |       |                    |                                       |                   |                |            |                |                 |
		| uitgesloten zonder einddatum       | 1     | false              |                                       | false             |                |            |                |                 |
		| einddatum uitsluiting in toekomst  | 1     | false              | 20300101                              | false             | Datum          | 2030-01-01 |                |                 |
		| einddatum uitsluiting in verleden  | 1     | false              | 20220301                              |                   | Datum          |            |                |                 |
		| einddatum uitsluiting vorige maand | 1     | false              | 20220200                              |                   | JaarMaandDatum |            |                |                 |
		| einddatum uitsluiting deze maand   | 1     | false              | 20220300                              | false             | JaarMaandDatum |            | 2022           | 3               |
		| einddatum uitsluiting vorig jaar   | 1     | false              | 20210000                              |                   | JaarDatum      |            |                |                 |
		| einddatum uitsluiting dit jaar     | 1     | false              | 20220000                              | false             | JaarDatum      |            | 2022           |                 |
		| einddatum uitsluiting onbekend     | 1     | false              | 00000000                              | false             | OnbekendDatum  |            |                |                 |
		| persoon ontvangt oproep            | 2     | true               |                                       | true              |                |            |                |                 |

Rule: Uitsluiting van kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende datum wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.

	Abstract Scenario: kiesrecht <omschrijving>
		Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende kiesrecht gegevens
		| naam                                  | waarde                  |
		| uitgeslotenVanKiesrecht (38.10)       | <uitsluiting kiesrecht> |
		| einddatumUitsluitingKiesrecht (38.20) | <einddatum uitsluiting> |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | kiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'kiesrecht' gegevens
		| naam                                | waarde                                        |
		| uitgeslotenVanKiesrecht             | <uitgeslotenVanKiesrecht>                     |
		| einddatumUitsluitingKiesrecht.type  | <type>                                        |
		| einddatumUitsluitingKiesrecht.datum | <einddatum>                                   |
		| einddatumUitsluitingKiesrecht.jaar  | <einddatum jaar>                              |
		| einddatumUitsluitingKiesrecht.maand | <einddatum maand>                             |

		Voorbeelden:
		| omschrijving                       | 38.10 | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | type           | einddatum  | einddatum jaar | einddatum maand |
		| niet opgegeven                     |       |                       |                       |                         |                |            |                |                 |
		| uitgesloten zonder einddatum       | A     | true                  |                       | false                   |                |            |                |                 |
		| einddatum uitsluiting in toekomst  | A     | true                  | 20300101              | false                   | Datum          | 2030-01-01 |                |                 |
		| einddatum uitsluiting in verleden  | A     | true                  | 20220301              |                         | Datum          |            |                |                 |
		| einddatum uitsluiting vorige maand | A     | true                  | 20220200              |                         | JaarMaandDatum |            |                |                 |
		| einddatum uitsluiting deze maand   | A     | true                  | 20220300              | false                   | JaarMaandDatum |            | 2022           | 3               |
		| einddatum uitsluiting vorig jaar   | A     | true                  | 20210000              |                         | JaarDatum      |            |                |                 |
		| einddatum uitsluiting dit jaar     | A     | true                  | 20220000              | false                   | JaarDatum      |            | 2022           |                 |
		| einddatum uitsluiting onbekend     | A     | true                  | 00000000              | false                   | OnbekendDatum  |            |                |                 |
