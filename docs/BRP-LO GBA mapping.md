---
layout: page-with-side-nav
title: BRP-LO GBA mapping
---
# BRP-LO GBA mapping op Haal Centraal Personen Bevragen API

De transformatie van de met de Haal Centraal Personen Bevragen API op te halen gegevens naar het response bericht gebeurd in twee stappen.
Eerst wordt vanuit de BRP getransformeerd naar de GBA variant van de Haal Centraal Personen Bevragen API en dat wordt weer getransformeerd naar de proxy variant van de Haal Centraal Personen Bevragen API.

De eerste stap wordt beschreven in het CSV bestand '[BRP-LO GBA mapping - Personen gba.csv](BRP-LO GBA mapping - Personen proxy.csv)', de tweede stap in het CSV bestand '[BRP-LO GBA mapping - Personen proxy.csv](BRP-LO GBA mapping - Personen proxy.csv)'.

Enkele kolommen in beide bestanden verdienen een toelichting.

| Mapping | Kolomnaam | Toelichting |
| --- | --- | --- |
| Personen gba | leveren door RvIG | Beschrijft in welke vorm het BRP gegeven geleverd wordt. |
| Personen proxy | aanpassing door proxy | Beschrijft de aanpassing die de proxy applicatie aan het gegeven aanbrengt. |
| Personen proxy | afleiding of feature | Naam van het/de feauture bestand(en) waarin de logica achter de omzetting beschreven zijn. |
| Personen proxy | Buitengemeentelijke autorisatie | Indien gemarkeerd dan mogen gemeenten het gegeven ook voor niet-ingezetenen ontvangen. |
| Personen gba</br>Personen proxy | Beperkt zoekresultaat | G = is aanwezig in GbaPersoonBeperkt, P = is aanwezig in PersoonBeperkt |
