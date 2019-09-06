# language: nl

Functionaliteit: Kiesrecht
	Het kiesrecht wordt afgeleid uit gegevens in de registratie.
	Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten.
	Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.

	De actuele situatie wordt getoond. Als een uitsluiting in het verleden ligt, Dan wordt die uitsluiting niet opgenomen in de API.

	Opname van (geheel of gedeeltelijk) onbekende datums gebeurt op dezelfde manier als andere (mogelijk onvolledige) datums elders in de API.
	Wanneer alleen het jaar van de einddatum uitsluiting bekend is, dan wordt de uitsluiting opgenomen tot en met dat jaar.
	Wanneer het jaar en de maand van de einddatum uitsluiting bekend is, en de dag niet, dan wordt de uitsluiting opgenomen tot en met die maand.
	Een volledig onbekende datum wordt hetzelfde geïnterpreteerd en weergegeven als het niet aanwezig zijn van die datum.

	Vertaling van Europees kiesrecht
	* Alleen wanneer 31.10 gelijk is aan 2 (= persoon ontvangt oproep), wordt europeesKiesrecht = true
	* Alleen wanneer 31.10 gelijk is aan 1 (= persoon is uitgesloten) en 31.30 is leeg of de datum ligt in de toekomst, wordt europeesKiesrecht = false
	* In alle andere gevallen wordt europeesKiesrecht niet opgenomen

	| 31.10                       | 31.30             | europeesKiesrecht | einddatumUitsluitingEuropeesKiesrecht |
	| leeg of afwezig             | leeg of afwezig   | afwezig           | afwezig                               |
	| 1 = persoon is uitgesloten  | leeg of afwezig   | false             | afwezig                               |
	| 1 = persoon is uitgesloten  | toekomstige datum | false             | overnemen uit 31.30                   |
	| 1 = persoon is uitgesloten  | datum in verleden | afwezig           | afwezig                               |
	| 2 = persoon ontvangt oproep | leeg of afwezig   | true              | afwezig                               |

	Vertaling van kiesrecht
	* Alleen wanneer 38.10 gelijk is aan "A" (persoon is uitgesloten) en 38.20 is leeg of de datum ligt in de toekomst, wordt uitgeslotenVanKiesrecht = true
	* In alle andere gevallen wordt uitgeslotenVanKiesrecht niet opgenomen

	| 38.10                      | 38.20             | uitgeslotenVanKiesrecht | einddatumUitsluitingKiesrecht |
	| leeg of afwezig            | leeg of afwezig   | afwezig                 | afwezig                       |
	| A = persoon is uitgesloten | leeg of afwezig   | true                    | afwezig                       |
	| A = persoon is uitgesloten | 00000000          | true                    | afwezig                       |
	| A = persoon is uitgesloten | toekomstige datum | true                    | overnemen uit 38.20           |
	| A = persoon is uitgesloten | datum in verleden | afwezig                 | afwezig                       |


Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is niet aanwezig of heeft geen waarde
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van Europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 2 (= persoon ontvangt oproep)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan true

Scenario: bij de ingeschreven persoon is geen Europees kiesrecht vastgesteld
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 is leeg
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht en de einddatum uitsluiting Europees kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is een datum in het verleden
	Dan is europeesKiesrecht niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht en de einddatum uitsluiting Europees kiesrecht ligt in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is een datum in de toekomst
	Dan is europeesKiesrecht gelijk aan false
	En is einddatumUitsluitingEuropeesKiesrecht gelijk aan de waarde van element 31.10

Abstract Scenario: de einddatum uitsluiting europees kiesrecht is geheel of deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan <geheel of deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd op 6 september 2019
	Dan is europeesKiesrecht <europeesKiesrecht>
	En is einddatumUitsluitingEuropeesKiesrecht <einddatumUitsluitingEuropeesKiesrecht>

	Voorbeelden:
	| geheel of deels onbekende datum | europeesKiesrecht | einddatumUitsluitingEuropeesKiesrecht |
	| 00000000                        | false             | niet aanwezig                         |
	| 20190000                        | false             | jaar: 2019                            |
	| 20180000                        | niet aanwezig     | niet aanwezig                         |
	| 20191000                        | false             | jaar: 2019, maand: 10                 |
	| 20190900                        | false             | jaar: 2019, maand: 09                 |
	| 20190800                        | niet aanwezig     | niet aanwezig                         |

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is niet aanwezig of heeft geen waarde
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is uitgeslotenVanKiesrecht gelijk aan true

Scenario: de ingeschreven persoon is niet uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is er geen categorie 13, element 38.10 (= persoon is niet uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is uitgeslotenVanKiesrecht niet aanwezig

Scenario: de ingeschreven persoon was uitgesloten van kiesrecht en de einddatum uitsluiting kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is een datum in het verleden
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is uitgeslotenVanKiesrecht niet aanwezig
	En is einddatumUitsluitingKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht en de einddatum uitsluiting kiesrecht ligt in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is een datum in de toekomst
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is uitgeslotenVanKiesrecht gelijk aan true
	En is einddatumUitsluitingKiesrecht gelijk aan de waarde van element 38.20

Abstract Scenario: de einddatum uitsluiting kiesrecht is geheel of deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan <geheel of deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd op 6 september 2019
	Dan is uitgeslotenVanKiesrecht <europeesKiesrecht>
	En is einddatumUitsluitingEuropeesKiesrecht <einddatumUitsluitingEuropeesKiesrecht>

	Voorbeelden:
	| geheel of deels onbekende datum | uitgeslotenVanKiesrecht | einddatumUitsluitingEuropeesKiesrecht |
	| 00000000                        | true                    | niet aanwezig                         |
	| 20190000                        | true                    | jaar: 2019                            |
	| 20180000                        | niet aanwezig           | niet aanwezig                         |
	| 20191000                        | true                    | jaar: 2019, maand: 10                 |
	| 20190900                        | true                    | jaar: 2019, maand: 09                 |
	| 20190800                        | niet aanwezig           | niet aanwezig                         |
