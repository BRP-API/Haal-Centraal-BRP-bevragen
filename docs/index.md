---
layout: page-with-side-nav
title: Haal Centraal BRP bevragen
---
# Haal Centraal BRP bevragen

![lint oas](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/workflows/lint-oas/badge.svg)
![generate sdks](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/workflows/generate-sdks/badge.svg)
![generate postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/workflows/generate-postman-collection/badge.svg)

API voor het zoeken en raadplegen van actuele personen, partners, ouders en kinderen uit de basisregistratie personen (BRP), inclusief de registratie niet-ingezeten (RNI).
De API wordt nog niet door RvIG aangeboden. Om de migratie naar API's te versnellen besluiten sommige gemeenten de API zelf aan te bieden.
RvIG implementeert de API zonder verschillende [afgeleide gegevens](rvig_en_proxy). Daarom wordt er ook een [proxy API](rvig_en_proxy) ontwikkeld waarmee deze afgeleide gegevens weer kunnen worden toegevoegd.

De laatste versie is 1.3.0. Lees de [release notes](releasenotes.md) om te zien wat er gewijzigd is.

## Direct uitproberen?
* Bekijk de specificaties met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/swagger-ui) of [Redoc](https://vng-realisatie.github.io/Haal-Centraal-BRP-bevragen/redoc)
* Lees de [Getting started](./getting-started)
* Download de [technische specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}
* Download [client code](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/tree/master/code){:target="_blank" rel="noopener"}
* Vraag een API-key voor toegang tot de Haal Centraal probeeromgeving aan bij de product owner [cathy.dingemanse@denhaag.nl](mailto:cathy.dingemanse@denhaag.nl)

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

* Product Owner: Cathy Dingemanse, [cathy.dingemanse@denhaag.nl](mailto:cathy.dingemanse@denhaag.nl)
* Designer: Johan Boer, [johan.boer@vng.nl](mailto:johan.boer@vng.nl)
* Designer: Robert Melskens, [robert.melskens@vng.nl](mailto:robert.melskens@vng.nl)
* Customer zero: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@iswish.nl)
* Tester: Frank Samwel, [frank.samwel@denhaag.nl](mailto:frank.samwel@denhaag.nl)

## Licentie

Copyright &copy; VNG Realisatie 2020
Licensed under the [EUPL](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/LICENCE.md){:target="_blank" rel="noopener"}
