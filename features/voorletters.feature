#language: nl
Functionaliteit: Bepalen van voorletters uit de voornamen van een persoon

Als klant van gemeenten
wil ik dat mijn voorletters in plaats van mijn voornamen automatisch worden ingevuld in e-formulieren en gepersonaliseerde "mijn" omgevingen
zodat mijn naam overzichtelijk wordt weergegeven

De voorletters worden opgenomen als één (1) voorletter per voornaam, gevolgd door een punt (.).
Als een voornaam een samengestelde naam is gescheiden door een koppelteken (-), Dan wordt deze voornaam (ook) afgekort tot één voorletter.
Als een voornaam  begint met een dubbelklank (Th, Ph, Ch, IJ, enz.), Dan wordt deze voornaam (ook) afgekort tot één voorletter.
Als één of meerdere voornamen uit één letter bestaan, dan volgt er na de letter geen .
Wanneer na een voorletter zonder punt (voornaam had één letter) nog een andere voorletter volgt, wordt daartussen een spatie gezet.
Als de rubriek Voornamen is gevuld met de standaardwaarde '.' (punt), Dan wordt geen extra (scheidings)punt toegevoegd; de inhoud van de attribuut voorletters is na afleiding Dan '.'


Abstract Scenario: Voorletters wordt samengesteld uit de eerste letter van de voornamen gescheiden door een punt
	Gegeven een ingeschreven persoon met voornamen <voornamen>
	Als de persoon wordt geraadpleegd
	Dan zijn de voorletters van de ingeschreven persoon gelijk aan <voorletters>

	Voorbeelden:
	| voornamen            | voorletters |
	| Henk                 | H.          |
	| Anna Cornelia        | A.C.        |
	| Johan Frank Robert   | J.F.R.      |
	| Theo Philip IJsbrand | T.P.I.      |
	| Anne-Fleur Belle     | A.B.        |
	| Suzie Q              | S.Q         |
	| J P                  | J P         |
	| A                    | A           |
	| .                    | .           |
