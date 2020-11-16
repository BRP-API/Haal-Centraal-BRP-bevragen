---
layout: page-with-side-nav
title: Definition of Done
---
# Definition of Done
- er is zijn BDD-scenario's (functionele specificatie cq testgevallen)
- er is een Open API specificatie (versie 3)
- er is beoordeeld op optimale code generatie
- er is een referentie-implementatie

Geen onderdeel van de definition of done tijdens het project, wel onderdeel van de vastgestelde koppelvlakstandaard zijn:
- er is een compliancy- en testvoorziening
- er is een backlog
- er is een 'getting started' beschrijving

## Open API specificaties
- Opgesteld in Open API Specification 3
- Gepubliceerd op GitHub
- Swagger UI toont de API specificaties correct en zonder fouten
- Genereervariant in yaml en json op GitHub
- Code gevalideerd met Spectral lint, inclusief validatie op Haal Centraal ontwerprichtlijnen
- Mapping op LO-GBA is duidelijk, juist en hierop getoetst
- Semantische betekenis van resources en parameters is opgenomen
- Voldoet aan NL API strategie, dan wel afwijking is beargumenteerd in de design decisions (pas toe of leg uit)

## Gegenereerde code
- Code gegenereerd uit de API specificaties voor ten minste Java en .Net
- De gegenereerde code is gecontroleerd op:
  - Compleetheid: alle operaties, en daarbinnen alle gegevens zijn correct overgenomen
  - Efficiëntie: de gegenereerde bevat geen onnodige dubbelingen in code
  - Eenvoud: de gegenereerde code bevat geen onnodig complexe constructies

## backlog
- er is een lijst met bekende fouten, gewenste verbeteringen, gewenste uitbreidingen

## getting started
- er is een beschrijving die developers op weg helpt om te starten met implementatie van het koppelvlak
- bevat verwijzing naar relevante koppelvlakproducten en gerelateerde informatie en standaarden
- er is uitleg en installatie-instructies van de referentie-implementaties
- er is uitleg over hoe bij te dragen aan de standaard
- er is uitleg over hoe mee ontwikkeld kan worden aan de referentie-implementatie(s), inclusief gebruik van relevante tooling
- enkele relevante testgevallen op de referentie-implementatie zijn benoemd

## Referentie-implementatie
- Implementeert alle gedefinieerde operaties en functionaliteit
- Is volledig functionele applicatie die de implementatie en gebruik van de koppelvlakken demonstreert
- Implementeert ten minste alle beschreven ontwerpbeslissingen
- Een testset die de functionaliteit en correcte werking van de referentie-implementatie aantoont
- Implementatie bevat testdata zodat gebruikers van de referentie-implementatie deze gebruiken om hun applicatie te testen
- Documentatie van de referentie-implementatie beschrijft (ten minste) installatie en gebruik van de applicatie
