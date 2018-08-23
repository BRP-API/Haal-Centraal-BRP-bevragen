# Productvisie RSGB-bevragingen

## Introductie
Voor de beweging richting gegevenslandschap is er behoefte aan API’s voor het bevragen van gegevens bij de bron.

### Toegevoegde waarde voor gemeenten
- Kortere doorlooptijd van het inrichten van nieuwe koppelingen (plug and play is veelgehoorde wens)
- Lagere ontwikkelkosten van koppelingen
- Lagere beheerkosten door backwards compatibiliteit (wijzigingen in de standaard leiden meestal niet tot aanpassingen in bestaande koppelingen)
- Voorkomen lock-in door echt uitwisselbare componenten
- Hogere kwaliteit van de standaard doordat deze in de praktijk en met medewerking van gemeenten en leveranciers is ontwikkeld. En ook door parallel aan de standaard een werkende referentie-implementatie te ontwikkelen
- Een herbruikbare, plug and play API waarmee in apps en applicaties de persoonsgegevens  consistent gebruikt kunnen worden

### Toegevoegde waarde voor leveranciers
- Lagere ontwikkelkosten van het koppelvlak
- Kunnen zich onderscheiden op onderdelen die burgers, bedrijven en medewerkers
raken (i.p.v. te concurreren op infrastructuur)

### Toegevoegde waarde voor VNG Realisatie
- Beheer van de standaard is eenvoudiger doordat aanpassingen gemakkelijker zijn door te voeren
- Kwaliteitscontrole van koppelvlakken van leveranciers is eenvoudiger en daarmee goedkoper.
- Backwards compatibiliteit is eenvoudiger te behouden

## Context
VNG en gemeenten hebben een beweging in gang gezet richting het ‘samen organiseren’, een ‘common ground’ en een gegevenslandschap. Deze ontwikkelingen hebben belangrijke gevolgen voor de gemeentelijke gegevens- en berichtenstandaarden.

Sterk verbonden, en deels afgeleid van de beweging naar een gegevenslandschap, is een andere manier van gegevens ontsluiten, waarbij een beweging wordt gemaakt van op StUF gebaseerde berichtenstandaarden naar API’s.

Bij VNG Realisatie en gemeenten is in de afgelopen jaren een ontwikkeling in gang gezet naar andere koppelvlakstandaarden en een andere manier om koppelvlakstandaarden te ontwikkelen:
- [Visie op standaarden](https://www.gemmaonline.nl/images/gemmaonline/3/31/20171124_KING_Visie_op_Standaarden.pdf)
- [Visie op ontwikkelen en beheer van standaarden voor gegevens- en berichtmodellen](https://www.gemmaonline.nl/images/gemmaonline/b/bd/Ag_5_Visie_op_ontwikkelen_en_beheer_van_standaarden_voor_gegevens_en_berichtmodellen.pdf)
- [Transitie naar een gegevenslandschap](https://www.gemmaonline.nl/images/gemmaonline/0/01/Ag_4_Transitie_naar_een_gegevenslandschap.pdf)
- [Visie op criteria voor familie van standaarden](https://www.gemmaonline.nl/images/gemmaonline/7/70/Regiegroep_20180404_Agendapunt_5_Criteria_voor_familie_van_standaarden.pdf)

## Productvisie
In algemene zin moet een standaard bijdragen aan interoperabiliteit, kostenreductie, het bevorderen van marktwerking en innovatie bij gemeenten.
Dit specifieke koppelvlak heeft tot doel om op eenvoudige wijze invulling te geven aan de informatiebehoefte van binnengemeentelijke afnemers en hun ketenpartners wanneer zij kern- en basisgegevens zoeken en raadplegen via een stelselvoorziening. Het koppelvlak moet een passende oplossing bieden voor de communicatie met zowel (legacy) processystemen als mobiele devices.

De functionaliteit die in deze koppelvlakspecificatie is beschreven streeft ernaar om invulling te geven aan 80% van de behoefte van deze afnemers bij zoeken en raadplegen van de kern- en basisgegevens in het Referentiemodel. Hiermee wordt bedoeld dat incidenteel gebruikte zoekpaden niet zijn opgenomen, maar ook dat een eerste versie van deze standaard mogelijk niet compleet is. Het is mogelijk dat niet alle door gemeenten gewenste functionaliteit door gemeenten is aangedragen.

De specificaties zijn zo ondubbelzinnig mogelijk beschreven om API definities te realiseren die interoperabiliteit garanderen, compliancy meetbaar maken en leveranciers en gemeenten inzicht te geven in wat zij kunnen verwachten van een applicatie die zich aan deze standaard conformeert.

De te ontsluiten gegevens zijn beschreven in het Referentiemodel Stelsel van Gemeentelijke Basisgegevens (RSGB) versie 3.0. Bij het bepalen van de scope van de in deze standaard te zoeken en te raadplegen gegevens zijn de volgende principes gehanteerd:
- de basisgegevens die onderdeel uitmaken van het RSGB MOETEN met behulp van dit koppelvlak kunnen worden geraadpleegd. Hergebruik van deze basisgegevens is immers bij wet verplicht.
- Voor de gegevens die geen onderdeel uit maken van het stelsel van basisregistraties (basisgegevens) geldt dat er concrete vraag naar deze gegevens MOET zijn bij binnengemeentelijke afnemers of ketenpartners bij het gebuik van het referentiecomponent. Denk hierbij bijvoorbeeld aan de verstrekking van gegevens over BUURT en WIJK.
RSGB gegevens die relevant zijn voor bijvoorbeeld het synchroon houden van de basisgegevens van de binnengemeentelijke afnemer, maar niet door afnemers worden gebruikt bij rechtstreekse bevraging, maken geen onderdeel uit van deze koppelvlakstandaard.

De koppelvlakstandaard “RSGB Bevragingen” bestaat uit een aantal modulen (deelverzamelingen). De modulen zijn de ‘eenheid van levering en compliancy’.
a. Voor applicaties die de provider-rol invullen wil dat zeggen dat een applicatie alle services/operaties die in een module zijn opgenomen MOET ondersteunen.
b. Voor applicaties die de consumer-rol invullen mag per service/operatie worden aangegeven of deze wordt ondersteund.

We onderkennen de volgende modules:
-	Module ingeschreven personen
-	Module maatschappelijke activiteiten
-	Module vestiging
-	Module Ingeschreven Niet-Natuurlijk Persoon
-	Module adressen en gebouwen
-	Module kadastrale onroerende zaken
- Module buurt
- Module wijk

## RESTful
... Hoe RESTful?
- Altijd volledige resource (response op een collectie van resources == response op enkele resource)
- Alleen linked data of ook embedded van gerelateerde resources?

## Scope
De koppelvlakstandaard ondersteunt het zoeken naar een beperkte hoeveelheid voorkomens van basisgegevens. Uitgebreidere informatie van een specifiek informatieobject kan worden opgevraagd door het gewenste informatieobject te selecteren en te raadplegen.
Het uitvoeren van selecties met als doel het opleveren van een grote hoeveelheid informatieobjecten of het het doen van business intellligence analyses is buiten scope geplaatst, omdat een koppelvlak als dit zich hier minder goed voor leent.

In de ontwikkeling van versie 2.0 van de koppelvlakstandaard RSGB-bevragingen wordt dezelfde functionaliteit ingevuld als in versie 1.0 is ingevuld.

## Uitgangspunten
- Inhoudelijk startpunt voor de bevragingen zijn de geïnventariseerde vragen die zijn opgesteld door de werkgroep RSGB bevragingen en vastgelegd in standaard RSGB-bevragingen 1.0.
- Startpunt voor informatiemodellen van gegevens in de berichten is RSGB 3.
- De wijze van specificeren en documenteren van de verschillende koppelvlakproducten volgt de manier waarin dat project [gemma-zaken](https://github.com/VNG-Realisatie/gemma-zaken) is/wordt gedaan
- De
[GEMMA 2 Architectuur](https://www.gemmaonline.nl/index.php/GEMMA_Architectuur)
en de
[GEMMA 2 standaarden](https://www.gemmaonline.nl/index.php/GEMMA_Gegevens-_en_berichtenarchitectuur)
(voor zover van toepassing) worden gevolgd.
- Daar waar GEMMA 2 nog niet (helemaal) in lijn is met Common Ground, wordt
Common Ground gevolgd.
- Daar waar GEMMA 2 niets voorschrijft worden
[Open Standaarden](https://www.forumstandaardisatie.nl/open-standaarden)
gevolgd.
- Alle code, documenten en specificaties die ontstaan in dit traject wordt Open
Source, gepubliceerd onder de
[EUPL licentie](https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12)
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
De verschillende modules adressen en gebouwen worden projectmatig ontwikkeld per domein (BRP, BRK, BAG, HR).

Elk deelproject doorloopt de volgende stappen:
-	Agile, in enkele sprints ontwikkelen en beproeven van de functionele en technische specificaties van de bevragings-API’s.
-	Consultatie van belanghebbenden leidend tot vaststelling van de eerste versie van de standaard.
-	Implementatie en in productie nemen van de API’s door de bronhouder (indien van toepassing) en bij enkele gemeentelijke applicaties (consumers van de API’s).

## Gerelateerde trajecten
Gedeeltelijk parallel aan de (eerste) deelprojecten voor RSGB-bevragingen wordt het project Zaak- Documentservices uitgevoerd. In dit project wordt ook de werkwijze voor het ontwikkelen en specificeren van een RESTful API koppelvlakstandaard uitgewerkt. De RSGB-bevragingen koppelvlakken volgen deze werkwijze. Wanneer blijkt dat aspecten van deze werkwijze slecht toepasbaar is of aanvulling nodig heeft, wordt dit teruggekoppeld naar het Zaak- Documentservices project.

Parallel aan het eerste deelproject RSGB-bevragingen (domein BRP) wordt een opdracht uitgevoerd tot het ontwikkelen van criteria voor een RESTful API koppelvlakstandaard, waarbij deze criteria ook worden geoperationaliseerd voor het meten van de kwaliteit van een koppelvlakstandaard op de criteria. De (tussen)resultaten van deze opdracht worden steeds direct in het RSGB-bevragingen BRP project toegepast en getoetst. In de volgende RSGB-bevragingen deelprojecten worden de ontwikkelde criteria gevolgd en de kwaliteit van de standaard gemeten op basis van de geleverde operationalisering.

Na (wellicht gedeeltelijk naast) de bevragingen API’s bij bronsystemen zullen er ook projecten worden gestart (planning: start in 2019) voor het realiseren van functionaliteit voor het notificeren van gebeurtenissen.
