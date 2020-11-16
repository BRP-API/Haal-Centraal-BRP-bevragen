---
layout: page-with-side-nav
title: Productvisie Haal Centraal BRP Bevragen
---
# Productvisie Haal Centraal BRP Bevragen

## Introductie
Doel van het programma Haal Centraal is om de verstrekking van basisgegevens aan binnengemeentelijke afnemers te outsourcen naar Landelijke Registraties (RvIG, Kadaster, KVK). Dit moet leiden tot een forse reductie van lokale kopieën bij gemeenten. 

In principe willen we voor iedere activiteit op een lokale kopie een Haal Centraal alternatief te bieden in de vorm van een API. We beginnen bij de meest gebruikte functie die een gemeentelijk gegevensmagazijn op dit moment te bieden heeft: het zoeken en raadplegen van ingeschreven natuurlijke personen. 

De API is ontworpen om door een Landelijke Registratie te worden aangeboden. RvIG is nog niet betrokken bij de tot stand koming van deze API. Gemeenten kunnen de API tijdelijk op het eigen gegevensmagazijn implementeren, totdat outsourcing naar een Landelijke Voorziening kan worden gerealiseerd. Zo kan al een deel van de voordelen worden behaald en de migratie naar volledige outsourcing versneld. 

### Toegevoegde waarde voor gemeenten
- sneller & goedkoper aansluiten door best mogelijke DX 
- lagere investeringen (geen lokale kopie/ gegevensmagazijn)
- lagere beheerkosten (geen beheer lokale kopieën)
- hogere ROI: hergebruik API Landelijke Registratie door alle gemeentelijke taakapplicaties
- betere technologie-business alignment (Landelijke Registratie voert sneller een wijziging door dan 355 afzonderlijke gemeenten)
- biedt ruimte voor focus op de businessvraag van afnemers (i.p.v. op betrouwbaarheid en actualiteit van lokale kopieën)
- maximale compliancy op de gemeentelijke softwaremarkt (aansluiting gemeente x = 100% herbruikbaar in gemeente y)

### Toegevoegde waarde voor leveranciers
- leveranciers kunnen zich richten op het bieden van toegevoegde waarde voor burgers, bedrijven en medewerkers en hun core domain i.p.v. plumbing concerns in supporting domains zoals het gebruik van basisgegevens. 

## Context
Haal Centraal is een G5 initiatief (Amsterdam, Rotterdam, Den Haag, Utrecht en Eindhoven). Het concept is getoetst in de BRK pilot van de gemeente Den Haag met het Kadaster op basis van de RSGB bevragingen standaard (voorloper BRP- en BRK-bevragen). De businesscase is gebaseerd op ervaringscijfers van de gemeente Den Haag en de softwareontwikkeling gedurende de pilot. 

## Productvisie

### Business driven 
Resourcedefinitie en functionaliteit op basis van de businessvraag van de grootste gemene infobehoefte van alle binnengemeentelijke afnemers van NL. 
Niet te verwarren met modelgedreven ontwikkeling (MDD). De API is weliswaar herleidbaar naar het LO GBA 3.10, zodat de realiseerbaarheid en semantiek van de API geborgd is, maar implementation bleed en tight coupling met provider implementatiedetails wordt voorkomen.

### Consumer first
Beleg de voordelen waar mogelijk bij de consumer (=binnengemeentelijke afnemer) vanwege de hefboomwerking: complexiteit bij de provider (1x), de voordelen in kosten en doorlooptijd bij de consumer (aantal binnengemeentelijke afnemers x 351)

### Developer first
Focus op bruikbaarheid voor de ontwikkelaar: AOS spec is getest op codegeneratie (Java, .NET meest gebruikt in gemeentelijke markt), ontwerpbeslissingen zijn getoetst op het effect op de code, maximale consistentie met andere Haal Centraal API’s en behaviour driven development (BDD) scenario's in Gherkin om het gedrag van de API te beschrijven.

### Contract first
…en niet development first. De API is agnostisch, vrij van implementatiedetails providersysteem en niet gevoelig voor wijzigen in systeemlogica bij de provider.

### Agnostisch
= zonder kennis van de consumer. De API moet door alle (in theorie 200 verschillende) gemeentelijke processen kunnen worden gebruikt die BRP gegevens nodig hebben.

### Geïmplementeerd 
VNG Realisatie zorgt voor een referentie-implementatie door de provider (onderdeel van definition of done). 

### Non functionals:
- supersnel
- schaalbaar
- betrouwbaar
- resilient

## Scope
Ontwerp o.b.v. een inventarisatie informatiebehoefte binnengemeentelijke afnemers van alle binnengemeentelijke afnemers van NL. Invulling van de informatiebehoefte wordt beperkt door de inhoud van het LO GBA 3.10.

## REST
De API is zo RESTful mogelijk, met het oog op maximale realisatie van de REST doelstellingen: performance, schaalbaarheid, eenvoud, aanpasbaarheid, zichtbaarheid, verplaatsbaarheid en betrouwbaarheid.  

## Landelijke API Strategie voor de Nederlandse overheid
Het project conformeert zich aan de Landelijke API strategie en levert een bijdrage aan de ontwikkeling van de landelijke API strategie voor de Nederlandse overheid.  
De landelijke API_strategie heeft op het moment van ontwikkelen van de HC-aapi's nog geen formele status. De check of de HC-api's aan de landelijke API-strategie voldoen is uitgevoerd op de versie die ter vaststelling is aangeboden aan het Forum Standaardisatie op (https://docs.geostandaarden.nl/api/vv-hr-API-Strategie-20200117/ ) 

## Uitgangspunten
- Alle ingredienten van de API zijn herleidbaar naar het LO GBA 3.10
- Alle code, documenten en specificaties die ontstaan in dit traject wordt Open
Source gepubliceerd onder de
[EUPL licentie](https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12).
- Voor de specificatie van API's wordt de onlangs door Forum Standaardisatie op
de
["Pas toe of leg uit"-lijst](https://www.forumstandaardisatie.nl/lijst-open-standaarden/in_lijst/verplicht-pas-toe-leg-uit)
geplaatste
[OpenAPI Specification v3.x](https://www.forumstandaardisatie.nl/standaard/openapi-specification)
gebruikt.
- De
[API en URI strategie](https://aandeslagmetdeomgevingswet.nl/digitaal-stelsel/documenten/documenten/api-uri-strategie/)
zoals opgesteld binnen het programma Digitaal Stelsel Omgevingswet worden waar
mogelijk toegepast.

## Realisatie
Van iedere informatiebehoefte van een binnengemeentelijke afnemer die bij ons bekend is wordt een issue (user story) gemaakt. Voor de meest voorkomende stories worden achtereenvolgens AOS3 specs en indien nodig BDD scenario's opgesteld en gerealiseerd. 

- OAS3 specs worden opgesteld door VNG Realisatie adviseur standaarden ism een developer. 
- OAS3 specs worden getoetst door een developer. 
- BDD scenario's worden beschreven door de PO, VNG Realisatie adviseur standaarden en de developer. 
- Refentie implementatie API wordt gerealiseerd door VNG Realisatie.

Alle deliverables worden gepubliceerd op het GitHub project. De API specificaties worden ook op SWAGGERhub geplaatst.
