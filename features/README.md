# Behaviour driven specificatie en tests
Het doel is:
- functionele werking van de api specificeren en illustreren
- test om een provider van de API te testen

## Opbouw van de functionele specificaties
De specificaties zijn opgebouwd per functionalteit van de API. Op elke functionaliteit van de API is de werking beschreven én is de werking geïllustreerd in de vorm van scenario's (als ik dit doe, dan doet de api dat).

Voor het zoeken van personen zijn de volgende functionaliteiten beschreven:
- Zoeken vindt standaard [alleen personen die nog in leven zijn](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/overleden_personen.feature), gebruik anders parameter inclusiefoverledenpersonen
- [Validatie van parameters](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/parametervalidatie.feature) in een API aanroep
- Mogelijke [combinaties van parameters](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/parametercombinaties.feature) die minimaal vereist zijn
- Gebruik van een [wildcard](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/wildcard.feature) op bepaalde parameters
- Zoeken op een parameterwaarde is [case-insensitive](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/case_insensitive.feature) wanneer de parameter een string is
- Zoeken met [diakrieten](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/diakrieten_in_parameter.feature)

Voor het samenstellen van het antwoord op een zoekvraag of het raadplegen van een persoon zijn de volgende functionaliteiten beschreven:
- Samenstellen van de [aanschrijfwijze](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/aanschrijfwijze.feature)
- Samenstellen en interpreteren van gegevens die [in onderzoek](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/in_onderzoek.feature) zijn
- [Mogelijk onvolledige datums](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/onvolledige_datum.feature)
- [Links](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/links.feature) naar relaties
- [Links naar historie-resources](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/historie_links.feature) van de persoon
- Alleen opnemen van [actuele partners, kinderen en ouders](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/partners_ouders_kinderen.feature)

Voor het ophalen van historie is de volgende functionaliteit beschreven:
- Bepalen van het moment of de periode waarover historie wordt gevraagd *TODO*

Voor ophalen van historie en het samenstellen van het antwoord daarop geldt ook:
- [Validatie van parameters](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/parametervalidatie.feature) in een API aanroep
- Zoeken op een parameterwaarde is [case-insensitive](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/case_insensitive.feature) wanneer de parameter een string is
- Mogelijk onvolledige datums *TODO*
- Gebruik [fields](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/fields.feature) om een deel van de attributen in het antwoord te krijgen

Voor het ophalen van de historie van bewoningen kan bovendien [expand](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/expand.feature) gebruikt worden om gegevens van de bewoners in het antwoord mee te laden.

Voor het samenstellen van het antwoord op historie-collectie is de volgende functionaliteit beschreven:
- [Sorting](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/historie_sorteren.feature) van historische voorkomens *TODO*

 Voor het manipuleren van de omvang van het antwoord zijn de volgende functionaliteiten beschreven:
 - Gebruik [fields](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/fields.feature) om een deel van de attributen in het antwoord te krijgen
 - Gebruik [expand](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/features/expand.feature) om een sub-resource (partners, ouders, kinderen) in het antwoord mee te laden

 Er is ook functionaliteit beschreven over de foutafhandeling. *TODO*

## Features en scenario's
De specificatie/test is gespecificeerd in documenten per functionaliteit, elk met extensie ".feature". Per functionaliteit is een korte beschrijving van de functionaliteit opgenomen plus scenario's die de gewenste werking van de functionaliteit toelichten en demonstreren.

De specificatie/test is functioneel gedefinieerd in [Gherkin](https://docs.cucumber.io/gherkin/reference/). Hiermee kan in menselijke taal de specificatie/test worden opgesteld.
De specificatie is in de *Nederlandse taal* gedefinieerd.

Structuur wordt aangegeven via de sleutelwoorden "Functionaliteit", "Achtergrond", "Scenario", "Gegeven", "Als", "Dan" en "En", "Abstract Scenario" en "Voorbeelden".

| Sleutelwoord      | Engels equivalent | Betekenis                                   |
| ----------------- | ----------------- | ------------------------------------------- |
| Functionaliteit   | Feature           | Beschrijft de te testen functionaliteit     |
| Achtergrond       | Background        | Precondities die voor de hele test gelden   |
| Scenario          | Scenario          | Samenhangende groep teststappen             |
| Gegeven           | Given             | Preconditie die voor het scenario geldt     |
| Als               | When              | Teststap die de actie beschrijft            |
| Dan               | Then              | Teststap die de controle beschrijft         |
| En                | And               | Aanvullende teststap op Gegeven, Als of Dan |
| Abstract Scenario | Scenario Outline  | Scenario sjabloon die gevallen uit voorbeelden doorloopt |
| Voorbeelden       | Examples          | Tabel met testwaarden die met Abstract scenario worden doorlopen |

De Gherkin testscenario's worden opgenomen in de map /features. Voor elke functionaliteit wordt een bestand gemaakt met als extensie ".feature". Per functionaliteit (feature-bestand) kunnen er meerdere scenario's zijn gedefinieerd om de betreffende functionaliteit.

## Tests
Deze manier van specificeren maakt het mogelijk om te worden uitgevoerd als geautomatiseerde test van de API. Met deze opzet van de specificatie/test wordt [Behaviour Driven Development (BDD)](https://docs.cucumber.io/bdd) ondersteund.

De test helpt erbij dat:
* aangetoond wordt dat de referentie-implementatie van de provider voldoet aan de standaard
* een leverancier van een/de provider kan testen dat zijn applicatie voldoet aan de standaard
* de test gebruikt kan worden voor een compliancy test op de standaard
* de beheerder(s) van de standaard en belanghebbenden de dekking van de test kunnen begrijpen
* developers van een client kunnen zien hoe de API werkt/moet werken in verschillende grenssituaties en foutsituaties

De implementatie van de testuitvoering is gebouwd in [Behave](https://behave.readthedocs.io/en/latest/). Behave is een Python implementatie van [Cucumber](https://cucumber.io). De implementatie wordt gemaakt in /features/steps/steps.py.

*N.B. Op dit moment is slechts een (klein) deel van de specificatie geimplementeerd als uitvoerbare test met Behave.*

### Requirements
Om de test uit te kunnen voeren moeten de volgende requirements zijn ingevuld:
* Python 2.7
* [Behave](https://behave.readthedocs.io/en/latest/install.html)
* [Requests](http://docs.python-requests.org/en/v1.0.0/user/install/)

### Testdata
Een aantal testscenario's veronderstelt testdata in de provider (in de scenario's noemen we deze 'de registratie').
Deze uitgangssituatie(s) gedefinieerd in "Background" of "Gegeven" zijn in de test niet geautomatiseerd. Vóór de start van de testuitvoering moet ervoor gezorgd worden dat de juiste testdata in de te testen API-providerapplicatie aanwezig is.
De test veronderstelt ook dat de verwachte resultaten op (pagina 1 van) de zoekvraag terugkomt. Er mag dus niet (significant) meer data zijn die aan de zoekvragen voldoet dan in de test is beschreven.

### testuitvoering
In steps/config.py kan de base url van de api worden gewijzigd.
De test wordt vanuit de basis map (/test) uitgevoerd met de opdracht "behave --lang nl". Er zijn een aantal mogelijkheden dit te verfijnen, bijvoorbeeld door "behave --lang nl --format progress2" toont alleen details van gefaalde scenario's.
