# language: nl

Functionaliteit: Kiesrecht

Scenario: de ingeschreven persoon is uitgesloten van europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van europees kiesrecht (1)
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 2 (= persoon ontvangt oproep)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan true

Scenario: de ingeschreven persoon is niet uitgesloten van europees kiesrecht (2)
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 is leeg
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is europeesKiesrecht gelijk aan true

Abstract Scenario: de einddatum uitsluiting europees kiesrecht is geheel of deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan <geheel of deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingEuropeesKiesrecht leeg

	Voorbeelden: 
	| geheel of deels onbekende datum |
	| 00000000                        |
	| 20180000                        |
	| 20181000                        |

Scenario: de ingeschreven persoon is uitgesloten van europees kiesrecht en de einddatum uitsluiting europees kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	En categorie 13, element 31.30 is een datum in het verleden
	Dan is europeesKiesrecht gelijk aan true
	En is einddatumUitsluitingEuropeesKiesrecht leeg

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is er geen categorie 13, element 38.10 (= persoon is niet uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht gelijk aan true

Abstract Scenario: de einddatum uitsluiting kiesrecht is geheel of deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan <geheel of deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is einddatumUitsluitingKiesrecht leeg

	Voorbeelden: 
	| geheel of deels onbekende datum |
	| 00000000                        |
	| 20180000                        |
	| 20181000                        |

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht en de einddatum uitsluiting kiesrecht ligt in het verleden
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	En categorie 13, element 38.20 is een datum in het verleden
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is kiesrecht gelijk aan true
	En is einddatumUitsluitingKiesrecht leeg
	
