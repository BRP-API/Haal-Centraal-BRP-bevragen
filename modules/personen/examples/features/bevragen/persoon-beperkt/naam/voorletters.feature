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

Regel: Voorletters wordt samengesteld uit de eerste letter van de voornamen gescheiden door een punt

  Abstract Scenario: <titel>
    Gegeven de persoon met burgerservicenummer '000000413' heeft de volgende gegevens
    | naam                  | waarde      |
    | geslachtsnaam (02.40) | Maassen     |
    | geboortedatum (03.10) | 19830526    |
    | voornamen (02.10)     | <voornamen> |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                              |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam | Maassen                             |
    | geboortedatum | 1983-05-26                          |
    | fields        | naam.voorletters                    |
    Dan heeft de response een persoon met alleen de volgende 'naam' gegevens
    | naam        | waarde        |
    | voorletters | <voorletters> |

		Voorbeelden:
    | voornamen            | voorletters | titel                                               | description                                                                                                                       |
    | Henk                 | H.          | Één voornaam                                        |                                                                                                                                   |
    | Anna Cornelia        | A.C.        | Meerdere voornamen (1)                              |                                                                                                                                   |
    | Johan Frank Robert   | J.F.R.      | Meerdere voornamen (2)                              |                                                                                                                                   |
    | Theo Philip IJsbrand | T.P.I.      | Voornaam met een dubbelklank (Th, Ph, Ch, IJ, enz.) | Een voornaam dat begint met een dubbelklank (Th, Ph, Ch, IJ, enz.), wordt (ook) afgekort tot één voorletter.                      |
    | Anne-Fleur Belle     | A.B.        | Voornaam is een samengestelde naam                  |                                                                                                                                   |
    | Suzie Q              | S.Q         | Één voornaam bestaat uit één letter                 |                                                                                                                                   |
    | A                    | A           | Voornaam bestaat uit één letter                     | Een voornaam bestaand uit één letter, wordt afgekort tot een letter zonder .                                                      |
    | J P                  | J P         | Meerdere voornamen bestaan uit één letter           | Een voornaam bestaand uit één letter, gevolgd door een andere voornaam, wordt afgekort tot voorletters gescheiden door een spatie |

  Scenario: Geen voornamen
    Gegeven de persoon met burgerservicenummer '000000425' heeft de volgende gegevens
    | naam                  | waarde   |
    | voornamen (02.10)     |          |
    | geslachtsnaam (02.40) | Maassen  |
    | geboortedatum (03.10) | 19830526 |
    Als personen wordt gezocht met de volgende parameters
    | naam          | waarde                               |
    | type          | ZoekMetGeslachtsnaamEnGeboortedatum  |
    | geslachtsnaam | Maassen                              |
    | geboortedatum | 1983-05-26                           |
    | fields        | burgerservicenummer,naam.voorletters |
    Dan heeft de response een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000425 |
    En heeft de persoon een leeg 'naam' object 
