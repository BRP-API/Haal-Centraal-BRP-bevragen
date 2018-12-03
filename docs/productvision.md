# Productvisie Bevragingen ingeschreven personen

## Introductie
Voor de beweging richting gegevenslandschap is er behoefte aan API’s voor het bevragen van gegevens bij de bron. Op korte termijn is er daarbij grote behoefte aan het kunnen bevragen van persoonsgegevens. Dit koppelvlak beschrijft een API voor het zoeken (filteren) en opvragen van ingeschreven natuurlijk personen.

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
- Kwaliteitscontrole van koppelvlakken van leveranciers is eenvoudiger en daarmee goedkoper
- Backwards compatibiliteit is eenvoudiger te behouden

## Context
In 2017 is koppelvlakstandaard [RSGB-bevragingen 1.0](https://www.gemmaonline.nl/index.php/RSGB_Bevragingen) ontwikkeld en vastgesteld, met daarin een aantal geïnventariseerde vragen op RSGB. Deze versie is gebaseerd op informatiemodel RSGB 2.0. Technisch bestaat deze standaard uit een SOAP/XML (niet StUF) variant en een RPC/JSON variant.

Inmiddels is er bij gemeenten behoefte ontstaan aan de architectuurontwikkeling [Common Ground](https://vng.nl/samen-organiseren/common-ground). Als onderdeel van die ontwikkeling is er behoefte aan het direct bij de bron kunnen bevragen van gegevens, inplaats van het distribureren en kopiëren van gegevens over veel verschillende gemeentelijke systemen. Daarom worden er afspraken gemaakt met de bronhouders (landelijke voorzieningen en basisregistraties), bijvoorbeeld het Kadaster voor BAG en BRK en Kamer van Koophandel voor HR) voor het ontsluiten van de gegevens.

Hierbij hoort ook een transitie naar actuele informatiemodellen, in dit geval de overgang naar RSGB 3, én naar moderne uitwisseltechnieken en -architectuurstijlen (in dit geval RESTfull API's op basis van JSON). We streven voor de uitwisseltechnieken naar het bewegen richting één overheidsbrede API strategie. Het startpunt hiervoor is de [DSO API strategie](https://aandeslagmetdeomgevingswet.nl/digitaal-stelsel/documenten/documenten/api-uri-strategie/).

In 2018 is er een pilot gedaan met de gemeente Den Haag en het Kadaster voor het direct bevragen van BRK gegevens bij het Kadaster. Naar aanleiding van constateringen uit deze pilot is/wordt RSGB 3 geactualiseerd, zodat het beter aansluit op de informatiemodellen en datamodellen van de bronnen waaruit gegevens worden bevraagd.
Voor het domein BRP (ingeschreven personen) is juist RSGB 3 aangepast naar het GBA model, aangezien de ontwikkeling van BRP is stopgezet.

Vanuit VNG Realisatie, en op verzoek van verschillende gemeenten, is ook de manier waarop koppelvlakstandaarden worden ontwikkeld aangepast. Een meer agile aanpak, waarbij direct getoetst wordt op een aantal criteria, met name met betrekking tot de eenvoud van implementatie. Het ontwikkelen van test- of referentie-implementaties maakt direct onderdeel uit van het ontwikkelen van koppelvlakken.
VNG en gemeenten hebben een beweging in gang gezet richting het ‘samen organiseren’, een ‘common ground’ en een gegevenslandschap. Deze ontwikkelingen hebben belangrijke gevolgen voor de gemeentelijke gegevens- en berichtenstandaarden.

Sterk verbonden, en deels afgeleid van de beweging naar een gegevenslandschap, is een andere manier van gegevens ontsluiten, waarbij een beweging wordt gemaakt van op StUF gebaseerde berichtenstandaarden naar API’s.

Bij VNG Realisatie en gemeenten is in de afgelopen jaren een ontwikkeling in gang gezet naar andere koppelvlakstandaarden en een andere manier om koppelvlakstandaarden te ontwikkelen. Hiertoe zijn er een aantal notities geschreven die deze visie en ontwikkelingen beschrijven:
- [Visie op standaarden](https://www.gemmaonline.nl/images/gemmaonline/3/31/20171124_KING_Visie_op_Standaarden.pdf)
- [Visie op ontwikkelen en beheer van standaarden voor gegevens- en berichtmodellen](https://www.gemmaonline.nl/images/gemmaonline/b/bd/Ag_5_Visie_op_ontwikkelen_en_beheer_van_standaarden_voor_gegevens_en_berichtmodellen.pdf)
- [Transitie naar een gegevenslandschap](https://www.gemmaonline.nl/images/gemmaonline/0/01/Ag_4_Transitie_naar_een_gegevenslandschap.pdf)
- [Visie op criteria voor familie van standaarden](https://www.gemmaonline.nl/images/gemmaonline/7/70/Regiegroep_20180404_Agendapunt_5_Criteria_voor_familie_van_standaarden.pdf)

## Productvisie
In algemene zin moet een standaard bijdragen aan interoperabiliteit, kostenreductie, het bevorderen van marktwerking en innovatie bij gemeenten.
Dit specifieke koppelvlak heeft tot doel om op eenvoudige wijze invulling te geven aan de informatiebehoefte van binnengemeentelijke afnemers en hun ketenpartners wanneer zij kern- en basisgegevens van ingeschreven natuurlijk personen kunnen zoeken en raadplegen. Het koppelvlak moet een passende oplossing bieden voor de communicatie met zowel (legacy) processystemen als mobiele devices.

De specificaties zijn zo ondubbelzinnig mogelijk beschreven om API definities te realiseren die interoperabiliteit garanderen, compliancy meetbaar maken en leveranciers en gemeenten inzicht te geven in wat zij kunnen verwachten van een applicatie die zich aan deze standaard conformeert.

De te ontsluiten gegevens zijn beschreven in het Referentiemodel Stelsel van Gemeentelijke Basisgegevens (RSGB) versie 3.0. Bij het bepalen van de scope van de in deze standaard te zoeken en te raadplegen gegevens zijn de volgende principes gehanteerd:
- de basisgegevens die onderdeel uitmaken van het RSGB MOETEN met behulp van dit koppelvlak kunnen worden geraadpleegd. Hergebruik van deze basisgegevens is immers bij wet verplicht.
- Voor de gegevens die geen onderdeel uit maken van het stelsel van basisregistraties (basisgegevens) geldt dat er concrete vraag naar deze gegevens MOET zijn bij binnengemeentelijke afnemers of ketenpartners bij het gebruik van het referentiecomponent.

RSGB gegevens die relevant zijn voor bijvoorbeeld het synchroon houden van de basisgegevens van de binnengemeentelijke afnemer, maar niet door afnemers worden gebruikt bij rechtstreekse bevraging, maken geen onderdeel uit van deze koppelvlakstandaard.

De koppelvlakstandaard “Bevragingen ingeschreven personen” is de ‘eenheid van levering en compliancy’ voor beschreven referentie-componenten.
- Voor applicaties die de provider-rol invullen wil dat zeggen dat een applicatie alle services/operaties die in het koppelvlak zijn opgenomen MOET ondersteunen en alle beschreven gegevens moet kunnen leveren.
- Voor applicaties die de consumer-rol invullen mag per service/operatie worden aangegeven of deze wordt ondersteund. Een applicatie die de consumer-rol invult hoeft niet alle beschreven query-parameters te ondersteunen en hoeft niet alle teruggeleverde gegevens te verwerken.

## Scope
In de ontwikkeling van deze koppelvlakstandaard wordt (minimaal) de zoek- en opvraagfunctionaliteit ingevuld zoals die is beschreven in de koppelvlakstandaard RSGB-bevragingen versie 1.0, module ingeschreven personen. Dit betekent dat minimaal de (combinaties van) zoekparameters die zijn beschreven in services van deze module ook mogelijk zijn met de API "Bevragingen ingeschreven personen". De definities van de antwoorden kunnen wel wijzigen.
Ten opzichte van koppelvlakstandaard RSGB-bevragingen 1.0 wordt nadrukkelijk de koppeling van de json API's met de SOAP/XML variant losgelaten. Dit is dus *geen* eis (sterker: uitgangspunt van een RESTful API leidt hoogst waarschijnlijk tot nadrukkelijk afwijken van de SOAP/XML API's van RSGB-bevragingen 1.0).

Dit koppelvlak beschrijft het bevragen van ingeschreven natuurlijk personen. Andere natuurlijk personen (niet ingeschreven) worden niet ontsloten, omdat die bij gemeenten niet centraal worden opgeslagen.

Het uitvoeren van selecties met als doel het opleveren van een grote hoeveelheid informatieobjecten of het doen van business intelligence analyses is buiten scope geplaatst, omdat een koppelvlak als dit zich hier minder goed voor leent.

[Fuzzy search](https://en.wikipedia.org/wiki/Approximate_string_matching), bijvoorbeeld ten behoeve van zoeksuggesties of vrije tekst zoeken maakt geen onderdeel uit van dit koppelvlak.

Dit koppelvlak beschrijft niet hoe identificatie, authenticatie, authorisatie of beveiliging moet worden ingevuld. Ook wordt niet beschreven hoe gemeenten voor de met de API geleverde gegevens moet voldoen aan de wet AVG.

## RESTful
In het project wordt de mate waarin de API strikt RESTful is bepaald. Uiteindelijk zijn de doelstellingen van de koppelvlakstandaard belangrijker dan het voldoen aan REST principes. Wel verwachten we dat voldoen aan REST principes een belangrijke bijdrage kan leveren in het voldoen aan de doelstellingen voor deze koppelvlakstandaard.

## Uitgangspunten
- Startpunt voor informatiemodellen van gegevens in de berichten is RSGB 3.00.01.
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
Per zoekpad (operatie) uit RSGB-bevragingen versie 1, module ingeschreven personen wordt een issue gemaakt. Deze issues worden achtereenvolgens gerealiseerd. Mogelijk kunnen meerdere zoekpaden worden opgelost in dezelfde API operaties.

Bij elk zoekpad worden alle deliverables beschreven in de [Definition of Done](https://github.com/VNG-Realisatie/RSGB-bevragingen/blob/master/docs/definition_of_done.md) gemaakt en getoetst (gevalideerd). De API specificaties worden gemaakt door een berichtontwerper en een developer in nauwe samenwerking en afstemming.

Alle deelproducten (deliverables) van het project (zoals API specificaties, functionele specificaties, ontwerpbeslissingen, gegenereerde code, test-implementaties) worden gepubliceerd op het GitHub project.
De API specificaties worden daarnaast op SWAGGERhub geplaatst.

Wekelijks is er een bijeenkomst waarin de voortgang en resultaten worden besproken. De feed back die uit dit overleg komt, plus feed back die via GitHub wordt gegeven vanuit andere belanghebbenden, wordt de week erna verwerkt door de berichtontwerper en developer.

Tijdens het project wordt er nog geen volwaardige referentie-implementatie gemaakt. Na afloop van het project en (voorlopige) vaststelling van de standaard wordt wel een referentie-implementatie gemaakt.
Ook zal er tijdens het project nog geen compliancy-test worden geleverd. Wel worden testgevallen en testdata opgeleverd waarmee een API getest kan worden.

## Terminologie
Binnen het project gebruiken we een aantal termen voor het API-ontwerp en de API werking. Hier worden enkele beschreven, zodat voor iedereen die bijdraagt aan de API-ontwikkeling begrijpt wat er hiermee bedoelt wordt.

### API
Wanneer we spreken over "API's", bedoelen we kleine, scherp gedefinieerde, voor een businessbehoefte doelmatige en voor consumers van de API/service eenvoudig te begrijpen en eenvoudig te implementeren webservices.

VNG-Realisatie ontwikkelt in dit project de API-specificatie, die wordt vastgesteld als standaard en op basis waarvan leveranciers en gemeenten de API kunnen implementeren.

De API die in dit project wordt gespecificeert is zoveel mogelijk RESTful en serialiseert berichtinhoud in json

### Resource
Onder Resources wordt in deze contect verstaan Web Resources. Een Resource is de weergave van de gegevens.

Tenzij expliciet anders aangegeven toont een resource de actuele toestand (status) van gegevens. Bijvoorbeeld wanneer de api ingeschreven personen wordt geraadpleegd, spreken we van een resource als de actuele gegevens van één persoon.

Een resource hoeft niet altijd equivalent te zijn aan een objecttype of in de werkelijkheid bestaand iets (zoals een persoon of gebouw). Bijvoorbeeld de resource bewoning toont welke personen op een adres wonen (of hebben gewoond).

### Collectie
Een collectie is een lijst resources. Wanneer gezocht wordt op eigenschappen van een resource, kunnen meerdere resources voldoen aan de zoekcriteria. De API geeft dan een lijst terug met resources. Bijvoorbeeld wanneer we zoeken op geslachtsnaam "Jansen", geeft de api een lijst ingeschreven personen terug met de geslachtsnaam "Jansen".

### Relatie
Een resource kan relaties hebben met andere resources. Bijvoorbeeld een persoon woont op een adres, heeft een partner, ouders en kinderen en een reisdocument. Dit zijn allemaal relaties van de persoon met andere reources.

### Link
We nemen een relatie op in het bericht als link. Een link is een verwijzing naar de gerelateerde resource, waarmee de gegevens van deze relatie direct kunnen worden opgehaald. Dit heeft de vorm van een uri (unique resource identifier). Bijvoorbeeld "https://www.voorbeeldgemeente.nl/brp/v1/ingeschrevenpersonen/555555021".

### Sub-resources
Wanneer de gerelateerde resource alleen bestaat in de context van de resource, noemen we dit een sub-resource.
Bijvoorbeeld voor een persoon is het huwelijk een sub-resource. Het huwelijk bestaat niet of heeft geen betekenis zonder de betreffende persoon.

### Embed en expand
Vaak wordt er vanuit één resource verwezen (gelinkt) naar andere resources. De RESTful manier om dit op te lossen is de verwijzing naar andere resources als URI op te nemen in een resource. Op basis hiervan kan de afnemer, indien gewenst, de gelinkte resources zelf opvragen. Dit is vergelijkbaar met “lazy loading” in een ORM oplossing: resources worden alleen opgehaald als ze nodig zijn.

In sommige gevallen, als de afnemer alle resources nodig heeft, is het efficiënter als de gerelateerde resources in één keer opgehaald worden. Dit is vergelijkbaar met “eager loading” patroon in een ORM-oplossing.

Bijvoorbeeld wanneer we van een persoon direct ook de partnergegevens nodig zijn, kan de gebruiker in één aanroep eigenschappen van de persoon én eigenschappen van het huwelijk/partnerschap in het antwoord opgenomen worden.

De gebruiker kan dit vragen door gebruik van de parameter **expand**.

Wanneer met de expand parameter is gevraagd om het meeladen van de relatie, wordt deze in het bericht opgenomen. De relatie wordt in het bericht opgenomen in element \_embedded. We spreken daarom ook over het **"embedden"** van de resource.

## Gerelateerde trajecten
Tijdens de ontwikkeling van dit koppelvlak worden ook criteria voor API koppelvlakken uitgewerkt, inclusief operationalisering van deze criteria, zodat ze bij koppelvlakontwikkeling kunnen worden getoetst.

Gedeeltelijk parallel aan, en volgend op de ontwikkeling van koppelvlak Bevragingen ingeschreven personen worden koppelvlakken voor de andere modules van RSGB-bevragingen ontwikkeld. Dit betreft koppelvlakken voor het opvragen van BRK-gegevens (Kadaster), HR-gegevens (Handelsregister) en BAG (adressen en gebouwen).

Ook wordt het project Zaak- Documentservices uitgevoerd. In dit project wordt ook de werkwijze voor het ontwikkelen en specificeren van een RESTful API koppelvlakstandaard uitgewerkt. De RSGB-bevragingen koppelvlakken volgen deze werkwijze. Wanneer blijkt dat aspecten van deze werkwijze slecht toepasbaar is of aanvulling nodig heeft, wordt dit teruggekoppeld naar het Zaak- Documentservices project.

Parallel aan het eerste deelproject RSGB-bevragingen (domein BRP) wordt een opdracht uitgevoerd tot het ontwikkelen van criteria voor een RESTful API koppelvlakstandaard, waarbij deze criteria ook worden geoperationaliseerd voor het meten van de kwaliteit van een koppelvlakstandaard op de criteria. De (tussen)resultaten van deze opdracht worden steeds direct in het RSGB-bevragingen BRP project toegepast en getoetst. In de volgende RSGB-bevragingen deelprojecten worden de ontwikkelde criteria gevolgd en de kwaliteit van de standaard gemeten op basis van de geleverde operationalisering.

Na (wellicht gedeeltelijk naast) de bevragingen API’s bij bronsystemen zullen er ook projecten worden gestart (planning: start in 2019) voor het realiseren van functionaliteit voor het notificeren van gebeurtenissen.
