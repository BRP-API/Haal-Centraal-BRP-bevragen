---
layout: page-with-side-nav
title: Haal Centraal BRP Personen
---
# {{ site.apiname }}

![lint oas]({{ site.repoUrl }}/workflows/lint-oas/badge.svg)

API voor het zoeken en raadplegen van actuele personen, partners, ouders en kinderen uit de basisregistratie personen (BRP), inclusief de registratie niet-ingezeten (RNI).
De API biedt naast persoonsgegevens uit de BRP ook de informatieproducten leeftijd, aanschrijfwijze, aanhef, een verwijzing naar een persoon in de tekst van een brief, en adressering (passend op een vensterenvelop). Zo kan RvIG beter voorzien in klantbehoeften, en hoeven onze klanten minder persoonsgegevens te verwerken. Hiervoor is een wetwijziging nodig: het [Experimentbesluit Dataminimalisatie](https://www.rijksoverheid.nl/documenten/besluiten/2023/08/28/experimentbesluit-brp-dataminimalisatie-amvb-nvt-versie-voorhang). 

## Planning en Roadmap
De API is live sinds mei 2023. Verwacht wordt dat het Experimentbesluit Dataminimalisatie in het tweede kwartaal van 2024 in werking treedt. Tot die tijd gebruiken afnemers een "BrpProxy API" die de bewerking tot informatieproducten bij afnemers uitvoert. De "BrpProxy API" wordt door RvIG verstrekt. 

## Aansluiten en voorwaarden
Gemeenten en andere afnemers van de BRP met een autorisatiebesluit voor verstrekking van een zoekvraag mogen deelnemen aan het experiment en de BRP API gebruiken. Iedere deelnemer sluit een convenant met RvIG waarin de afspraken voor deelname zijn vastgelegd. Voor de technische aansluiting is een API Gateway nodig. Aansluiten kan via Diginetwerk met gebruik van een TLS verbinding (PKIO certificaat) en een OAuth 2.0 token (OAuth 2.0 client credentials flow).

Stuur een mail naar [info@RvIG](mailto:info@rvig) voor een kennismakingmakingsgesprek en onboarding. [Download]({{ site.onboardingUrl }}){:target="_blank" rel="noopener"} en lees het onboardingproces.

## Direct uitproberen?
* Bekijk de specificaties met [Redoc](./v2/redoc)
* Lees de [Getting started](./v2/getting-started)

## Heb je meer nodig?
Gebruik de BRP Personen bevragen API in combinatie met (een van de) andere BRP Bevragen API’s:

* [BRP Historie]({{ site.pagesBaseUrl }}/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [BRP Reisdocumenten]({{ site.pagesBaseUrl }}/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [BRP Bewoning]({{ site.pagesBaseUrl }}/Haal-Centraal-BRP-bewoning){:target="_blank" rel="noopener"}

Maak je nog gebruik van versie 1.3.1? Bekijk de specificaties met [Swagger UI](./v1/swagger-ui) of [Redoc](./v1/redoc) en download de [technische specificaties]({{ site.v1SpecUrl }}){:target="_blank" rel="noopener"}

## Bronnen

* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Heb je een vraag? Neem contact op met Cathy Dingemanse, [{{ site.PO-email }}](mailto:{{ site.PO-email }}) 
* Bug Melden
  [Maak een bug issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Maak een verbeter issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [{{ site.PO-email }}](mailto:{{ site.PO-email }})
* Customer zero: Melvin Lee, [{{ site.CZ-email }}](mailto:{{ site.CZ-email }})
* Tester: Frank Samwel, [{{ site.Tester-email }}](mailto:{{ site.Tester-email }})

## Licentie

Copyright &copy; RvIG 2022
Licensed under the [EUPL]({{ masterBranchUrl }}/LICENCE.md){:target="_blank" rel="noopener"}
