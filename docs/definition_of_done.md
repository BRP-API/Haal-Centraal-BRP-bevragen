# Definition of Done
- er is een functionele specificatie
- er is een Open API specificatie (versie 3)
- er is gegenereerde code
- er zijn testgevallen beschreven
- er is een referentie-implementatie

Geen onderdeel van de definition of done tijdens het project, wel onderdeel van de vastgestelde koppelvlakstandaard zijn:
- er is een compliancy- en testvoorziening
- er is een backlog
- er is een 'getting started' beschrijving

## Functionele Specificatie
- Is gepubliceerd op GEMMAonline als webpagina(s)
- De positionering van de koppelvlakstandaard binnen de GEMMA architectuur is beschreven
- De referentiecomponenten die het koppelvlak moeten realiseren zijn beschreven
- Per referentiecomponent verplicht dan wel optioneel te leveren (als provider) of te gebruiken (client) services en operaties om compliant aan de standaard te zijn
- Beschrijving van de mapping van de zoekpaden (RSGB-bevragingen 1.0) naar de in dit koppelvlak beschreven API(s).

## Open API specificaties
- Opgesteld in Open API Specification 3
- Gepubliceerd op GitHub en op SWAGGERhub
- Mapping op RSGB 3 objecttypen en attributen is duidelijk, juist en hierop getoets
- Semantische betekenis van resources en parameters is opgenomen
- Voldoet aan DSO API strategie en DSO URI strategie, dan wel afwijking is beargumenteerd (pas toe of leg uit)

## Gegenereerde code
- Code is gegenereerd uit de API specificaties of de json schema's
- Code is gegenereerd voor ten minste Java en .Net
- De gegenereerde code is gecontroleerd op:
  - Compleetheid: alle operaties, en daarbinnen alle gegevens zijn correct overgenomen
  - Efficiëntie: de gegenereerde bevat geen onnodige dubbelingen in code
  - Eenvoud: de gegenereerde code bevat geen onnodig complexe constructies

## testgevallen
- Er zijn testgevallen beschreven voor alle beschreven opvraagfunctionaliteit
- Er zijn testgevallen beschreven voor elke ontwerpbelissing
- Elk testgeval beschrijft het logische testgeval, de teststap(pen) (wat wordt gedaan) en het verwachte resultaat
- Voor zover nodig is ook de testdata beschreven die wordt gebruikt in de testgevallen

## backlog
- er is een lijst met bekende fouten, gewenste verbeteringen, gewenste uitbreidingen

## getting started
- er is een beschrijving die developers op weg helpt om te starten met implementatie van het koppelvlak
- bevat verwijzing naar relevante koppelvlakproducten en gerelateerde informatie en standaarden
- er is uitleg en installatie-instructies van de referentie-implementaties
- er is uitleg over hoe bij te dragen aan de standaard
- er is uitleg over hoe mee ontwikkeld kan worden aan de referentie-implementatie(s), inclusief gebruik van relevante tooling

## Referentie-implementatie
- Implementeert alle gedefinieerde operaties en functionaliteit
- Is volledig functionele applicatie die de implementatie en gebruik van de koppelvlakken demonstreert
- Implementeert ten minste alle beschreven ontwerpbeslissingen
- Source code is open source beschikbaar (gepubliceerd) op VNG Realisatie Github
- Een testset die de functionaliteit en correcte werking van de referentie-implementatie aantoont
- Implementatie bevat testdata zodat gebruikers van de referentie-implementatie deze gebruiken om hun applicatie te testen
- Documentatie van de referentie-implementatie beschrijft (ten minste) installatie en gebruik van de applicatie

## Compliancy en testen
- Er zijn voorbeeldberichten voor elke service/operatie
- Er zijn compliancy tests beschikbaar voor elke referentie-component (consumers en providers) en alle betreffende services en operaties, zodat leveranciers kunnen testen en aantonen dat hun applicatie voldoet aan de standaard
- De compliancy testvoorziening levert, bij succesvolle uitvoering, een rapport dat kan worden gebruikt om in de Softwarecatalogus de compliancy aan te tonen.
