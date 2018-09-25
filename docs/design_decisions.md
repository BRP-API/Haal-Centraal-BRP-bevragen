# Design decisions
Dit document beschrijft ontwerpkeuzes die gemaakt zijn voor het ontwerpen en specificeren van de API's in dit koppelvlak.

## Tabelentiteiten worden in het bericht opgenomen met zowel de code als de omschrijving
Voor een element van een tabelentiteit-type, wordt in het bericht zowel de code als de omschrijving opgenomen.

*Ratio*
Garanderen dat verschillende systemen binnen en buiten de gemeente dezelfde (toestand) van de tabel kennen is duur, ingewikkeld en foutgevoelig.

*Kanttekening* 
Als landelijk beheerde tabellen ook daadwerkelijk landelijk beschikbaar gesteld worden (zoals de common groud gedachte wel beoogd) dan worden tabel-entiteiten als resource ontsloten en dus als link opgenomen.

## Enumeraties worden in het bericht opgenomen met de enumeratiewaarde (omschrijving), niet de code.
Bijvoorbeeld voor geslacht wordt "Vrouw" of "Man" gestuurd, niet "V" of "M".

*Ratio*
Uitgangspunt binnen Common Ground is gebruik van gegevens, niet opslag van gegevens. Dus de omschrijving (uitgeschreven waarde) is relevant voor de gebruiker.

## Gemeentelijke kerngegevens en plusgegevens worden niet opgenomen in de resource.
In het antwoordbericht worden alleen gegevens opgenomen die in het BRP zitten.

*Ratio*
Deze gegevens zitten niet in een (voor alle gemeenten geldend) bronsysteem dat voor de bevraging geraadpleegd kan worden. Deze gegevens zijn dus (voorlopig) niet raadpleegbaar. Ook worden deze gegevens niet in alle gemeenten (op dezelfde manier) gebruikt.

## Zoeken op adres in de BRP
Zoeken op adres (postcode) bij een ingeschreven persoon wordt gedaan op de postcode zoals die in de BRP is opgeslagen.

*Ratio*
* Een oplossing waarbij deze zoekvraag wordt samengesteld uit een bevraging op BAG (adressen) gecombineerd met een of meerdere bevraging(en) op GBA/BRP legt teveel complexiteit en last bij gemeenten.
* Implementatie is veel makkelijker en response veel sneller bij bevragen op deze gegevens binnen de BRP.
* Niet alle adressen in BRP zijn te relateren aan een postcode in de BAG en deze personen moeten ook gevonden kunnen worden.

## Resourcedefinitie binnen koppelvlak voor elke gelinkte resource
Voor elke gelinkte resource (relatie) moet er binnen het Bevragen ingeschreven personen koppelvlak (ten minste tijdelijk) een resource API beschreven (ontsloten) zijn. Voor een gelinkte resource buiten het BRP-domein wordt alleen het opvragen van de actuele status van de enkele resource gespecificeerd.

*Ratio*
Relaties worden opgenomen als uri naar de betreffende resource. De API voor het opvragen van de ingeschreven persoon moet dus URI's kunnen samenstellen die verwijzen naar de betreffende objecten (resources) en waar deze objecten (resources) ook daadwerkelijk op te vragen zijn.
Zo lang deze resources nog niet ontsloten zijn (in een koppelvlak en API op betreffende bron) moeten deze dus binnen dit koppelvlak beschreven worden.

## Aanschrijfwijze opnemen in de resource
We voegen een veld "aanschrijfwijze" toe aan de resource ingeschrevenNatuurlijkPersoon.
In dit veld wordt de naam samengesteld op basis van de aanduiding naamgebruik.

Het algoritme voor het samenstellen moet worden beschreven in de API specificaties.

*Ratio*
* Hiermee wordt complexiteit verplaatst van veel consumers naar één (enkele) provider(s).
* In de praktijk blijken er bij sommige consumers nu fouten te worden gemaakt bij het samenstellen van de manier waarop een persoon moet worden aangeschreven.
* Het in de API implementeren van deze logica garandeert een consistente uitvoering hiervan binnen een gemeente.
* Dit is een verbetering voor AVG eisen, omdat hierdoor gegevens zoals van de partner niet meer bij een persoon meegeleverd hoeven te worden (deze werken immers alleen gebruikt voor het samenstellen van de aanschrijfwijze).

## Alle relaties kunnen embed worden
In de resource van een ingeschreven natuurlijk persoon kunnen alle relaties embedded worden opgenomen met gebruik van de expand-parameter.
Wanneer een gerelateerde resource expand wordt, wordt de gehele resource teruggegeven, tenzij in de expand parameter alleen een deel van de gerelateerde resource gevraagd is.

## Gebruik van expand=true wordt uitgesloten

*Ratio*
Het embedded van gerelateerde resources moet bewust worden gebruikt.

## Namen van gegevensgroepen worden ingekort.
Het stuk "IngeschrevenNatuurlijkPersoon" aan het eind van de groepsnaam wordt verwijderd.

Bijvoorbeeld "verblijfstitelIngeschrevenNatuurlijkPersoon" wordt "verblijfstitel", "overlijdenIngeschrevenNatuurlijkPersoon" wordt "overlijden", "geboorteIngeschrevenNatuurlijkPersoon" wordt "geboorte", enz.

*Ratio*
* De namen zijn erg lang. Dit is niet bevorderlijk voor eenvoud van implementatie.
* Extensie "IngeschrevenNatuurlijkPersoon" is redundant, want het is al duidelijk dat het gaat over eigenschappen van een ingeschreven natuurlijk persoon.
* Is consistent met ontwerpbeslissing [Naamgeving van de API velden binnen een resource] (https://github.com/VNG-Realisatie/gemma-zaken/blob/master/docs/content/developers/design-keuzes.md#naamgeving-van-de-api-velden-binnen-een-resource)

## Alleen gegevens van een gerelateerde resource die ook in de BRP worden opgeslagen kunnen worden embed
Embedded gegevens (van een gerelateerde resource), voor de ingeschreven natuurlijk persoon alleen het verblijfsadres, bevat alleen die gegevens die ook in de BRP worden opgeslagen. Deze gegevens worden door de provider gehaald uit de betreffende basisregistratie (hier: BAG).

*Ratio*
* Alleen de gegevens die ook in het BRP zitten zijn relevant voor de resource ingeschreven natuurlijk persoon.
* Andere gegevens van het BAG-object zijn niet relevant in het verblijfsadres van een persoon.
* Gegevens moeten worden gehaald bij de bron.

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

## Eén uniform endpoint voor zoeken ingeschreven natuurlijk persoonsgegevens
Voor ingeschreven natuurlijk personen komt er één endpoint voor het zoeken: /ingeschrevenNatuurlijkPersonen.
Het antwoord op dit bericht bevat alle attributen van de ingeschreven natuurlijk persoon van het LO GBA, geen aanhangende gegevens of gemeentelijke kerngegevens, alle relaties (die in GBA zitten) als link (uri).
Alleen verblijfsadres kan worden embed via de "expand" parameter, default wordt niets embed.
Op dit endpoint worden alle zoekparameters die gebruikt zijn bij zoekpaden in RSGB-bevragingen 1.0 ondersteund. Alleen combinaties van parameters per zoekpad wordt ondersteund, inclusief evt. verplichting van specifieke parameters. Op andere paramters kan niet worden gezocht.
Wanneer een client een andere combinatie gebruikt dan beschreven (bijvoorbeeld postcode + geboortedatum), moet de provider een foutmelding teruggeven.
De ondersteunde combinaties worden in de specificaties beschreven in woorden en als uri-sjablonen.

*Ratio*
Het ondersteunen van één uniform endpoint per resource is duidelijker voor implementatie. Gevolgen van wijzigingen zijn beter te overzien (losse koppeling). Het voorkomt wildgroei van endpoints.
Functioneel is vooralsnog alleen behoefte aan het embedden van het verblijfsadres, daarom wordt het embedded van andere relaties niet niet ondersteund.
Beperken van het aantal mogelijke combinaties van zoekparameters maakt het mogelijk de provider te optimaliseren.
Verplicht beperken van ondersteunde zoek-combinaties voorkomt vendor lock in, omdat zeker is dat elke leverancier exact dezelfde functionaliteit biedt in de API. Ook wordt de testbaarheid van de API hiermee vergroot.
Zie issue [16](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/16).

## Verblijfadres wordt relatie naar een resource verblijfplaatsen
Er wordt een resource gedefinieerd voor het weergeven van een verblijfplaats (/verblijfplaatsen).
In deze resource zijn de relevantie adresgegevens platgeslagen, zodat de gebruiker eenvoudig alle adresgegevens beschikbaar heeft in het antwoord.
Het verblijfadres van een ingeschreven natuurlijk persoon wordt vormgegeven als relatie naar de verblijfplaats.
Alle relaties naar de werkelijke BAG objecttypen (nummeraanduiding, ligplaats, enz.) worden als relatie in de resource opgenomen (kunnen niet worden embed/expand).
De gebruikers kan van een persoon de adresgegevens krijgen door /ingeschrevennatuurlijkpersonen?expand=verblijfadres.

*Ratio*
Functionele vraag is: ik wil in één vraag een persoon met adres hebben.
Een groot deel van de vragen om persoonsgegevens is er direct behoefte aan de adresgegevens, zonder geïnteresseerd te zijn in de structuur in BAG (zoals naar nummeraanduiding, woonplaats, ligplaats, adresseerbaar object).
Deze oplossing is ook een oplossing voor issue [22](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/22) en [14](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/14).

## Zoeken op geboortedatum gebeurt alleen op volledige datum.
Er wordt geen zoeken op onvolledige geboortedatum ondersteund in de API.

*Ratio*
Hier is geen functionele behoefte aan.

## Geboortedatum wordt gegevensgroep met dag, maand en jaar
Ten behoeve van het ondersteunen van onvolledige datums, wordt de geboortedatum in het responsebericht een gegevensgroep "geboorte" met 4 properties:
- geboortejaar: date-fullyear
- geboortemaand: date-month
- geboortedag: date-mday
- geboortedatum: date

Deze velden zijn gedefinieerd in ISO8601-typen.
Als er een volledige geboortedatum is, worden alle 4 velden ingevuld, anders alleen de bekende delen.

*Ratio*
In het bericht moet het mogelijk zijn een persoon met gedeeltelijk onbekende geboortedatum op te nemen, zie issue [6](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/6).
De gekozen oplossing is het eenvoudigst te implementeren.

## Schema componenten voor tabelentiteit en enumeraties krijgen vaste extensie
Schema componenten voor tabel-entiteiten en enumeraties krijgen extensie "\_tabel" en "\_enum".

*Ratio*
Er kunnen gegevensgroepen, tabel-entiteiten en enumeraties zijn met dezelfde naam. Bijvoorbeeld gegevensgroep Nationaliteit bevat een tabel-entiteit Nationaliteit.
Om deze schema componenten uniek en herkenbaar te maken krijgt de naam van de schemacomponent voor een tabel de suffix "\_tabel" (bijvoorbeeld Nationaliteit_tabel) en krijgt de schemacomponent voor elke enumeratie de suffix "\_enum" (bijvoorbeeld Geslacht_enum).

## gemeenteVanInschrijving is een property met gemeentecode

*Ratio*
Gemeente is een objecttype (en daarmee waarschijnlijk een resource van de BAG). Daarom zou je verwachten dat gemeenteVanInschrijving een relatie is. In het model is het echter een attribuut met de gemeentecode.
We houden dit een attribuut met gemeentecode, omdat dit gegeven wordt niet actief bijgehouden.

## Het antwoordbericht heeft geen verplichte properties
Alle properties in het antwoordbericht worden in de Open API Specificaties gedefinieerd als optioneel, ook wanneer de betreffende attributen in het informatiemodel verplicht zijn.

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

# Zoeken van personen op adres kan via endpoint /bewoning
Via resource bewoning kunnen de bewoners op een adres worden gezocht. Hiervoor kunnen de queryparameters worden gebruikt voor het zoeken van een adres (zoals postcode, huisnummer, enz.).
Het antwoord bevat een lijst met in elk voorkomen de link naar het betreffende adres en de link naar de betreffende persoon (bewoner). De gegevens van de bewoners en adressen kan met parameter expand worden teruggegeven.

## Opvragen van historie kan via specifieke endpoints
Er komen endpoints /verblijfplaatshistorie/{burgerservicenummer}, /verblijfstitelhistorie/{burgerservicenummer}, /partnerhistorie/{burgerservicenummer} en /bewoningshistorie.
Via deze endpoints kan de historie op het betreffende aspect opgevraagd worden.
Er kan gekozen worden om de status op peildatum te raadplegen met de queryparameter geldigOp.
Er kan gekozen worden de historische voorkomens te raadplegen binnen een periode met queryparameters periodevan en periodetot.
Het antwoordbericht van /verblijfplaatshistorie bevat het property burgerservicenummer van de ingeschreven natuurlijk persoon, plus _links en _embedded met de historische voorkomens van de verblijfplaats. Hierin zitten ook de properties periodeVan en periodeTotEnMet.
Het antwoordbericht van /verblijfstitelhistorie bevat de historische voorkomens van de property verblijfstitel van de ingeschreven natuurlijk persoon en de properties periodeVan en periodeTotEnMet.
Het antwoordbericht van /partnerhistorie bevat het property burgerservicenummer van de ingeschreven natuurlijk persoon, plus _links en _embedded met de voorkomens van de partner. Hierin zitten ook de properties periodeVan en periodeTotEnMet.
Het antwoordbericht van /bewoningshistorie bevat de lijst voorkomens met elk de properties periodeVan en periodeTotEnMet, plus _links en _embedded met het betreffende adres en de betreffende persoon (bewoner). De bewoningshistorie kan worden gezocht met dezelfde queryparameters als voor resource bewoning.
