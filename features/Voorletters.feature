#language: nl
Functionaliteit: Bepalen van voorletters uit de voornamen van een persoon

Als klant van gemeenten
wil ik dat mijn voorletters in plaats van mijn voornamen automatisch worden ingevuld in e-formulieren en gepersonaliseerde "mijn" omgevingen
zodat mijn naam overzichtelijk wordt weergegeven


Abstract Scenario: Voorletters wordt samengesteld uit de eerste letter van de voornamen gescheiden door een punt
	Gegeven een ingeschreven persoon met voornamen <voornamen>
	Dan zijn de voorletters van de ingeschreven persoon gelijk aan <voorletters>

	Voorbeelden:
	| voornamen          | voorletters |
	| Henk               | H.          |
	| Anna Cornelia      | A.C.        |
	| Johan Frank Robert | J.F.R.      |