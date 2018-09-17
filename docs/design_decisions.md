# Design decisions
Dit document beschrijft ontwerpkeuzes die gemaakt zijn voor het ontwerpen en specificeren van de API's in dit koppelvlak.

## Tabelentiteiten worden in het bericht opgenomen met zowel de code als de omschrijving
Voor een element van een tabelentiteit-type, wordt in het bericht zowel de code als de omschrijving opgenomen.

*Ratio*
Garanderen dat verschillende systemen binnen en buiten de gemeente dezelfde (toestand) van de tabel kennen is duur, ingewikkeld en foutgevoelig.

## Enumeraties worden in het bericht opgenomen met de enumeratiewaarde (omschrijving), niet de code.
Bijvoorbeeld voor geslacht wordt "Vrouw" of "Man" gestuurd, niet "V" of "M".

*Ratio*
Uitgangspunt binnen Common Ground is gebruik van gegevens, niet opslag van gegevens. Dus de omschrijving (uitgeschreven waarde) is relevant voor de gebruiker.

## Volledige overerving van supertypen in schema
Entiteittypen die een subtype zijn van een ander (al dan niet abstract) entiteittype (supertype), worden als zodanig gespecificeerd in de Open API specificaties.
Bijvoorbeeld een "ingeschreven natuurlijk persoon" is een "natuurlijk persoon" is een "persoon" is een "subject". In Open API Specificaties 3 wordt dit gespecificeerd via allOf met referentie naar de schema component van het supertype.

*Ratio*
* Dit sluit aan bij een object georiënteerde ontwikkelstijl.
* Het bevordert hergebruik van code.
* Bevordert consistentie van implementatie van dezelfde gegevens uit supertypen voor verschillende subtypen.

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

## Verblijfadres opnemen in de ingeschreven natuurlijk persoon
In de resource van een ingeschreven natuurlijk persoon wordt het verblijfadres opgenomen.

Andere gerelateerde resources worden niet opgenomen.

Verblijfadres wordt als embedded resource opgenomen (dus niet platgeslagen in de persoon!), inclusief de uri ernaar in de BAG-registratie.

*Ratio*
* Veel van de bevragingen op persoonsgegevens hebben ook het verblijfsadres nodig.
* We werken toe naar linked data en common ground (gegevenslandschap architectuur), dus gerelateerde moet als resource herkenbaar blijven en bevraagbaar (via uri link) zijn.

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

## Een endpoint per combinatie van zoek parameters
Er wordt per combinatie van query parameters voor het zoeken van ingeschreven natuurlijk personen een endpoint gedefineerd. Bijvoorbeeld "/ingeschrevennatuurlijkpersonenpostcode" en "/ingeschrevennatuurlijkpersonengeslachtsnaam".

*Ratio*
* Ten behoeve van de implementeerbaarheid van de provider en het kunnen voldoen aan non-functionals door de provider is het niet wenselijk te vereisen dat elke combinatie van parameters wordt ondersteund. Daarom hoeven alleen gedefinieerde combinaties van parameters te worden ondersteund.
* Implementatie wordt vereenvoudigd en verduidelijkt door dit in API definities af te dwingen. Hiervoor is het nodig dat elke combinatie van parameters een eigen pad krijgt.

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

## Voor paginering bij collecties wordt geconformeerd aan API-46 van de API-strategie en Json+Hal toegepast.
Bij koppelvlakken waar gebruik gemaakt wordt van paginering wordt conform de API-strategie JSON+HAL toegepast. Om binnen het betreffende koppelvlak eenduidigheid te bewerkstelligen wordt Json+Hal in het hele koppelvlak toegepast.  
