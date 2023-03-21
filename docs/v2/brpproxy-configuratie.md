---
layout: page-with-side-nav
title: Configureren van de BrpProxy
---

# BrpProxy configuratie

## Routering

Standaard is de BrpProxy geconfigureerd om bevragingen door te sturen naar de mock van de {{ site.apiname }} Web API GBA variant.

De __Downstream__ configuratie van de BrpProxy moet worden aangepast om bevragingen door te sturen naar een instantie van de {{ site.apiname }} Web API GBA variant.

### Wijzigen van de Downstream configuratie van de BrpProxy (Docker Compose variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de BrpProxy in het [docker compose bestand]({{ site.devBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. De communicatie protocol die moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. De port nummer van de {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de BrpProxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

  brpproxy:
    container_name: brpproxy
    image: iswish/haal-centraal-brp-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Routes__0__DownstreamScheme=https
      - Routes__0__DownstreamHostAndPorts__0__Host=proefomgeving-gba.haalcentraal.nl
      - Routes__0__DownstreamHostAndPorts__0__Port=443
    ports:
      - "5001:5000"

```

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een Volume te monteren aan een container instantie.

In het volgende voorbeeld is de configuratie van de routering naar de proef omgeving van de {{ site.apiname }} Web API GBA variant gespecificeerd. Dit [configuratie bestand] is ook te vinden in de {{ site.apiname }} GitHub repository. in het [ocelot.json]({{ site.devBranchUrl }}/src/config/BrpProxy/configuration/ocelot.json){:target="_blank" rel="noopener"}.

```json

{
  "Routes": [
    {
      "UpstreamPathTemplate": "/haalcentraal/api/brp/personen",
      "DownstreamPathTemplate": "/haalcentraal/api/brp/personen",
      "DownstreamScheme": "https",
      "DownstreamHostAndPorts": [
        {
          "Host": "proefomgeving-gba.haalcentraal.nl",
          "Port": "443"
        }
      ]
    }
  ]
}

```

Het configuratie bestand wordt vervolgens met behulp van een volume gemonteerd aan een BrpProxy instantie. In onderstaand voorbeeld wordt het ocelot.json bestand in de src/config/BrpProxy/configuration map gemonteerd aan een BrpProxy instantie.

```yaml

  brpproxy:
    container_name: brpproxy
    image: iswish/haal-centraal-brp-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
    ports:
      - "5001:5000"
    volumes:
      - ./src/config/BrpProxy/configuration/ocelot.json:/app/configuration/ocelot.json

```

### Wijzigen van de Downstream configuratie van de BrpProxy (Kubernetes variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de BrpProxy in het [brpproxy deployment bestand]({{ site.devBranchUrl }}/.k8s/brpproxy-deployment.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. De communicatie protocol die moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. De port nummer van de {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de BrpProxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

      containers:
        - name: brpproxy
          image: iswish/haal-centraal-brp-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
            - name: Routes__0__DownstreamScheme
              value: https
            - name: Routes__0__DownstreamHostAndPorts__0__Host
              value: proefomgeving-gba.haalcentraal.nl
            - name: Routes__0__DownstreamHostAndPorts__0__Port
              value: "443"
          ports:
            - name: http-brpproxy
              containerPort: 5000

```

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een Volume te monteren aan een container instantie.

In het volgende voorbeeld is de configuratie van de routering naar de proef omgeving van de {{ site.apiname }} Web API GBA variant gespecificeerd. Dit [configuratie bestand] is ook te vinden in de {{ site.apiname }} GitHub repository. in het [ocelot.json]({{ site.devBranchUrl }}/src/config/BrpProxy/configuration/ocelot.json){:target="_blank" rel="noopener"}.

```json

{
  "Routes": [
    {
      "UpstreamPathTemplate": "/haalcentraal/api/brp/personen",
      "DownstreamPathTemplate": "/haalcentraal/api/brp/personen",
      "DownstreamScheme": "https",
      "DownstreamHostAndPorts": [
        {
          "Host": "proefomgeving-gba.haalcentraal.nl",
          "Port": "443"
        }
      ]
    }
  ]
}

```

Het configuratie bestand wordt vervolgens met behulp van een volume mount gemonteerd aan een BrpProxy instantie. In onderstaand voorbeeld wordt het ocelot.json bestand in de src/config/BrpProxy/configuration map gemonteerd aan een BrpProxy instantie.

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: brpproxy
  labels:
    app: haal-centraal-brp-bevragen-api
spec:
  replicas: 1
  selector:
    matchLabels:
      name: brpproxy
  template:
    metadata:
      labels:
        name: brpproxy
    spec:
      containers:
        - name: brpproxy
          image: iswish/haal-centraal-brp-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
          ports:
            - name: http-brpproxy
              containerPort: 5000
          volumeMounts:
            - name: brpproxy-routing-configuration
              mountPath: /app/configuration
      volumes:
        - name: brpproxy-routing-configuration
          hostPath:
            path: {{ host-path }}/Haal-Centraal-BRP-bevragen/src/config/BrpProxy/configuration

```

waarbij **host-path** gelijk is aan

- */run/desktop/mnt/host/c/Haal-Centraal-BRP-bevragen/src/config/BrpProxy/configuration* voor een Windows machine waarop Docker Desktop is geïnstalleerd en Kubernetes ondersteuning is aangezet en de {{ site.api }} repository is gecloned naar de c:/Haal-Centraal-BRP-bevragen map.

## Logging

Standaard is de BrpProxy geconfigureerd met Log level `Warning`. Bij deze Log level wordt alleen ongeldige bevragingen (bevraging die resulteren in een 4XX en 5XX HTTP status response) gelogd.

Om alle bevragingen (inclusief de request body) te loggen moet de Log level op `Information` worden gezet. Dit wordt gedaan met behulp van de *Serilog__MinimumLevel__Override__BrpProxy* environment variabele.

In het volgend voorbeeld is de BrpProxy geconfigureerd met Log level op `Information`

```yaml

  brpproxy:
    container_name: brpproxy
    image: iswish/haal-centraal-brp-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Serilog__MinimumLevel__Override__BrpProxy=Information
    ports:
      - "5001:5000"

```

Bij Log level `Information` worden de waarden van gevoelige parameters in de request body gemaskeerd gelogd. Voor debug doeleinden kan de Log level op `Debug` worden gezet. Bij de `Debug` Log level worden parameter waarden niet gemaskeerd.

De logs zijn te vinden in de Logs tab blad van de BrpProxy container of kunnen worden bekeken met behulp van Seq. Een Seq container instantie wordt ook opgestart wanneer het het [docker compose bestand]({{ site.devBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"} wordt gebruikt om de BrpProxy op te starten.
