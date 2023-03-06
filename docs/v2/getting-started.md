---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

Alle gemeenten en andere organisaties met een autorisatiebesluit conform artikel 38 van het Besluit BRP kunnen zich aanmelden voor deelname aan de pilot BRP.

## Functionaliteit en specificaties

De '{{ site.apiname }}' Web API is gespecificeerd met behulp van de [OpenAPI Specification v3.0.3](https://spec.openapis.org/oas/v3.0.3).

De OAS3 specificatie van de '{{ site.apiname }}' Web API kan worden bekeken met behulp van [Redoc](./redoc) of [Swagger](./swagger-ui)

Download de [OAS3 specificatie]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"} van de '{{ site.apiname }}' Web API om hiermee consumer code te genereren.

De [funtionele documentatie](./features-overzicht) van de '{{ site.apiname }}' Web API vindt je in de [features overzicht](./features-overzicht)

## Probeer en test de BrpProxy

Door wettelijke restricties kan de '{{ site.apiname }}' Web API bepaalde bewerkingen niet uitvoeren. Er wordt op dit moment aan gewerkt om deze restricties weg te halen. Totdat dit is gerealiseerd moet de BrpProxy worden gebruikt om de bewerkte gegevens te kunnen krijgen. De BrpProxy is consumer van de GBA variant van de '{{ site.apiname }}' Web API en levert responses conform de {{ site.apiname }} [OAS3 specificatie]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.

De BrpProxy is geïmplementeerd als een containerized applicatie, zodat het makkelijk kan worden getest op een lokale machine en worden gehost in een productie omgeving.

Het [docker compose bestand]({{ site.devBranchUrl }}/blob/develop/docker-compose.yml){:target="_blank" rel="noopener"} kan worden gebruikt om met behulp van [Docker Desktop](https://www.docker.com/products/docker-desktop) de BrpProxy en de mock van de '{{ site.apiname }}' Web API GBA variant te draaien op een lokale machine.

De mock van de '{{ site.apiname }}' Web API GBA variant is bedoeld voor development/test doeleinden. Deze mock gebruikt de [testdataset persoonslijsten proefomgevingen GBA-V](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v) als input om de productie situatie zoveel mogelijk te kunnen simuleren.

De volgende paragrafen beschrijven het installeren en aanroepen van de BrpProxy op een lokale machine.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) voor het hosten van containers

Optioneel kan de volgende tools ook op de lokale machine worden geïnstalleerd

- [git](https://git-scm.com/downloads) voor het clonen van git repositories
- [Postman](https://www.postman.com/downloads/) voor het aanroepen van Web APIs

### Clone de {{ site.apiname }} git repository of download het docker compose bestand

- Download het [docker compose bestand]({{ site.devBranchUrl }}/blob/develop/docker-compose-mock.yml){:target="_blank" rel="noopener"} of clone de {{ site.apiname }} repository als deze niet eerder al is ge-clone-d
  ```sh

  git clone {{ site.repoUrl }}.git

  ```
- Ga naar de folder waar het [docker compose bestand]({{ site.devBranchUrl }}/blob/develop/docker-compose-mock.yml){:target="_blank" rel="noopener"} is gedownload of ga naar de door git aangemaakte folder
  ```sh

  cd Haal-Centraal-BRP-bevragen

  ```
- Haal de laatste wijzigingen/toevoegingen op als de {{ site.apiname }} git repository op een eerder moment is ge-clone-d
  ```sh

  git pull
 
  ```

### Draaien van de BrpProxy en de mock van de '{{ site.apiname }}' Web API GBA variant

- Start de BrpProxy en de mock met behulp van de volgende statement:
  ```sh

  docker-compose up -d

  ```
- De {{ site.apiname }} Web API kan nu worden bevraagd. Gebruik als base url: *http://localhost:5001*. Met behulp van curl kan op een snelle manier worden getest of de BrpProxy en de mock draaien. Start hiervoor een bash shell en voer de volgende curl statement uit in de bash shell:
  ```sh

  curl --location --request POST 'http://localhost:5001/haalcentraal/api/brp/personen' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "type": "RaadpleegMetBurgerservicenummer",
      "burgerservicenummer": ["999993653"],
      "fields": ["burgerservicenummer"]
  }'

  ```
- Bevraag de {{ site.apiname }} Web API met behulp van Postman. Download en importeer hiervoor de {{ site.apiname }} [OAS3 specificatie]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"} of de [Postman collection met aanroep voorbeelden]({{ site.devBranchUrl }}/test/BRP-Bevragen-v2-postman-collection.json).
- Voor het stoppen van de BrpProxy en de mock kan de volgende statement worden uitgevoerd:
  ```sh

  docker-compose down

  ```
