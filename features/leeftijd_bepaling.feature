# language: nl

Functionaliteit: LeeftijdBepaling

Abstract Scenario: Volledig geboortedatum
	Gegeven een persoon met geboortedatum 26 mei 1983
	Als de persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden:
	| raadpleeg datum  | leeftijd |
	| 26 mei 2019      | 36       |
	| 30 november 2019 | 36       |
	| 1 januari 2019   | 35       |

Scenario: Volledig onbekend geboortedatum
	Gegeven een persoon kent geen geboortedatum
	Als de persoon wordt geraadpleegd
	Dan is attribuut leeftijd niet aanwezig

Abstract Scenario: Jaar en maand van geboorte datum zijn bekend
	Gegeven een persoon met geboortedatum mei 1983
	Als de persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden:
	| raadpleeg datum | leeftijd          | omschrijving                                                                           |
	| 31 mei 2019     | <niet aanwezig>   | In de geboorte maand weten we niet wanneer de persoon jarig is                         |
	| 01 juni 2019    | 36                | Na de geboorte maand weten we zeker dat de persoon 1 jaar ouder is geworden            |
	| 30 april 2019   | 35                | Voor de geboorte maand weten we zeker dat de persoon nog niet 1 jaar ouder is geworden |

Scenario: Alleen jaar van geboorte datum is bekend
	Gegeven een persoon met geboortedatum mei 1983
	Als de persoon op <raadpleeg datum> wordt geraadpleegd
	Dan is attribuut leeftijd niet aanwezig

Scenario: Persoon is overleden
	Gegeven de persoon met burgerservicenummer "999993197" is overleden op 28-04-2019
	Als de  persoon met burgerservicenummer 999993197 wordt geraadpleegd met fields=leeftijd
	Dan is attribuut leeftijd niet aanwezig

Scenario: leeftijd wordt wel geleverd bij een overleden kind (omdat alleen gegevens van de persoonslijst van de gevraagde persoon worden gebruikt)
	Gegeven de persoon met burgerservicenummer "999991280" heeft een kind met burgerservicenummer "999993197"
	En de persoon met burgerservicenummer "999993197" is overleden op 28-04-2019
	Als de  persoon met burgerservicenummer 999994268 wordt geraadpleegd met fields=kinderen
	Dan heeft het kind met burgerservicenummer "999993197" een attribuut "leeftijd" met een waarde

Abstract Scenario: Geboren op 29 februari in een schrikkeljaar
	Gegeven een persoon met 29 februari 1996
	Als de persoon op <raadpleeg datum> wordt geraadpleegd
	Dan heeft attribuut leeftijd de waarde <leeftijd>

	Voorbeelden:
	| raadpleeg datum  | leeftijd |
	| 29 februari 2016 | 20       |
	| 28 februari 2017 | 20       |
	| 01 maart 2017    | 21       |
