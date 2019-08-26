# language: nl

Functionaliteit: LeeftijdBepaling

Abstract Scenario: Volledig geboortedatum
	Gegeven een ingeschreven persoon met geboortedatum 26 mei 1983
	Als de ingeschreven persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden: 
	| raadpleeg datum  | leeftijd |
	| 26 mei 2019      | 36       |
	| 30 november 2019 | 36       |
	| 1 januari 2019   | 35       |

Scenario: Volledig onbekend geboortedatum
	Gegeven een ingeschreven persoon kent geen geboortedatum
	Als de ingeschreven persoon wordt geraadpleegd
	Dan is attribuut leeftijd niet aanwezig

Abstract Scenario: Jaar en maand van geboorte datum zijn bekend
	Geboortedatum wordt gezet op de laatste dag van de geboorte maand
	Gegeven een ingeschreven persoon met geboortedatum mei 1983
	Als de ingeschreven persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden: 
	| raadpleeg datum  | leeftijd |
	| 31 mei 2019      | 36       |
	| 30 november 2019 | 36       |
	| 30 mei 2019      | 35       |

Abstract Scenario: Alleen jaar van geboorte datum is bekend
	Geboortedatum wordt gezet op de laatste dag ven het geboorte jaar
	Gegeven een ingeschreven persoon met geboortedatum mei 1983
	Als de ingeschreven persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden: 
	| raadpleeg datum  | leeftijd |
	| 31 december 2019 | 36       |
	| 30 december 2019 | 35       |
