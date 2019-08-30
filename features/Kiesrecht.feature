# language: nl

Functionaliteit: Kiesrecht
	De API toont of een persoon kiesrecht heeft.

	Het kiesrecht wordt afgeleid uit gegevens in de registratie. Voor Europees kiesrecht kan in de registratie zijn vastgelegd of een persoon een oproep krijgt dan wel is uitgesloten. Voor (niet-Europees) kiesrecht kan in de registratie zijn vastgelegd dat een persoon is uitgesloten.
	Er worden geen aannames gedaan over (binnenlands of Europees) kiesrecht wanneer de registratie daar geen gegevens over heeft vastgelegd. In de API wordt kiesrecht en Europees kiesrecht alleen gevuld met gegevens die direct en zeker zijn af te leiden van wat in de registratie is vastgelegd.

	De actuele situatie wordt getoond. Dus wanneer een uitsluiting in het verleden ligt, wordt die uitsluiting niet opgenomen in de API.

	Opname van onbekende datums gebeurt op dezelfde manier als elders in de API.
	Een onbekend datum wordt hetzelfde geïnterpreteerd en weergegeven dan het niet aanwezig zijn van die datum.

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
		* Alleen wanneer 38.10 gelijk is aan "A" (persoon is uitgesloten) en 38.20 is leeg of de datum ligt in de toekomst, wordt kiesrecht = false
		* In alle andere gevallen wordt kiesrecht niet opgenomen

		| 38.10                      | 38.20             | kiesrecht | einddatumUitsluitingKiesrecht |
		| leeg of afwezig            | leeg of afwezig   | afwezig   | afwezig                       |
		| A = persoon is uitgesloten | leeg of afwezig   | false     | afwezig                       |
		| A = persoon is uitgesloten | toekomstige datum | false     | overnemen uit 38.20           |
		| A = persoon is uitgesloten | datum in verleden | afwezig   | afwezig                       |


Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is niet aanwezig of heeft geen waarde
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan false

Scenario: de ingeschreven persoon ontvangt oproep voor Europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 2 (= persoon ontvangt oproep)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan true

Scenario: voor de ingeschreven persoon is categorie 13 en/of groep 31 Europees kiesrecht niet aanwezig
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 is leeg
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht en de einddatum uitsluiting Europees kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is een datum in het verleden (20180523)
	Dan is europeesKiesrecht gelijk aan true
	En is einddatumUitsluitingEuropeesKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van Europees kiesrecht en de einddatum uitsluiting Europees kiesrecht ligt in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is een datum in de toekomst (20500523)
	Dan is europeesKiesrecht gelijk aan false
	En is einddatumUitsluitingEuropeesKiesrecht.datum gelijk aan 2050-05-23
	En is einddatumUitsluitingEuropeesKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingEuropeesKiesrecht.maand gelijk aan 5
	En is einddatumUitsluitingEuropeesKiesrecht.dag gelijk aan 23

Scenario: de einddatum uitsluiting europees kiesrecht is geheel onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 00000000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingEuropeesKiesrecht niet aanwezig
	En is europeesKiesrecht gelijk aan false

Abstract Scenario: de einddatum uitsluiting europees kiesrecht is deels onbekend en in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan <geheel of deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingEuropeesKiesrecht niet aanwezig
	En is europeesKiesrecht niet aanwezig

	Voorbeelden:
	| deels onbekende datum |
	| 20180000              |
	| 20181000              |

Scenario: de einddatum uitsluiting europees kiesrecht is deels onbekend en in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 20500000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingEuropeesKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingEuropeesKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.maand niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.dag niet aanwezig
	En is europeesKiesrecht gelijk aan false

	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 20501000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingEuropeesKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingEuropeesKiesrecht.maand gelijk aan 10
	En is einddatumUitsluitingEuropeesKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.dag niet aanwezig
	En is europeesKiesrecht gelijk aan false

Scenario: de einddatum uitsluiting europees kiesrecht is deels onbekend en kan voor of na de huidige datum liggen
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 20190000
	Als de ingeschreven persoon wordt geraadpleegd op 14 oktober 2019
	Dan is einddatumUitsluitingEuropeesKiesrecht.jaar gelijk aan 2019
	En is einddatumUitsluitingEuropeesKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.maand niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.dag niet aanwezig
	En is europeesKiesrecht gelijk aan false

	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 20191000
	Als de ingeschreven persoon wordt geraadpleegd op 14 oktober 2019
	Dan is einddatumUitsluitingEuropeesKiesrecht.jaar gelijk aan 2019
	En is einddatumUitsluitingEuropeesKiesrecht.maand gelijk aan 10
	En is einddatumUitsluitingEuropeesKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingEuropeesKiesrecht.dag niet aanwezig
	En is europeesKiesrecht gelijk aan false

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is er geen categorie 13, element 38.10 (= persoon is niet uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht en de einddatum uitsluiting kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is een datum in het verleden (20180523)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht niet aanwezig
	En is einddatumUitsluitingKiesrecht niet aanwezig

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht en de einddatum uitsluiting kiesrecht ligt in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is een datum in het verleden (20500523)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht gelijk aan false
	En is einddatumUitsluitingKiesrecht.datum gelijk aan 2050-05-23
	En is einddatumUitsluitingKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingKiesrecht.maand gelijk aan 5
	En is einddatumUitsluitingKiesrecht.dag gelijk aan 23

Scenario: de einddatum uitsluiting kiesrecht is geheel onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 00000000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingKiesrecht niet aanwezig
	En is kiesrecht gelijk aan false

Abstract Scenario: de einddatum uitsluiting kiesrecht is deels onbekend en in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan <deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingKiesrecht niet aanwezig
	En is kiesrecht niet aanwezig

	Voorbeelden:
	| deels onbekende datum |
	| 20180000              |
	| 20181000              |

Scenario: de einddatum uitsluiting kiesrecht is deels onbekend en in de toekomst
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 20500000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingKiesrecht.maand niet aanwezig
	En is einddatumUitsluitingKiesrecht.dag niet aanwezig
	En is kiesrecht gelijk aan false

	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 20501000
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingKiesrecht.jaar gelijk aan 2050
	En is einddatumUitsluitingKiesrecht.maand gelijk aan 10
	En is einddatumUitsluitingKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingKiesrecht.dag niet aanwezig
	En is kiesrecht gelijk aan false

Scenario: de einddatum uitsluiting kiesrecht is deels onbekend en kan voor of na de huidige datum liggen
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 20190000
	Als de ingeschreven persoon wordt geraadpleegd op 14 oktober 2019
	Dan is einddatumUitsluitingKiesrecht.jaar gelijk aan 2019
	En is einddatumUitsluitingKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingKiesrecht.maand niet aanwezig
	En is einddatumUitsluitingKiesrecht.dag niet aanwezig
	En is kiesrecht gelijk aan false

	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 20191000
	Als de ingeschreven persoon wordt geraadpleegd op 14 oktober 2019
	Dan is einddatumUitsluitingKiesrecht.jaar gelijk aan 2019
	En is einddatumUitsluitingKiesrecht.maand gelijk aan 10
	En is einddatumUitsluitingKiesrecht.datum niet aanwezig
	En is einddatumUitsluitingKiesrecht.dag niet aanwezig
	En is kiesrecht gelijk aan false
