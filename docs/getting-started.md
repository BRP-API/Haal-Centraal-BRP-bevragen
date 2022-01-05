---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'Bevraging Ingeschreven Persoon' Web API is gespecificeerd in OpenAPI specifications (OAS).

Wil je de API gebruiken? Dit kun je doen:

1. [Bekijk de functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API](#bouw-de-api)
3. [Probeer en test de API](#probeer-en-test-de-api)

## Functionaliteit en specificaties

Je kunt een visuele representatie van de specificatie genereren met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

De (resolved) OAS3 kun je hier downloaden: [openapi.yaml](https://github.com/VNG-Realisatie{{ site.baseurl }}/blob/master/specificatie/genereervariant/openapi.yaml).

De [functionele documentatie](./features) vind je in [features](./features).

## Bouw de API
Client code kan worden gegenereerd vanuit de "[genereervariant](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht van code generatoren is te vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee met behulp van [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kan worden gegenereerd in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kan met `npm install` de benodigde packages worden geïnstalleerd. Vervolgens kan met `npm run <script naam>` één van de volgende scripts worden uitgevoerd:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties is te vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite OpenAPI Generator is JAVA. Een JAVA runtime moet worden geïnstalleerd voordat OpenAPI Generator kan worden gebruikt.

## Probeer en test de API

Wil je de 'Bevraging Ingeschreven Persoon' Web API proberen en testen? Kijk op: `https://www.haalcentraal.nl/haalcentraal/api/brp`

Om de web api te gebruiken heb je een apikey nodig. Deze voeg je aan een request toe als header "X-API-KEY". Een API-key vraag je aan bij de product owner [c.dingemanse@comites.nl](c.dingemanse@comites.nl).

__De Haal Centraal probeeromgeving gebruikt GBA-V op basis van de gemeentelijke autorisatie "Algemene gemeentetaken" voor buitengemeentelijke personen. Dit betekent dat de GBA-V niet alle gegevens teruggeeft die in de response zijn gedefinieerd. In de [API mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"} kun je zien welke gegevens wel of niet onder deze autorisatie vallen.__

__Je kan de Haal Centraal probeeromgeving niet gebruiken vanuit de browser, dus ook niet vanuit de browserversie van Postman. Gebruik dus de desktopversie van een testtool (zoals Postman) om berichten te sturen.__

### Importeer de specificaties in Postman

De werking van de 'Bevraging Ingeschreven Persoon' Web API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/){:target="_blank" rel="noopener"}. We hebben al een [Postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/test/BRP-Bevragen-postman-collection.json){:target="_blank" rel="noopener"} voor je klaargezet. Deze kun je importeren in Postman.

In Postman kun je de 'Bevraging Ingeschreven Persoon' OpenAPI specificatie importeren en visueel de verschillende endpoints aanroepen. Volg deze stappen om het OpenAPI specificatie bestand te importeren:

![Import](./img/1-click-import-button.jpg)  

1.Klik op de Import button om de Import dialog box te openen

!['Import From Link'](./img/2-select-import-from-link-tab.jpg)  
2.Selecteer 'Import From Link' tab, plak de volgende url in de 'Enter a URL and press Import' textbox en klik op de Import button

``` url
https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/master/specificatie/genereervariant/openapi.yaml
```

![Generate Postman collection](./img/3-generate-postman-collection.jpg)  
3.Klik op de Next button om een Postman collectie te genereren uit het OpenAPI specificatie bestand

![Postman collection overview](./img/4-postman-collection-overview.jpg)  
4.Import overzicht

### Configureer de url en api key

1. Klik bij "Bevragingen Ingeschreven Personen" op de drie bolletjes.
![Generate Postman collection](./img/edit-collection.png)
2. Klik vervolgens op Edit
3. Selecteer tabblad "Authorization"
4. Kies TYPE "API Key"
5. Vul in Key: "x-api-key", Value: de API key die je van Cathy hebt ontvangen, Add to: "Header"
6. Selecteer tabblad "Variables"
7. Vul bij baseUrl INITIAL VALUE en bij CURRENT VALUE: `https://www.haalcentraal.nl/haalcentraal/api/brp`
8. Klik op de knop Update

### Raadpleeg een Ingeschreven Natuurlijk Persoon

Selecteer hiervoor de /GET ingeschreven Natuurlijk Persoon request.  
![/GET ingeschreven Natuurlijk Persoon request](./img/5-select-request.jpg)  
In het rechterscherm zie je een invoerscherm voor de request. Uncheck voor de volgende voorbeeldaanroep de expand en fields Query Params en vul in de burgerservicenummer Path Variabele een bsn in (zie onderaan de Getting started voor mogelijke burgerservicenummers).

Klik op de Send button om de request naar de endpoint te sturen. De Web API reageert dan met een response:  
![Response](./img/7-response.jpg)

De Web API gebruikt de HAL (Hypertext Application Language) standaard om links op te nemen naar gerelateerde resources en/of om bij een resource gerelateerde resources op te nemen (embedden).  
In de response hierboven kun je zien dat het _links/ouders element links bevat naar de ouders van de persoon.

Je kunt ook oudergegevens embedden bij het bevragen van een persoon. Dit doe je met de `expand` Query Parameter. Behalve de ouders kun je ook kind(-eren) en partner(s) in de bevraging van een ingeschreven persoon embedden. Deze gegevens zijn te vinden onder de _embedded element:
![expand parameter](./img/8-using-expand-parameter.jpg)  
In dit figuur zie je hoe de `expand` Query Parameter eruit moet zien om de ouders, kinderen en partner te embedden in de response van een ingeschreven persoon.

Je kunt ook alleen specifieke kenmerken van een ingeschreven persoon opvragen met behulp van de `fields` Query Parameter. Hieronder zie je een bevraging met de `fields` Query Parameter gezet op `burgerservicenummer,naam,geboorte.datum`.
![fields parameter](./img/9-using-fields-parameter.jpg)

### Testpersonen

Deze tabel bevat de burgerservicenummers van testpersonen voor specifieke situaties waarmee de 'Bevraging Ingeschreven Persoon' Web API kan worden getest.

burgerservicenummer | situatie
---------------- | :-------  
999993847 | ouders, partner, kinderen, BAG-adres, verblijfplaats in onderzoek
999992077 | overleden
999993483 | geëmigreerd, verblijf buitenland, geheimhouding, uitgebreide verblijfplaatshistorie
999990482 | niet-BAG adres
000009921 | locatiebeschrijving
999993653 | niet-Nederlandse nationaliteit, ouders niet ingeschreven
999995017 | actuele en historische verblijfstitel
999990408 | gezag minderjarige
999994669 | verblijfplaatshistorie met verblijf buitenland en locatiebeschrijving en adrescorrectie
999992806 | uitgebreide verblijfstitelhistorie
999993926 | actuele en meerdere ex-partners
999991905 | twee beëindigde relaties
999993550 | partner niet ingeschreven
999990421 | meerdere kinderen, wel en niet-ingeschreven

De API gebruikt de GBA-V proefomgeving. Alle testpersonen die daarin voorkomen kun je ook in de API gebruiken. De volledige set testpersonen kan worden gedownload bij de [RvIG](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v){:target="_blank"}.
Een vertaling van GBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"}.
