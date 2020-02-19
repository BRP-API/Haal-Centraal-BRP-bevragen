# Design decisions
Dit document beschrijft ontwerpkeuzes die gemaakt zijn voor het ontwerpen en specificeren van de API's.

## Dynamische domeinwaarden worden in de response opgenomen met zowel de code als de omschrijving
Voor een element van een referentielijst-type, wordt in de response zowel de code als de omschrijving opgenomen. Dit betreft dynamische lijsten (tabellen) met een code en waarde, zoals "Tabel 32 Nationaliteitentabel" en "Tabel 36 Voorvoegselstabel".

*Ratio*
Garanderen dat verschillende systemen binnen en buiten de gemeente dezelfde (toestand) van de referentielijst kennen is duur, ingewikkeld en foutgevoelig.

*Kanttekening*
Als landelijk beheerde dynamische domeinwaarden ook daadwerkelijk landelijk beschikbaar gesteld worden (zoals de common groud gedachte wel beoogd) dan worden deze als resource ontsloten en dus als link (uri) opgenomen.

## Enumeraties worden in het bericht opgenomen als waarde.
In de API specificaties worden enumeratiewaarden opgenomen met de waarde, in de description wordt de bijbehorende code genoemd.

*Ratio*
Uitgangspunt binnen Common Ground is gebruik van gegevens, niet opslag van gegevens. Dus de omschrijving (uitgeschreven waarde) is relevant voor de gebruiker.
Waar waarde van de enumeratie te lang is wordt deze op een begrijpelijke wijze ingekort. 

## Enumeraties-waarden bevatten geen hoofdletters.
Enumeratiewaarden bevatten alleen kleine letters en underscores. Geen spaties, geen speciale tekenen en geen hoofletters.

*Ratio*
In sommige development-omgevingen leveren hoofletters, spaties of speciale tekens in enumeratie-waarden een probleem op met code-genereren. 

## Gemeentelijke kerngegevens en plusgegevens worden niet opgenomen in de resource.
In de response worden alleen gegevens opgenomen die in het BRP zitten.

*Ratio*
Deze gegevens zitten niet in een (voor alle gemeenten geldend) bronsysteem dat voor de bevraging geraadpleegd kan worden. Deze gegevens zijn dus (voorlopig) niet raadpleegbaar. Ook worden deze gegevens niet in alle gemeenten (op dezelfde manier) gebruikt.

## Zoeken op adres in de BRP
Zoeken op adres (postcode) bij een ingeschreven persoon wordt gedaan op de postcode zoals die in de BRP is opgeslagen.

*Ratio*
* Een oplossing waarbij deze zoekvraag wordt samengesteld uit een bevraging op BAG (adressen) gecombineerd met een of meerdere bevraging(en) op GBA/BRP legt teveel complexiteit en last bij gemeenten.
* Implementatie is veel makkelijker en response veel sneller bij bevragen op deze gegevens binnen de BRP.
* Niet alle adressen in BRP zijn te relateren aan een postcode in de BAG en deze personen moeten ook gevonden kunnen worden.

## Resourcedefinitie binnen API voor elke gelinkte resource
Voor elke gelinkte resource (relatie) moet er binnen het Bevragen ingeschreven personen API (ten minste tijdelijk) een resource beschreven (ontsloten) zijn. Voor een gelinkte resource buiten het BRP-domein wordt alleen het opvragen van de actuele status van de enkele resource gespecificeerd.

*Ratio*
Relaties worden opgenomen als uri naar de betreffende resource. De API voor het opvragen van de ingeschreven persoon moet dus URI's kunnen samenstellen die verwijzen naar de betreffende objecten (resources) en waar deze objecten (resources) ook daadwerkelijk op te vragen zijn.
Zo lang deze resources nog niet ontsloten zijn (in een API op betreffende bron) moeten deze dus binnen deze API beschreven worden.

## Aanschrijfwijze opnemen in de resource
We voegen een veld "aanschrijfwijze" toe aan de resource ingeschrevenNatuurlijkPersoon.
In dit veld wordt de naam samengesteld op basis van de aanduiding naamgebruik.

Het algoritme voor het samenstellen moet worden beschreven in de API specificaties.

*Ratio*
* Hiermee wordt complexiteit verplaatst van veel consumers naar één (enkele) provider(s).
* In de praktijk blijken er bij sommige consumers nu fouten te worden gemaakt bij het samenstellen van de manier waarop een persoon moet worden aangeschreven.
* Het in de API implementeren van deze logica garandeert een consistente uitvoering hiervan binnen een gemeente.
* Dit is een verbetering voor AVG eisen, omdat hierdoor gegevens zoals van de partner niet meer bij een persoon meegeleverd hoeven te worden (deze werken immers alleen gebruikt voor het samenstellen van de aanschrijfwijze).

## Relaties uit dezelfde bron kunnen embed worden
In de resource van een ingeschreven natuurlijk persoon kunnen de relaties partner(schap), ouders en kinderen embed worden opgenomen met gebruik van de expand-parameter. Dit betekent dat het mogelijk is in één aanroep de ingeschreven persoon te krijgen, met daarbij gegevens over de relaties met eventuele partner(s), ouders en kinderen.

Wanneer een gerelateerde resource expand wordt, wordt de gehele sub-resource teruggegeven, tenzij in de expand parameter alleen een deel van de gerelateerde resource gevraagd is.

Gegevens uit een andere bron/registratie (bijvoorbeeld het BAG-adres van een persoon) kunnen niet embed worden.

Reisdocumenten kunnen niet embed worden.

*Ratio*
Vooralsnog heeft de bron, het GBA, geen directe toegang tot andere bronnen (BAG).
Gegevens over de relaties met partner, ouders en kinderen horen bij de persoon.
Vraag naar de combinatie van persoonsgegevens inclusief reisdocumentgegevens komt niet heel vaak voor.

## Gebruik van expand=true wordt uitgesloten
Voor het gebruik van de API is het gebruiken van expand=true om alle relaties embed te krijgen is niet toegestaan.

*Ratio*
Het embedded van gerelateerde resources moet bewust worden gebruikt.

## Relaties kunnen maximaal één niveau diep worden embed
Door het gebruik van de parameter expand kunnen relaties/gerelateerde sub-resources worden embed in het antwoord. Relaties van de gerelateerde resource worden alleen als link opgenomen, maar kunnen zelf niet embed worden.

Bijvoorbeeld van een persoon kunnen de gegevens van de gerelateerde sub-resource huwelijk/geregistreerd partnerschap direct worden meegeladen. Daarin zitten alleen de gegevens van de relatie zoals die ook in betreffende categorie van LO GBA voorkomen, zoals ook de naam van de partner.
Wanneer echter de partner (ook) een ingeschreven persoon is, wordt een hyperlink naar de resource van deze persoon opgenomen. De gegevens van deze ingeschreven persoon (de partner) kunnen echter niet ok worden embed.

*Ratio*
Implementatie en gebruik eenvoudig houden.
We zien geen functionele behoefte om diep gegevens te embedded.
Het opvragen van relaties is eenvoudig.
Opnemen van meer gegevens van gerelateerde personen dan bij de persoon zelf horen, mag vaak niet aangezien er geen doelbinding voor de gegevens van de partner.

## Namen van gegevensgroepen worden ingekort.
Het stuk "IngeschrevenNatuurlijkPersoon" aan het eind van de groepsnaam wordt verwijderd.

Bijvoorbeeld "verblijfstitelIngeschrevenNatuurlijkPersoon" wordt "verblijfstitel", "overlijdenIngeschrevenNatuurlijkPersoon" wordt "overlijden", "geboorteIngeschrevenNatuurlijkPersoon" wordt "geboorte", enz.

*Ratio*
* De namen zijn erg lang. Dit is niet bevorderlijk voor eenvoud van implementatie.
* Extensie "IngeschrevenNatuurlijkPersoon" is redundant, want het is al duidelijk dat het gaat over eigenschappen van een ingeschreven natuurlijk persoon.
* Is consistent met ontwerpbeslissing [Naamgeving van de API velden binnen een resource] (https://github.com/VNG-Realisatie/gemma-zaken/blob/master/docs/content/developers/design-keuzes.md#naamgeving-van-de-api-velden-binnen-een-resource)


## Identificatie BAG-objecten is een string
De identificatie van BAG-objecten wordt geïmplementeerd als string, waarin de delen worden samengevoegd:identificatiecode = gemeentecode + objecttypecode + objectvolgnummer.

*Ratio*

In het RSGB is de identificatie van BAG-objecten (bijvoorbeeld identificatiecode van een nummeraanduiding) opgenomen als complex datatype. In de BAG-registratie is dit echter één string waarin de deel-elementen uit het complex datatype zijn samengevoegd.
Zie issue [#1](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/1).

## De API filtert terug te geven gegevens op autorisatie van de organisatie
De API levert alleen gegevens terug waar de vragende organisatie voor geautoriseerd is.
Er worden geen aparte endpoints of resources gedefinieerd per autorisatieprofiel.

De bronhouder die gegevens ter beschikking stelt is verantwoordelijk voor het leveren van alleen gegevens waarvoor de juiste autorisatie bestaat. Bij de bronhouder gaat het om autorisatie op niveau van de vragende organisatie (gemeente).
De gemeente is er verantwoordelijk voor de resultaten van de API aanvraag te filteren op autorisatie van de betreffende gebruiker.

*Ratio*

Uitgangspunt in de architectuur is gedelegeerde autorisatie.

## Eén uniform endpoint voor zoeken ingeschreven persoonsgegevens
Voor ingeschreven personen komt er één endpoint voor het zoeken: /ingeschrevenNatuurlijkPersonen.
Dit endpoint geeft alle attributen van de ingeschreven persoon van het LO GBA, geen aanhangende gegevens of gemeentelijke kerngegevens, alle relaties (die in GBA zitten) als link (uri).

Op dit endpoint worden alle zoekparameters uit RSGB-bevragingen 1.0 ondersteund die vallen onder "zoeken op persoonskenmerken". Er worden minimale combinaties van parameters voorgeschreven.

*Ratio*
Het ondersteunen van één uniform endpoint per resource is duidelijker voor implementatie. Gevolgen van wijzigingen zijn beter te overzien (losse koppeling). Het voorkomt wildgroei van endpoints.

Vereisen van minimale combinaties van zoekparameters stimuleert gerichte zoekvragen.

De API moet elke combinatie van toegestane zoekparameters ondersteunen, zolang het voldoet aan de eis van minimale combinaties. Bijvoorbeeld een van de minimale combinaties is postcode + huisnummer, elke combinatie van zoekparameters naast postcode en huisnummer moet ondersteund worden in de API en de zoekresultaten filteren op alle opgegeven zoekparameters.

## Verblijfadres wordt relatie naar de nummeraanduiding plus een gegevensgroep
Het verblijfadres van een persoon wordt bij de persoon opgenomen als gegevensgroep. Daarin staan de adresgegevens zoals die in het GBA bekend zijn. In deze gegevensgroep zijn de relevantie adresgegevens platgeslagen, zodat de gebruiker eenvoudig alle adresgegevens beschikbaar heeft in het antwoord.

Wanneer het verblijfadres een BAG-adres is, wordt ook een relatie (link) naar de nummeraanduiding in het BAG opgenomen.

*Ratio*
Functionele vraag is: ik wil in één vraag een persoon met adres hebben.
Een groot deel van de vragen om persoonsgegevens is er direct behoefte aan de adresgegevens, zonder geïnteresseerd te zijn in de structuur in BAG (zoals naar nummeraanduiding, woonplaats, ligplaats, adresseerbaar object).
Zie https://www.rvig.nl/brp/vraag-en-antwoord/mag-een-persoon-worden-ingeschreven-op-een-locatieomschrijving-in-de-gba-als-er-geen-authentiek-bag-adres-is
Deze oplossing is ook een oplossing voor issue [22](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/22) en [14](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/14).

## Verblijfplaats wordt gevuld met adresgegevens uit het GBA als er geen BAG adres beschikbaar is
De verblijfplaats toont de adresgegevens zoals die in het GBA staan geregistreerd als er geen BAG nummeraanduiding en openbare ruimtenaam uit de BAG beschikbaar is.

*Ratio*
Vanuit het GBA hoeft er geen verbinding te zijn naar het BAG om de juiste adresgegevens op te halen.
Er is niet altijd een BAG-adres.
Zie https://www.rvig.nl/brp/vraag-en-antwoord/mag-een-persoon-worden-ingeschreven-op-een-locatieomschrijving-in-de-gba-als-er-geen-authentiek-bag-adres-is

## Zoeken op geboortedatum gebeurt alleen op volledige datum.
Er wordt geen zoeken op onvolledige geboortedatum ondersteund in de API.

*Ratio*
Hier is geen functionele behoefte aan.

## Geboortedatum wordt gegevensgroep met dag, maand en jaar
Ten behoeve van het ondersteunen van onvolledige datums, wordt de geboortedatum in de response een gegevensgroep "geboorte" met 4 properties:
- geboortejaar: date-fullyear
- geboortemaand: date-month
- geboortedag: date-mday
- geboortedatum: date

Deze velden zijn gedefinieerd in ISO8601-typen.
Als er een volledige geboortedatum is, worden alle 4 velden ingevuld, anders alleen de bekende delen.

*Ratio*
In de API moet het mogelijk zijn een persoon met gedeeltelijk onbekende geboortedatum op te nemen, zie issue [6](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/6).
De gekozen oplossing is het eenvoudigst te implementeren.

## Schema componenten voor domeinwaarden en enumeraties krijgen vaste extensie
Schema componenten voor dynamische domeinwaarden (referentielijsten zoals "Tabel 32 Nationaliteitentabel") en enumeraties krijgen respectievelijk extensie "\_tabel" en "\_enum".

*Ratio*
Er kunnen gegevensgroepen, domeinwaarden en enumeraties zijn met dezelfde naam. Bijvoorbeeld gegevensgroep Nationaliteit bevat een property van type domeinwaarden Nationaliteit (verwijzend naar Tabel 32 Nationaliteitentabel).
Om deze schema componenten uniek en herkenbaar te maken krijgt de naam van de schemacomponent voor een domeinwaardenlijst de suffix "\_tabel" (bijvoorbeeld Nationaliteit_tabel) en krijgt de schemacomponent voor elke enumeratie de suffix "\_enum" (bijvoorbeeld Geslacht_enum).

## gemeenteVanInschrijving is een property met gemeentecode

*Ratio*
Gemeente is een objecttype (en daarmee waarschijnlijk een resource van de BAG). Daarom zou je verwachten dat gemeenteVanInschrijving een relatie is. In het model is het echter een attribuut met de gemeentecode.
We houden dit een attribuut met gemeentecode, omdat dit gegeven wordt niet actief bijgehouden.

## De response heeft geen verplichte properties
Alle properties in de response worden in de Open API Specificaties gedefinieerd als optioneel, ook wanneer de betreffende attributen in het informatiemodel verplicht zijn.

*Ratio*
De hoeveelheid businesslogica in interface beperken. Zorgen dat zoveel mogelijk antwoord gegeven kan worden, ook wanneer een verwachte property geen waarde heeft. Het alternatief, het opnemen van de reden van geen waarde (zoals StUF:noValue) is dan niet nodig, wat het gebruik van de API eenvoudiger maakt.

## We gebruiken geen overerving van abstracte types in de API specificaties
Bijvoorbeeld ingeschreven natuurlijk persoon wordt in de schema's platgeslagen met bovenliggende types (subject, persoon, natuurlijk persoon).

*Ratio*
Zolang we niets doen met de abstracte types (subject, persoon, natuurlijk persoon), heeft het geen zin dit mee te nemen in de component schema's.

## Uitgangspunt voor modellering is de basisregistratie
Voor persoonsgegevens gebruiken we LO GBA 3.10.

*Ratio*
Het gaat om bevragen bij de bron. De bron voor persoonsgegevens is het GBA. Daarom moet het logisch ontwerp van de GBA worden gebruikt en er geen afwijkende RSGB-modellering zijn van persoonsgegevens.

## Zoeken en raadplegen van personen levert alleen actuele relaties
Volgens LO GBA zijn ook relaties die zijn beëindigd nog "actueel". Voor het zoeken en raadplegen van actuele persoonsgegevens is echter alleen behoefte aan relaties die niet beëindigd zijn.

Wanneer wel behoefte is aan alle partner-relaties, inclusief relaties die al beëindigd zijn, kan hiervoor historisch zoeken op partners worden gebruikt.

## Opvragen van historie kan via specifieke endpoints
Opvragen van historie wordt gedefinieerd met aparte endpoints. Als een provider ervoor kiest om deze niet te implementeren wordt er een 501 geretourneerd. De historische bevraging krijgen dus resourcenaam waaruit blijkt dart het om een historische resource gaat. 
Met deze API kan de historie op het betreffende aspect opgevraagd worden.

Hiermee wordt het zoeken/raadplegen van de volgende historie ondersteund:
- bewoningen (welke personen hebben een adres als verblijfplaats gehad)
- verblijfplaatshistorie (welke verblijfplaatsen heeft een persoon gehad)
- partnerhistorie (welke partnerrelaties heeft een persoon gehad)
- verblijftitelhistorie (welke verblijftitels heeft een persoon gehad)


Er kan gekozen worden om de status op peildatum te raadplegen met de queryparameter geldigOp.
Er kan gekozen worden de historische voorkomens te raadplegen binnen een periode met queryparameters periodevan en periodetot.

Het antwoordbericht van /verblijfplaatsen bevat het property burgerservicenummer van de ingeschreven natuurlijk persoon, plus \_links en \_embedded met de historische voorkomens van de verblijfplaats van de persoon. Hierin zitten ook de properties geldigVan en geldigTotEnMet.
Het antwoordbericht van /verblijfstitels bevat de historische voorkomens van de verblijfstitel van de ingeschreven persoon en de properties geldigVan en geldigTotEnMet.
Het antwoordbericht van /partners bevat het property burgerservicenummer van de ingeschreven natuurlijk persoon, plus de historische voorkomens van partner-relaties (huwelijken of geregistreerd partnerschappen). Hierin zitten ook de geldigVan en geldigTotEnMet.
Het antwoordbericht van /bewoningen bevat de lijst gevonden adressen, met voor elk adres de bewoners met elk de properties geldigVan en geldigTotEnMet.

## Elementnamen die verwijzen naar een resource die maximaal 1 keer kan voorkomen worden enkelvoud.

Als voorbeeld de verblijfsplaats bij een ingeschreven persoon. De kardinaliteit daarvan is 0..1, dus er kan maximaal 1 verblijfsplaats aan gerelateerd zijn aan een ingeschreven persoon.

*Ratio*
Het is voor de developer verwarrend als de elementnaam in meervoud is gesteld terwijl de kardinaliteit maximaal 1 is.
Ratio

## Burgerservicenummer is unieke sleutel voor een ingeschreven natuurlijk persoon
De resource ingeschrevenNatuurlijkPersonen wordt uniek geïdentificeerd met de sleutel burgerservicenummer.
Dus is het pad naar de gegevens van één persoon gedefinieerd als /ingeschrevennatuurlijkpersonen/{burgerservicenummer}

*Ratio*
Het burgerservicenummer is het persoonsnummer voor contact van een burger met de overheid. Andere registraties die verwijzen naar een persoon zullen geen andere unieke identificatie kennen dan het burgerservicenummer. Zolang andere registraties (zoals BRK en HR) alleen het burgerservicenummer als functionele sleutel van de persoon kennen kan er geen technische sleutel (UUID) gebruikt worden voor het ophalen van een enkele resource.
Ook voor apps die op bais van DigiD de persoonsgegevens ophalen kennen alleen het burgerservicenummer, geen technische sleutel.

## We nemen geen (inverse) relaties uit een ander domein op
Vanuit andere registraties bestaan er relaties naar ingeschreven natuurlijk personen. Een persoon kan bijvoorbeeld zakelijk gerechtigde zijn van een Kadastraal object of functionaris zijn van een bedrijf.
Deze inverse relaties uit een andere bron worden niet opgenomen bij de ingeschreven natuurlijk persoon.
Wanneer er functionele behoefte is aan deze gegevens moeten deze bij de betreffende bron (bijvoorbeeld BRK of HR) worden opgevraagd.

*Ratio*
We bevragen gegevens bij de bron. Een bron kan alleen gegevens leveren die ze zelf heeft.

## Bij het zoeken van personen is er een maximum aantal resultaten
Personen mogen alleen gericht worden gezocht. Daarom moet het aantal mogelijke resultaten op een zoekvraag worden gelimiteerd. Wanneer met opgegeven zoekparameters het aantal resultaten groter is dan het maximum, wordt een foutmelding gegeven en krijgt de gebruiker verder geen gevonden personen terug in het antwoord.
Er is dus ook geen paginering nodig in deze API.

Er wordt in de API standaard geen aantal als maximum vastgesteld. De provider van de API mag dit aantal zelf bepalen en optimaliseren op basis van ervaringen in het gebruik van de API.

## In onderzoek kan betrekking hebben op groepen van attributen én op individuele attributen
Groepen van attributen (zoals "naam" die o.a. voornamen en geslachtsnaam bevat) kunnen in zijn geheel in onderzoek zijn, maar ook kunnen individuele attributen in de groep (zoals alleen de voornamen) in onderzoek zijn.

Wanneer een hele groep attributen (als groep) in onderzoek is, wordt in het antwoord op de bevraging van de persoon elk attribuut van de groep aangegeven als in onderzoek.

## Sortering voor actuele zoekresultaten worden niet gesorteerd
De API standaard schrijft niet voor hoe zoekresultaten in de API moeten worden gesorteerd. Wanneer de client behoefte heeft aan gesorteerde resultaten, moet zij de ontvangen resultaten zelf sorteren.

## Historie wordt gesorteerd op geldigheid met meest actuele resultaat bovenaan
Historie wordt aflopend gesorteerd op datum geldigheid (geldigVan).

## Historie elementen krijgen dezelfde naam en betekenis als in de NEN3610
beginGeldigheid en eindGeldigheid
Binnen de NEN standaard is er een keuze-mogelijkheid (datum en datumtijd) voor het formaat waarin de historie wordt bijgehouden. De Bron houdt geen tijd bij dus schrijven we het datum-formaat voor. 

## Historie: inonderzoek wordt alleen actueel getoond
Binnen de historie-endpoints wordt alleen de actuele situatie met betrekking tot "in Onderzoek" getoond. Er wordt geen historie getoond van de onderzoeken die in het verleden hebben plaatsgevonden.  

## Toepassen van HAL-Links
Er zijn grofweg twee categoriën Hal-links waar we gebruik van maken. Links naar resources binnen het eigen domein en links naar resources die in een ander domein beheerd worden. Om discoverability te bereiken, worden voor beide categorieën de Hal-link opgenomen naar de gerelateerde resource. Voor developers die geen HAL links willen gebruiken wordt tevens de identificatie van de gerelateerde resource opgenomen. Mede om het gebruik van proxy-servers te faciliteren en de comsumer in staat te stellen de gewenste major-versie in de link op te nemen worden de Hal-Links aangeboden als "templated URL".  

## Gebruik van Booleans als indicatoren
In diverse situaties worden booleans opgenomen als er sprake is van indicatoren. Deze booleans worden alleen geretourneerd als de waarde van de boolean ook informatief is. De indicator wordt dus alleen opgenomen als de waarde vand de Boolean "true" is. 
