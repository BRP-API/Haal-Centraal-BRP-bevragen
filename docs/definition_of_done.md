# Definition of Done

Onderdeel van de definition of done is toetsing van de operaties in de vorm van code genereren, bouwen van test-implementaties en implementatie door betrokken gemeenten/leveranciers.
Tijdens en na de sprints worden belanghebbenden betrokken om de kwaliteit te toetsen en verbeteren.
Aan het eind van elke sprint wordt een sprint review gehouden.

(Overgenomen uit ZDS project:)
- er is een functionele specificatie
- er is een Open API specificatie (versie 3)
- er is een referentieimplementatie
- er is een compliancy voorziening

- Functionele specificatie voldoet aan acceptatiecriteria en is gepubliceerd op GEMMAonline.nl
- AOS3 specificaties die voldoen aan acceptatiecriteria en zijn gepubliceerd op SWAGGERhub.com
- Referentie-implementatie voldoet aan acceptatiecriteria en is open source beschikbaar en gepubliceerd op GitHub.com
- Compliancy tests voldoen aan acceptatiecriteria en zijn beschikbaar voor alle referentiecomponenten

## Functionele Specificatie
- Is gepubliceerd op GEMMAonline als webpagina(s)
- Architectuur van het koppelvlak is beschreven binnen het kader GEMMA 2
- Architectuur past binnen de architectuur van Common Ground/gegevenslandschap en/of draagt bij aan de ontwikkeling in die richting
- De referentiecomponenten die het koppelvlak moeten realiseren zijn beschreven
- Per referentiecomponent verplicht dan wel optioneel te leveren (als provider) of te gebruiken (client) services en operaties om compliant aan de standaard te zijn

## Open API specificaties
- Opgesteld in Open API Specification 3
- Gepubliceerd op GitHub en op SWAGGERhub
- Mapping op RSGB 3 objecttypen en attributen is duidelijk en juist
- Semantische betekenis van resources en parameters is opgenomen
- Voldoet aan DSO API strategie en DSO URI strategie, dan wel afwijking is beargumenteerd (pas toe of leg uit)
- Op basis van de API specificaties

## Referentie-implementatie
- Implementeert alle gedefinieerde operaties en functionaliteit
- Is volledig functionele applicatie die de implementatie en gebruik van de koppelvlakken demonstreert
- Source code is open source beschikbaar (gepubliceerd) op VNG Realisatie Github
- Functionaliteit van de applicatie is getest
- Implementatie bevat testdata zodat gebruikers van de referentie-implementatie deze gebruiken om hun applicatie te testen

## Compliancytests
- Er zijn compliancy tests beschikbaar voor elke referentie-component en alle betreffende services en operaties, zodat leveranciers kunnen testen en aantonen dat hun applicatie voldoet aan de standaard
- De compliancy testvoorziening levert, bij succesvolle uitvoering, een rapport dat kan worden gebruikt om in de Softwarecatalogus de compliancy aan te tonen.
