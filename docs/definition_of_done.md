# Definition of Done
- er is een functionele specificatie
- er is een Open API specificatie (versie 3)
- er is gegenereerde code
- er is een referentie-implementatie
- er is een compliancy- en testvoorziening

## Functionele Specificatie
- Is gepubliceerd op GEMMAonline als webpagina(s)
- De positionering van de koppelvlakstandaard binnen de GEMMA architectuur is beschreven
- De referentiecomponenten die het koppelvlak moeten realiseren zijn beschreven
- Per referentiecomponent verplicht dan wel optioneel te leveren (als provider) of te gebruiken (client) services en operaties om compliant aan de standaard te zijn

## Open API specificaties
- Opgesteld in Open API Specification 3
- Gepubliceerd op GitHub en op SWAGGERhub
- Mapping op RSGB 3 objecttypen en attributen is duidelijk, juist en hierop getoets
- Semantische betekenis van resources en parameters is opgenomen
- Voldoet aan DSO API strategie en DSO URI strategie, dan wel afwijking is beargumenteerd (pas toe of leg uit)

## Gegenereerde code
- Code is gegenereerd uit de API specificaties of de json schema's
- Code is gegenereerd voor ten minste Java en .Net.
- De gegenereerde code is gecontroleerd op:
  - Compleetheid: alle operaties, en daarbinnen alle gegevens zijn correct overgenomen
  - Efficiëntie: de gegenereerde bevat geen onnodige dubbelingen in code
  - Eenvoud: de gegenereerde code bevat geen onnodig complexe constructies

## Referentie-implementatie
- Implementeert alle gedefinieerde operaties en functionaliteit
- Is volledig functionele applicatie die de implementatie en gebruik van de koppelvlakken demonstreert
- Source code is open source beschikbaar (gepubliceerd) op VNG Realisatie Github
- Een testset die de functionaliteit en correcte werking van de referentie-implementatie aantoont
- Implementatie bevat testdata zodat gebruikers van de referentie-implementatie deze gebruiken om hun applicatie te testen
- Documentatie van de referentie-implementatie beschrijft (ten minste) installatie en gebruik van de applicatie

## Compliancy en testen
- Er zijn voorbeeldberichten voor elke service/operatie
- Er zijn compliancy tests beschikbaar voor elke referentie-component (consumers en providers) en alle betreffende services en operaties, zodat leveranciers kunnen testen en aantonen dat hun applicatie voldoet aan de standaard
- De compliancy testvoorziening levert, bij succesvolle uitvoering, een rapport dat kan worden gebruikt om in de Softwarecatalogus de compliancy aan te tonen.
