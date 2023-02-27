---
layout: page-with-side-nav
title: Design decisions HaalCentraal BRP-Bevragen
---
# Design decisions HaalCentraal BRP-Bevragen
Alle ontwerpkeuzes die zijn gemaakt tijdens het ontwerpen en specificeren van de API's zijn hier beschreven.

## Algemene Design Decisions
In het document [design_desicions.md](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/master/docs/design_decisions.md) dat in de Haal-Centraal-common repository is opgenomen staan beslissingen opgesomd waar alle Haal Centraal API's zich aan conformeren.

## Zoeken op adres in de BRP
Zoeken op adres (postcode) bij een ingeschreven persoon wordt gedaan op de postcode zoals die in de BRP is opgeslagen.

*Ratio*
* Een oplossing waarbij deze zoekvraag wordt samengesteld uit een bevraging op BAG (adressen) gecombineerd met een of meerdere bevraging(en) op GBA/BRP legt teveel complexiteit en last bij gemeenten.
* Implementatie is veel makkelijker en response veel sneller bij bevragen op deze gegevens binnen de BRP.
* Niet alle adressen in BRP zijn te relateren aan een postcode in de BAG en deze personen moeten ook gevonden kunnen worden.

## Resourcedefinitie binnen API voor elke gelinkte resource (heroverwegen ?)
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

## Identificatie van BAG-objecten in de BRP-Bevraging is een string
De identificatie van BAG-objecten wordt geïmplementeerd als string, waarin de delen worden samengevoegd:identificatiecode = gemeentecode + objecttypecode + objectvolgnummer.

*Ratio*

In het RSGB is de identificatie van BAG-objecten (bijvoorbeeld identificatiecode van een nummeraanduiding) opgenomen als complex datatype. In de BAG-registratie is dit echter één string waarin de deel-elementen uit het complex datatype zijn samengevoegd.
Zie issue [#1]({{ site.repoUrl }}/issues/1).

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

## gemeenteVanInschrijving is een property met gemeentecode

*Ratio*
Gemeente is een objecttype (en daarmee waarschijnlijk een resource van de BAG). Daarom zou je verwachten dat gemeenteVanInschrijving een relatie is. In het model is het echter een attribuut met de gemeentecode.
We houden dit een attribuut met gemeentecode, omdat dit gegeven wordt niet actief bijgehouden.

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


## Burgerservicenummer is unieke sleutel voor een ingeschreven natuurlijk persoon
De resource ingeschrevenNatuurlijkPersonen wordt uniek geïdentificeerd met de sleutel burgerservicenummer.
Dus is het pad naar de gegevens van één persoon gedefinieerd als /ingeschrevennatuurlijkpersonen/{burgerservicenummer}

*Ratio*
Het burgerservicenummer is het persoonsnummer voor contact van een burger met de overheid. Andere registraties die verwijzen naar een persoon zullen geen andere unieke identificatie kennen dan het burgerservicenummer. Zolang andere registraties (zoals BRK en HR) alleen het burgerservicenummer als functionele sleutel van de persoon kennen kan er geen technische sleutel (UUID) gebruikt worden voor het ophalen van een enkele resource.
Ook voor apps die op bais van DigiD de persoonsgegevens ophalen kennen alleen het burgerservicenummer, geen technische sleutel.

## Bij het zoeken van personen is er een maximum aantal resultaten
Personen mogen alleen gericht worden gezocht. Daarom moet het aantal mogelijke resultaten op een zoekvraag worden gelimiteerd. Wanneer met opgegeven zoekparameters het aantal resultaten groter is dan het maximum, wordt een foutmelding gegeven en krijgt de gebruiker verder geen gevonden personen terug in het antwoord.
Er is dus ook geen paginering nodig in deze API.

Er wordt in de API standaard geen aantal als maximum vastgesteld. De provider van de API mag dit aantal zelf bepalen en optimaliseren op basis van ervaringen in het gebruik van de API.

## In onderzoek kan betrekking hebben op groepen van attributen én op individuele attributen
Groepen van attributen (zoals "naam" die o.a. voornamen en geslachtsnaam bevat) kunnen in zijn geheel in onderzoek zijn, maar ook kunnen individuele attributen in de groep (zoals alleen de voornamen) in onderzoek zijn.

Wanneer een hele groep attributen (als groep) in onderzoek is, wordt in het antwoord op de bevraging van de persoon elk attribuut van de groep aangegeven als in onderzoek.

