---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De '{{site.apiname}}' Web API is gespecificeerd in OpenAPI specifications (OAS). Alle gemeenten en andere organisaties met een autorisatiebesluit conform artikel 38 van het Besluit BRP kunnen zich aanmelden voor deelname aan de pilot BRP.

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API Client](#implementeer-de-api-client)
3. [Probeer en test de API](#probeer-en-test-de-brpproxy)
4. [Download en lees het onboarding proces]({{ site.mainBranchUrl }}/docs/230118%20deelname%20experiment%20BRP%20API's%20v1.3.ppsx){:target="_blank" rel="noopener"}

## Functionaliteit en specificaties

Je kunt een visuele representatie van de specificatie genereren met [Redoc](./redoc-io).

De (resolved) OAS3 kun je hier downloaden: [openapi.yaml]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.

De [functionele documentatie](./features-v2) vind je in [features](./features-v2).

## Implementeer de API client
Client code kun je genereren met de "[genereervariant]({{ site.devBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht met codegeneratoren kun je vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee je met [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kunt genereren in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kun je met `npm install` de benodigde packages installeren en kun je met `npm run <script naam>` één van de volgende scripts uitvoeren:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties kun je vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite van OpenAPI Generator is JAVA. Je moet een JAVA runtime installeren voordat je OpenAPI Generator kunt gebruiken

## Probeer en test de BrpProxy

Door wettelijke restricties kan de BRP bevragen API bepaalde bewerkingen niet uitvoeren. Er wordt op dit moment aan gewerkt om deze restricties weg te halen. Totdat dit is gerealiseerd moet de BrpProxy worden gebruikt om de bewerkte gegevens te kunnen krijgen. De BRP proxy is consumer van de Personen Bevragen GBA variant en levert de Personen Bevragen API v2.0.

De BrpProxy is geïmplementeerd als een containerized applicatie, zodat het makkelijk kan worden getest op een lokale machine en gehost in een productie omgeving.

Er is een referentie implementatie van een docker-compose configuratie te vinden in de repository die kan worden gebruikt om de BRP Proxy te draaien op een lokale machine.

Voor test doeleinden is een mock van de RvIG variant van de BRP Persoon Bevragen API (GBA Variant) geïmplementeerd. Deze mock gebruikt de [testdataset persoonslijsten proefomgevingen GBA-V](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v) als input om de productie situatie zoveel mogelijk te kunnen simuleren.

Ten behoeve van monitoring is Open Telemetry geïntegreerd in de BrpProxy. Met behulp van de docker-compose configuratie bestand wordt ook een [Jaeger](https://www.jaegertracing.io/) Container opgestart om de trace regels van de BrpProxy te visualiseren.

Voor logging past de BrpProxy structured logging toe. Dit maakt het makkelijker voor tooling om de log regels te query-en en te filteren. Voor het visualiseren van de logging wordt [Seq](https://datalust.co/seq) gebruikt.

In de volgende paragrafen is beschreven hoe de BrpProxy  t.b.v. test doeleinden op een lokale machine kan worden geïnstalleerd en geconfigureerd.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [git](https://git-scm.com/downloads)

### Bouwen van de BrpProxy Container Image

- Clone de Haal Centraal BRP Persoon bevragen repository als deze niet eerder al is ge-clone-d<br/><br/>
  ```sh
  git clone {{ site.repoUrl }}.git
  ```
- Ga naar de aangemaakte folder<br/><br/>
  ```sh
  cd Haal-Centraal-BRP-bevragen
  ```
- Switch naar de `develop` branch<br/><br/>
  ```sh
  git checkout develop
  ```
- Download de laatste wijzigingen/toevoegingen als de Haal Centraal BRP bevragen repository op een eerder moment is ge-clone-d<br/><br/>
  ```sh
  git pull
  ```
- Bouw de BrpProxy Container Image. Dit kan enige tijd duren.<br/><br/>
  ```sh
  docker-compose build
  ```

### Opstarten van de BrpProxy Container

- Start de BrpProxy<br/><br/>
  ```sh
  docker-compose up -d
  ```
- Roep de BRP Persoon Bevragen API aan met als base url: *http://localhost:5000*. Met behulp van curl kan op een snelle manier worden getest of de BrpProxy en de BrpService draaien. Start hiervoor een bash shell op en voer de volgende curl statement uit in de bash shell<br/><br/>
  ```sh
  curl --location --request POST 'http://localhost:5000/haalcentraal/api/brp/personen' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "type": "RaadpleegMetBurgerservicenummer",
      "burgerservicenummer": ["999993653"],
      "fields": ["burgerservicenummer"]
  }'
  ```
- Optioneel kan postman worden gebruikt om de BrpProxy te testen. Importeer de `BRP-Bevragen-v2-postman-collection.json` postman collection onder de `test` map voor aanroep voorbeelden.  
- Bekijk de log regels van de BrpProxy met behulp van Seq. Navigeer hiervoor naar: `http://localhost:5341`
- Bekijk de trace regels van de BrpProxy met behulp van Jaeger. Navigeer hiervoor naar: `http://localhost:16686`

### Stoppen van de BrpProxy Container

- Stop de BrpProxy<br/><br/>
  ```sh
  docker-compose down
  ```

### Configureren van de BrpProxy

De BrpProxy luistert standaard op poort 5000 van de host machine. Om dit te wijzigen moet de *ports* setting van de **brpproxy** in het **docker-compose.yml** bestand worden aangepast:

```yaml
...
brpproxy:
  ...
  ports:
    - "<nieuwe host poort>:5000"
  ...
```

#### Routering

De routering van de BrpProxy wordt geconfigureerd in het **/src/config/BrpProxy/configuration/ocelot.json** bestand.
Requests die matchen met de waarde in de *UpstreamPathTemplate* worden gerouteerd naar de urls gedefinieerd met behulp van de *Downstream* parameters. Een downstream url wordt als volgt opgebouwd: `<DownstreamScheme>://<DownstreamHostAndPorts.Host>:<DownstreamHostAndPorts.Port><DownstreamPathTemplate>`. Standaard ziet een Downstream url er als volgt uit: `http://brpservice:5010/haalcentraal/api/brp/personen`.

Om requests naar `http://localhost:5000/personen` te routeren naar `http://haalcentraal_api/haalcentraal/api/brp/v2/personen` moet de configuratie als volgt worden aangepast:

```json
{
  "Routes": [
    {
      "UpstreamPathTemplate": "/personen",
      "DownstreamPathTemplate": "/haalcentraal/api/brp/v2/personen",
      "DownstreamScheme": "http",
      "DownstreamHostAndPorts": [
        {
          "Host": "haalcentraal_api",
          "Port": "80"
        }
      ]
    }
  ]
}
```

#### mTLS

De BrpProxy kan worden geconfigureerd voor *mutual TLS*. Hiervoor moeten de volgende variabelen voor de BrpProxy container worden gezet:
- environment
  - ClientCertificate__Name. Dit moet overeenkomen met de bestandsnaam van de client certificaat
  - ClientCertificate__Password. Dit moet overeenkomen met het wachtwoord dat is gebruikt bij het aanmaken van de client certificaat
- volumes
  - mapping van de folder waar de client certificaat staat naar de `/app/certificates` folder van de container

In het **docker-compose.yml** bestand, is onder de *brpproxy* service deze variabelen terug te vinden.

#### Logging

Standaard logt de BrpProxy alleen warning en error log berichten. Dit wordt geconfigureerd in het `src\config\BrpProxy\appsettings\appsettings.json` bestand met behulp van de **Serilog:MinimumLevel:Override:BrpProxy** setting. Standaard heeft deze de waarde `Warning`. Om de BrpProxy te debuggen, moet deze worden gezet op `Debug`.

### Testpersonen

Deze tabel bevat fictieve burgerservicenummers van testpersonen voor specifieke situaties waarmee de 'Bevraging Persoon' Web API kan worden getest.

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
Een vertaling van GBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping]({{ site.mainBranchUrl }}/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"}.
