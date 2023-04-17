---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

Alle gemeenten en andere organisaties met een autorisatiebesluit conform artikel 38 van het Besluit BRP kunnen zich aanmelden voor deelname aan de pilot BRP.

1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. Probeer en test de API [lokaal](#probeer-en-test-de-api-lokaal) of in de [proef omgeving](#probeer-en-test-de-api-in-de-proef-omgeving)
3. [Download]({{ site.onboardingUrl }}){:target="_blank" rel="noopener"} en lees het onboardingproces

## Functionaliteit en specificaties

De '{{ site.apiname }}' Web API is gespecificeerd met behulp van de [OpenAPI Specification v3.0.3](https://spec.openapis.org/oas/v3.0.3).

De OAS3 specificatie van de '{{ site.apiname }}' Web API kan worden bekeken met behulp van [Redoc](./redoc).

Download de [OAS3 specificatie]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"} van de '{{ site.apiname }}' Web API om hiermee consumer code te genereren.

De [funtionele documentatie](./features-overzicht) van de '{{ site.apiname }}' Web API vindt je in de [features overzicht](./features-overzicht).

## Probeer en test de API in de proef omgeving

De '{{ site.apiname }}' Web API kan worden geprobeerd via de proef omgeving met de volgende url: [{{ site.proefProxyUrl }}]. Hiervoor heb je een apikey nodig.

- Vraag een apikey aan bij de product owner [{{ site.PO-email }}](mailto:{{ site.PO-email }}). De apikey die is uitgereikt op de API Labs kan ook worden gebruikt.
- Voeg de apikey toe aan een request met de __X-API-KEY__ header.

## Probeer en test de API lokaal

Door wettelijke restricties kan de '{{ site.apiname }}' Web API bepaalde bewerkingen niet uitvoeren. Er wordt op dit moment aan gewerkt om deze restricties weg te halen. Totdat dit is gerealiseerd moet de BrpProxy worden gebruikt om de bewerkte gegevens te kunnen krijgen. De BrpProxy is consumer van de GBA variant van de '{{ site.apiname }}' Web API en levert responses conform de {{ site.apiname }} [OAS3 specificatie]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.

De BrpProxy is geïmplementeerd als een containerized applicatie, zodat het makkelijk kan worden getest op een lokale machine en worden gehost in een productie omgeving.

Het [docker compose bestand]({{ site.devBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"} kan worden gebruikt om met behulp van [Docker Desktop](https://www.docker.com/products/docker-desktop) de BrpProxy en de mock van de '{{ site.apiname }}' Web API GBA variant te draaien op een lokale machine.

In plaats van het docker compose bestand kunnen de [Kubernetes configuratie bestanden]({{ site.devBranchUrl}}/.k8s){:target="_blank" rel="noopener"} worden gebruikt om de BrpProxy en de mock van de '{{ site.apiname }}' Web API GBA variant te draaien op een lokale machine.

De mock van de '{{ site.apiname }}' Web API GBA variant is bedoeld voor development/test doeleinden. Deze mock gebruikt de [testdataset persoonslijsten proefomgevingen GBA-V](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v) als input om de productie situatie zoveel mogelijk te kunnen simuleren.

De volgende paragrafen beschrijven het installeren en aanroepen van de BrpProxy op een lokale machine.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) voor het hosten van containers
- Docker Desktop kan ook worden gebruikt om de containers te hosten met behulp van Kubernetes engine. Hiervoor moet in Docker Desktop Kubernetes ondersteuning worden aangezet in de Settings/Kubernetes configuratie scherm ![Enable Kubernetes](../img/docker-desktop-enable-k8s.png)

Optioneel kan de volgende tools ook op de lokale machine worden geïnstalleerd

- [git](https://git-scm.com/downloads) voor het clonen van git repositories
- [Postman](https://www.postman.com/downloads/) voor het aanroepen van Web APIs


### Gebruik Docker als container engine

- Download het [docker compose bestand]({{ site.devBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"}
- Start een command prompt window voor de map met het docker-compose.yaml bestand
- Start de BrpProxy en de mock met behulp van de volgende statement:
  ```sh

  docker-compose up -d

  ```
  De BrpProxy is nu te benaderen via de url: *http://localhost:5001/haalcentraal/api/brp/personen*
- Valideer dat de BrpProxy en de mock draaien met behulp van de volgende curl statement:
  ```sh

  curl --location --request POST 'http://localhost:5001/haalcentraal/api/brp/personen' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "type": "RaadpleegMetBurgerservicenummer",
      "burgerservicenummer": ["999993653"],
      "fields": ["burgerservicenummer"]
  }'

  ```
- Om de BrpProxy en de mock containers te stoppen moet de volgende statement worden uitgevoerd:
  ```sh

  docker-compose down

  ```

### Gebruik Kubernetes als container engine

- Download de [kubernetes configuratie bestanden]({{ site.devBranchUrl }}/.k8s){:target="_blank" rel="noopener"}
- Start een command prompt window voor de map met de kubernetes manifest bestanden
- Start de BrpProxy en de mock met behulp van de volgende statement:
  ```sh

  kubectl apply -f .k8s/brpproxy-deployment.yaml \
                -f .k8s/brpproxy-service.yaml \
                -f .k8s/gbamock-deployment.yaml \
                -f .k8s/gbamock-service.yaml 

  ```
  De BrpProxy is nu te benaderen via de url: *http://localhost:5001/haalcentraal/api/brp/personen*
- Valideer dat de BrpProxy en de mock draaien met behulp van de volgende curl statement:
  ```sh

  curl --location --request POST 'http://localhost:5001/haalcentraal/api/brp/personen' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "type": "RaadpleegMetBurgerservicenummer",
      "burgerservicenummer": ["999993653"],
      "fields": ["burgerservicenummer"]
  }'

  ```
- Om de BrpProxy en de mock containers te stoppen moet de volgende statement worden uitgevoerd:
  ```sh

  kubectl delete -f .k8s/brpproxy-deployment.yaml \
                 -f .k8s/brpproxy-service.yaml \
                 -f .k8s/gbamock-deployment.yaml \
                 -f .k8s/gbamock-service.yaml 

  ```
