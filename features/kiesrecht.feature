# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, Dan wordt die uitsluiting niet opgenomen in de API.

@gba
Rule: Europees Kiesrecht (31.10) wordt geleverd als boolean
	- waarde 1 (= persoon is uitgesloten) wordt geleverd als boolean waarde false
	- waarde 2 (= persoon ontvangt oproep) wordt geleverd als boolean waarde true

	@gba
	Abstract Scenario: Europees kiesrecht <Europees kiesrecht> vertaald naar boolean
	  Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende kiesrecht gegevens
		| Europees kiesrecht (31.10)                       | <Europees kiesrecht> |
		| einddatum uitsluiting Europees kiesrecht (31.30) | 20300101             |
		Als de persoon op 15 maart 2022 wordt geraadpleegd met de volgende parameters
		| naam                | waarde                          |
		| type                | RaadpleegMetBurgerservicenummer |
		| burgerservicenummer | 999990001                       |
		| fields              | kiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'kiesrecht' gegevens
		| naam                                  | waarde              |
		| europeesKiesrecht                     | <europeesKiesrecht> |
		| einddatumUitsluitingEuropeesKiesrecht | 2030-01-01          |

		Voorbeelden:
		| Europees kiesrecht | europeesKiesrecht |
		| 1                  | false             |
		| 2                  | true              |
		|                    |                   |

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
		| fields              | kiesrecht                       |
		Dan bevat de persoon met burgerservicenummer '999990001' de volgende 'kiesrecht' gegevens
		| naam                          | waarde                    |
		| uitgeslotenVanKiesrecht       | <uitgeslotenVanKiesrecht> |
		| einddatumUitsluitingKiesrecht | 2030-01-01                |

		Voorbeelden:
		| uitgesloten kiesrecht | uitgeslotenVanKiesrecht |
		| A                     | true                    |
		|                       |                         |

@proxy
Rule: Uitsluiting van Europees kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en Europees kiesrecht wel, wordt Europees kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.

	@proxy
	Abstract Scenario: Europees kiesrecht <omschrijving>
		Gegeven het systeem heeft een persoon met de volgende gegevens
		| naam                        | waarde     |
		| burgerservicenummer         | 999990001  |
		En de persoon heeft de volgende kiesrecht gegevens
		| naam                                             | waarde                  |
		| Europees kiesrecht (31.10)                       | <Europees kiesrecht>    |
		| einddatum uitsluiting Europees kiesrecht (31.30) | <einddatum uitsluiting> |
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
		| omschrijving                       | Europees kiesrecht | einddatum uitsluiting | europeesKiesrecht | type           | einddatum  | einddatum jaar | einddatum maand |
		| niet opgegeven                     |                    |                       |                   |                |            |                |                 |
		| uitgesloten zonder einddatum       | false              |                       | false             |                |            |                |                 |
		| einddatum uitsluiting in toekomst  | false              | 20300101              | false             | Datum          | 2030-01-01 |                |                 |
		| einddatum uitsluiting in verleden  | false              | 20220301              |                   |                |            |                |                 |
		| einddatum uitsluiting vandaag      | false              | 20220315              |                   |                |            |                |                 |
		| einddatum uitsluiting morgen       | false              | 20300316              | false             | Datum          | 2030-03-16 |                |                 |
		| einddatum uitsluiting vorige maand | false              | 20220200              |                   |                |            |                |                 |
		| einddatum uitsluiting deze maand   | false              | 20220300              | false             | JaarMaandDatum |            | 2022           | 3               |
		| einddatum uitsluiting vorig jaar   | false              | 20210000              |                   |                |            |                |                 |
		| einddatum uitsluiting dit jaar     | false              | 20220000              | false             | JaarDatum      |            | 2022           |                 |
		| einddatum uitsluiting onbekend     | false              | 00000000              | false             | DatumOnbekend  |            |                |                 |
		| persoon ontvangt oproep            | true               |                       | true              |                |            |                |                 |

@proxy
Rule: Uitsluiting van kiesrecht wordt alleen opgenomen wanneer de einddatum uitsluiting in de toekomst ligt
	- Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	- Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	- Een volledig onbekende einddatum uitsluiting wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.
	- Wanneer einddatum uitsluiting geen waarde heeft en uitsluiting kiesrecht wel, wordt uitsluiting kiesrecht wel opgenomen.
	- Wanneer einddatum uitsluiting in het verleden ligt of vandaag is, wordt het niet opgenomen.

	@proxy
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
		| omschrijving                       | uitsluiting kiesrecht | einddatum uitsluiting | uitgeslotenVanKiesrecht | type           | einddatum  | einddatum jaar | einddatum maand |
		| niet opgegeven                     |                       |                       |                         |                |            |                |                 |
		| uitgesloten zonder einddatum       | true                  |                       | true                    |                |            |                |                 |
		| einddatum uitsluiting in toekomst  | true                  | 20300101              | true                    | Datum          | 2030-01-01 |                |                 |
		| einddatum uitsluiting in verleden  | true                  | 20220301              |                         |                |            |                |                 |
		| einddatum uitsluiting vandaag      | true                  | 20220315              |                         |                |            |                |                 |
		| einddatum uitsluiting morgen       | true                  | 20300316              | true                    | Datum          | 2030-03-16 |                |                 |
		| einddatum uitsluiting vorige maand | true                  | 20220200              |                         |                |            |                |                 |
		| einddatum uitsluiting deze maand   | true                  | 20220300              | true                    | JaarMaandDatum |            | 2022           | 3               |
		| einddatum uitsluiting vorig jaar   | true                  | 20210000              |                         |                |            |                |                 |
		| einddatum uitsluiting dit jaar     | true                  | 20220000              | true                    | JaarDatum      |            | 2022           |                 |
		| einddatum uitsluiting onbekend     | true                  | 00000000              | true                    | DatumOnbekend  |            |                |                 |
