---
layout: page-with-side-nav
title: Haal Centraal BRP persoon bevragen
---
# Haal Centraal {{ site.apiname }}

![lint oas](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/workflows/generate-postman-collection/badge.svg)

API voor het zoeken en raadplegen van actuele personen, partners, ouders en kinderen uit de basisregistratie personen (BRP), inclusief de registratie niet-ingezeten (RNI).
De API wordt nog niet door RvIG aangeboden. Om de migratie naar API's te versnellen besluiten sommige gemeenten de API zelf aan te bieden.

De laatste versie is 1.3.1. Lees de [release notes](releasenotes.md) om te zien wat er gewijzigd is.

Naast versie 2.0 beta (API-Lab) is ook versie 2.0 (IO) gepubliceerd.
Versie 2.0 beta (API-Lab) is de versie die is gebruikt tijdens het API-Lab van 7 april j.l. Lees de [Getting started](./getting-started-v2-beta).<br/>
started om de API Lab proefomgeving te bevragen.
Versie 2.0 (IO) is de versie waarmee de pilot wordt gestart. <!--Lees de [Getting started](./getting-started-v2-proxy) voor informatie over het gebruik van de proxy applicatie voor fase 1 van de pilot.-->

## Direct uitproberen?
* Bekijk de specificaties met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/swagger-ui) of [Redoc](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/redoc)
* Lees de [Getting started](./getting-started)
* Download de [technische specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}
* Download [client code](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/tree/master/code){:target="_blank" rel="noopener"}
* Vraag een API-key voor toegang tot de Haal Centraal probeeromgeving aan bij de product owner [c.dingemanse@comites.nl](mailto:c.dingemanse@comites.nl)

## Heb je meer nodig?
Gebruik de BRP bevragen API in combinatie met (een van de) andere BRP API’s:

* [Historische BRP-gegevens bevragen](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [Reisdocumenten bevragen](https://vng-realisatie.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [Bewoning en medebewoners bevragen](https://vng-realisatie.github.io/Haal-Centraal-BRP-bewoning){:target="_blank" rel="noopener"}
* [Landelijke tabellen bevragen](https://vng-realisatie.github.io/Haal-Centraal-BRP-tabellen-bevragen){:target="_blank" rel="noopener"}

## Bronnen

* [Productvisie Haal Centraal](https://vng-realisatie.github.io/Haal-Centraal){:target="_blank" rel="noopener"}
* [API Design Visie](https://github.com/Geonovum/KP-APIs/tree/master/Werkgroep%20Design%20Visie){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}
* [Stelselcatalogus](https://www.stelselcatalogus.nl/registraties/BRP/){:target="_blank" rel="noopener"}

## Contact

* Product Owner: Cathy Dingemanse, [c.dingemanse@comites.nl](mailto:c.dingemanse@comites.nl)
* Designer: Johan Boer, [johan.boer@vng.nl](mailto:johan.boer@vng.nl)
* Designer: Robert Melskens, [robert.melskens@vng.nl](mailto:robert.melskens@vng.nl)
* Customer zero: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@iswish.nl)
* Tester: Frank Samwel, [frank.samwel@denhaag.nl](mailto:frank.samwel@denhaag.nl)

## Licentie

Copyright &copy; VNG Realisatie 2020
Licensed under the [EUPL](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/LICENCE.md){:target="_blank" rel="noopener"}
