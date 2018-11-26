# Productvisie Bevragingen ingeschreven personen

## Introductie
Voor de beweging richting gegevenslandschap is er behoefte aan API’s voor het bevragen van gegevens bij de bron. Op korte termijn is er daarbij grote behoefte aan het kunnen bevragen van persoonsgegevens. Dit koppelvlak beschrijft een API voor het zoeken en opvragen van ingeschreven  personen.

## Context
In 2017 is koppelvlakstandaard [RSGB-bevragingen 1.0](https://www.gemmaonline.nl/index.php/RSGB_Bevragingen) ontwikkeld en vastgesteld, met daarin een aantal geïnventariseerde vragen op RSGB. Deze versie is gebaseerd op informatiemodel RSGB 2.0. Technisch bestaat deze standaard uit een SOAP/XML (niet StUF) variant en een RPC/JSON variant.

Inmiddels is er bij gemeenten behoefte ontstaan aan de architectuurontwikkeling [Common Ground](https://vng.nl/samen-organiseren/common-ground). Als onderdeel van die ontwikkeling is er behoefte aan het direct bij de bron kunnen bevragen van gegevens, in plaats van het distribureren en kopiëren van gegevens over veel verschillende gemeentelijke systemen. Daarom worden er afspraken gemaakt met de bronhouders (landelijke voorzieningen en basisregistraties), bijvoorbeeld het Kadaster voor BAG en BRK en Kamer van Koophandel voor HR) voor het ontsluiten van de gegevens.

Hierbij hoort ook een transitie naar moderne uitwisseltechnieken en -architectuurstijlen (in dit geval RESTfull API's op basis van JSON). We streven voor de uitwisseltechnieken naar het bewegen richting één overheidsbrede API strategie. Het startpunt hiervoor is de [DSO API strategie](https://aandeslagmetdeomgevingswet.nl/digitaal-stelsel/documenten/documenten/api-uri-strategie/).

In 2018 is er een pilot gedaan met de gemeente Den Haag en het Kadaster voor het direct bevragen van BRK gegevens bij het Kadaster. In deze pilot is geconstateerd dat er verschillen zijn tussen de informatiemodellen van de bronregistratie (i.c. Kadaster) en het RSGB, dat tot dan toe als basis is gebruikt voor koppelvlakstandaarden. Hieruit is de conclusie getrokken het informatiemodel van de bronregistratie te gebruiken als basis van de te ontwikkelen API's en RSGB niet te gebruiken. Voor bevragingen op persoonsgegevens wordt hiervoor LO GBA 3.10 gebruikt.

Vanuit VNG Realisatie, en op verzoek van verschillende gemeenten, is ook de manier waarop koppelvlakstandaarden worden ontwikkeld aangepast. Een meer agile aanpak, waarbij direct getoetst wordt op een aantal criteria, met name met betrekking tot de eenvoud van implementatie voor developers van clientsapplicatie. Het ontwikkelen van test- of referentie-implementaties maakt direct onderdeel uit van het ontwikkelen van API-standaarden.
Hiertoe is in de afgelopen jaren een aantal notities geschreven die deze visie en ontwikkelingen beschrijven:
- [Visie op standaarden](https://www.gemmaonline.nl/images/gemmaonline/3/31/20171124_KING_Visie_op_Standaarden.pdf)
- [Visie op ontwikkelen en beheer van standaarden voor gegevens- en berichtmodellen](https://www.gemmaonline.nl/images/gemmaonline/b/bd/Ag_5_Visie_op_ontwikkelen_en_beheer_van_standaarden_voor_gegevens_en_berichtmodellen.pdf)
- [Transitie naar een gegevenslandschap](https://www.gemmaonline.nl/images/gemmaonline/0/01/Ag_4_Transitie_naar_een_gegevenslandschap.pdf)
- [Visie op criteria voor familie van standaarden](https://www.gemmaonline.nl/images/gemmaonline/7/70/Regiegroep_20180404_Agendapunt_5_Criteria_voor_familie_van_standaarden.pdf)

## Productvisie
In algemene zin moet een standaard bijdragen aan interoperabiliteit, kostenreductie, het bevorderen van marktwerking en innovatie bij gemeenten.

### API standaard
Wat hier wordt ontwikkeld is een API standaard. Meerdere leveranciers en gemeenten gebruiken deze standaard als specificatie voor het implementeren van de API en voor het implementeren van clients die de API gebruiken.
Deze API-standaard heeft tot doel om op eenvoudige wijze invulling te geven aan de informatiebehoefte van binnengemeentelijke afnemers en hun ketenpartners wanneer zij basisgegevens van ingeschreven personen zoeken en raadplegen.

De specificaties zijn zo ondubbelzinnig mogelijk beschreven om API definities te realiseren die interoperabiliteit garanderen, compliancy meetbaar maken en leveranciers en gemeenten inzicht te geven in wat zij kunnen verwachten van een applicatie die zich aan deze standaard conformeert.

Het koppelvlak moet een passende oplossing bieden voor de communicatie met zowel (legacy) processystemen als mobiele devices.

### Bron van persoonsgegevens
Op termijn streven we ernaar persoonsgegevens te ontsluiten vanuit één landelijke voorziening. De api wordt zodanig ontworpen dat deze op termijn door een landelijke voorziening GBA-V gebruikt kan worden. Tot de api geleverd wordt door een landelijke voorziening, kan deze geleverd worden door locale GBA-administratie(s) of een lokaal gegevensmagazijn. In elke van deze situaties moet de api provider opereren als was het de authentieke bron van de gegevens.

Dit betekent dat se door de api te leveren gegevens worden beperkt tot die gegevens waarvan de gegevensbron de (authentieke) bronhouder is.
- Van gegevens waarvoor een bronregistratie niet de bronhouder is, wordt enkel een identificerend attribuut overgenomen wat gebruikt kan worden voor het ophalen van de gerealteerde gegevens uit de bronregistratie van de betreffende gegevens. Bijvoorbeeld de nummeraanduiding van het verblijfadres van een persoon.
- Gegevens waarvoor een bronregistratie niet de bronhouder is kunnen gebruikt worden als zogenaamd ‘comfortgegeven’. Comfortgegevens worden door een registratie redundant bijgehouden met als doel het zo efficient mogelijk uit kunnen voeren van bevragingen. Denk bijvoorbeeld aan de redundante adresgegevens van personen. Deze kunnen worden gehanteerd om daarmee het zoeken op een adres van bijvoorbeeld een zakelijk gerechtigde eenvoudig mogelijk te maken. Bijvoorbeeld postcode en huisnummer van de verblijfplaats van een persoon.
- Personen die bij de api bekend zijn vanuit een andere registratie dan het GBA (bijv. vanuit HR of BRK) worden niet geleverd door de api.
- Gemeentelijke kerngegevens worden niet geleverd door de api. Bijvoorbeeld correspondentieadres en e-mail adres van een persoon.

## Omvang en structuur van de API standaard
De API standaard bestaat uit twee API specificaties. Een API (specificatie) betreft het zoeken en raadplegen van actuele gegevens. De tweede API (specificatie) betreft het raadplegen van historie van de persoonsgegevens.

De leverancier van een softwarepakket kan kiezen voor het ondersteunen van één of van beide API specificaties. Bijvoorbeeld de leverancier van een gegevensmagazijn kan aangeven wel de API voor actuele gegevens te ondersteunen, maar niet de API voor historische gegevens.
- Voor applicaties die de provider-rol invullen wil dat zeggen dat een applicatie alle services/operaties die in een API specificatie zijn opgenomen MOET ondersteunen en alle beschreven gegevens moet kunnen leveren.
- Een applicatie die de API gebruikt in de rol van API client (consumer):
    - mag per operatie aangegeven of deze wordt ondersteund;
    - hoeft niet alle beschreven query-parameters te ondersteunen;
    - hoeft niet alle teruggeleverde gegevens te verwerken.

## Scope
In de ontwikkeling van deze koppelvlakstandaard wordt (minimaal) de zoek- en opvraagfunctionaliteit ingevuld zoals die is beschreven in de koppelvlakstandaard RSGB-bevragingen versie 1.0, module ingeschreven personen. Dit betekent dat door de API minimaal de functionaliteit moet worden geleverd die is beschreven in services van deze module.
Ten opzichte van koppelvlakstandaard RSGB-bevragingen 1.0 wordt nadrukkelijk de koppeling van de json API's met de SOAP/XML variant losgelaten. Dit is dus *geen* eis (sterker: uitgangspunt van een RESTful API leidt tot afwijken van de SOAP/XML API's van RSGB-bevragingen 1.0).

Dit koppelvlak beschrijft het bevragen van ingeschreven personen, zowel ingezeten (RNI) als niet-ingezeten personen (GBA).

### Buiten Scope
Niet ingeschreven personen worden niet ontsloten, anders dan in de rol van partner, ouder of kind van een ingeschreven persoon.

Het uitvoeren van selecties met als doel het opleveren van een grote hoeveelheid informatieobjecten of het doen van business intelligence analyses is buiten scope geplaatst, omdat een koppelvlak als dit zich hier minder goed voor leent.

[Fuzzy search](https://en.wikipedia.org/wiki/Approximate_string_matching), bijvoorbeeld ten behoeve van zoeksuggesties of vrije tekst zoeken maakt geen onderdeel uit van de API.

Bewerkingsdiensten (toevoegen, verwijderen en wijzigen van persoonsgegevens) maken geen deel uit van de API.

De API standaard beschrijft niet hoe identificatie, authenticatie, authorisatie van gebruikers of beveiliging van de verbinding moet worden ingevuld. Ook wordt niet beschreven hoe gemeenten voor de met de API geleverde gegevens moet voldoen aan de wet AVG. Wel is bij het ontwerp van de API rekening gehouden met een structuur van gegevensuitwisseling om te zorgen dat hieraan zo eenvoudig mogelijk kan worden voldaan.

## Uitgangspunten
- Hantering van het door de bronhouder vastgestelde informatiemodel voor modellering van API's, LO GBA 3.10.
- Hantering van de uitgangspunten van [Common Ground / het Gemeentelijk Gegevenslandschap](https://www.gemmaonline.nl/index.php/Thema_Samen_organiseren).
- Hantering van de binnen het [Kennisplatform API’s](https://www.geonovum.nl/themas/kennisplatform-apis ) beheerde API en URI strategie, of een daarvan afgeleid gemeentelijk profiel.
- Alle code, documenten en specificaties die ontstaan in dit traject wordt Open Source gepubliceerd onder de [EUPL licentie](https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12).
- Voor de specificatie van API's wordt de onlangs door Forum Standaardisatie op de ["Pas toe of leg uit"-lijst](https://www.forumstandaardisatie.nl/lijst-open-standaarden/in_lijst/verplicht-pas-toe-leg-uit) geplaatste
[OpenAPI Specification v3.x](https://www.forumstandaardisatie.nl/standaard/openapi-specification) gebruikt.

Een van de belangrijkste uitgangspunten voor de ontwikkeling van de API standaard is dat gebruik van de API zo duidelijk en eenvoudig mogelijk moet zijn. De API wordt dus zodanig ontworpen dat deze voor een developer van een API client zo makkelijk mogelijk te gebruiken is. Dit noemen we "developer first".

## Realisatie
De eerste versie van de API standaard wordt ontworpen in een project waarin verschillende gemeenten deelnemen, enkele developers, plus VNG-realisatie.

Alle API standaardisatieproducten worden vastgelegd en gedeeld in GitHub. Door de API te realiseren functionele wensen worden als user story omschreven als GitHUb-issue.

Eenieder die zich belanghebbende voelt mag reageren en bijdragen door:
- issues of user stories in te dienen
- opmerkingen te plaatsen in issues of pull requests
- pull requests in te dienen

De API specificaties worden daarnaast op SWAGGERhub geplaatst.

De [Definition of Done](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/docs/definition_of_done.md) beschrijft wat op welke manier, of in welke deliverables een user story minimaal moet zijn gerealiseerd.

Beslissingen die bij de uitwerking worden gemaakt, worden vastgelegd in de [ontwerpbeslissingen](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/docs/design_decisions.md).

Functionele specificaties worden behaviour driven beschreven. Dit betekent dat de gewenste werking van de API wordt beschreven in voorbeeldem, die ook uit te voeren zijn als (geautomatiseerde) test op een API-implementatie.

Tijdens het project wordt er nog geen volwaardige referentie-implementatie gemaakt. Na afloop van het project en (voorlopige) vaststelling van de standaard wordt wel een referentie-implementatie gemaakt.
Ook zal er tijdens het project nog geen compliancy-test worden geleverd. Wel worden testgevallen en testdata opgeleverd waarmee een API getest kan worden.

## Gerelateerde trajecten
Tijdens de ontwikkeling van dit koppelvlak worden ook criteria voor API koppelvlakken uitgewerkt, inclusief operationalisering van deze criteria, zodat ze bij koppelvlakontwikkeling kunnen worden getoetst.

Gedeeltelijk parallel aan, en volgend op de ontwikkeling van koppelvlak Bevragingen ingeschreven personen worden koppelvlakken voor de andere modules van RSGB-bevragingen ontwikkeld. Dit betreft koppelvlakken voor het opvragen van BRK-gegevens (Kadaster), HR-gegevens (Handelsregister) en BAG (adressen en gebouwen).

Ook wordt het project Zaak- Documentservices uitgevoerd. In dit project wordt ook de werkwijze voor het ontwikkelen en specificeren van een RESTful API koppelvlakstandaard uitgewerkt. De RSGB-bevragingen koppelvlakken volgen deze werkwijze. Wanneer blijkt dat aspecten van deze werkwijze slecht toepasbaar is of aanvulling nodig heeft, wordt dit teruggekoppeld naar het Zaak- Documentservices project.

Parallel aan het eerste deelproject RSGB-bevragingen (domein BRP) wordt een opdracht uitgevoerd tot het ontwikkelen van criteria voor een RESTful API koppelvlakstandaard, waarbij deze criteria ook worden geoperationaliseerd voor het meten van de kwaliteit van een koppelvlakstandaard op de criteria. De (tussen)resultaten van deze opdracht worden steeds direct in het RSGB-bevragingen BRP project toegepast en getoetst. In de volgende RSGB-bevragingen deelprojecten worden de ontwikkelde criteria gevolgd en de kwaliteit van de standaard gemeten op basis van de geleverde operationalisering.

Na (wellicht gedeeltelijk naast) de bevragingen API’s bij bronsystemen zullen er ook projecten worden gestart (planning: start in 2019) voor het realiseren van functionaliteit voor het notificeren van gebeurtenissen.
