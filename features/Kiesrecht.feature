# language: nl

Functionaliteit: Kiesrecht

Scenario: de ingeschreven persoon is uitgesloten van europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 1 (= persoon is uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is europeesKiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van europees kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.10 gelijk aan 2 (= persoon ontvangt oproep)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is europeesKiesrecht gelijk aan true

Scenario: de einddatum uitsluiting europees kiesrecht is onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan 00000000 (= onbekend)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is einddatumUitsluitingEuropeesKiesrecht leeg

Abstract Scenario: de einddatum uitsluiting europees kiesrecht is deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 31.30 gelijk aan <deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is einddatumUitsluitingEuropeesKiesrecht.jaar <jaar>
	En is einddatumUitsluitingEuropeesKiesrecht.maand <maand>
	En is einddatumUitsluitingEuropeesKiesrecht.dag <dag>
	En is einddatumUitsluitingEuropeesKiesrecht.datum leeg

	Voorbeelden: 
	| deels onbekende datum | jaar | maand | dag  |
	| 20180000              | 2018 | leeg  | leeg |
	| 20181000              | 2018 | 10    | leeg |

Scenario: de ingeschreven persoon is uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.10 gelijk aan A (= persoon is uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is kiesrecht gelijk aan false

Scenario: de ingeschreven persoon is niet uitgesloten van kiesrecht
	Gegeven op de PL van een ingeschreven persoon is er geen categorie 13, element 38.10 (= persoon is niet uitgesloten)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is kiesrecht gelijk aan true

Scenario: de einddatum uitsluiting kiesrecht is onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan 00000000 (= onbekend)
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is einddatumUitsluitingKiesrecht leeg

Abstract Scenario: de einddatum uitsluiting kiesrecht is deels onbekend
	Gegeven op de PL van een ingeschreven persoon is categorie 13, element 38.20 gelijk aan <deels onbekende datum>
	Als de ingeschreven persoon wordt geraadpleegd met burgerservicenummer 999999291
	Dan is einddatumUitsluitingKiesrecht.jaar <jaar>
	En is einddatumUitsluitingKiesrecht.maand <maand>
	En is einddatumUitsluitingKiesrecht.dag <dag>
	En is einddatumUitsluitingKiesrecht.datum leeg

	Voorbeelden: 
	| deels onbekende datum | jaar | maand | dag  |
	| 20180000              | 2018 | leeg  | leeg |
	| 20181000              | 2018 | 10    | leeg |
