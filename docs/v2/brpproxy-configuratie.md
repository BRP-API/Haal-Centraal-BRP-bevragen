---
layout: page-with-side-nav
title: Configureren van de BrpProxy en/of de GBA variant mock
---

# BrpProxy configuratie

## Routering

Standaard is de BrpProxy geconfigureerd om bevragingen door te sturen naar de mock van de {{ site.apiname }} Web API GBA variant.

De __Downstream__ configuratie van de BrpProxy moet worden aangepast om bevragingen door te sturen naar een instantie van de {{ site.apiname }} Web API GBA variant.

### Wijzigen van de Downstream configuratie van de BrpProxy

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

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een Volume te monteren aan een docker instantie.

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
