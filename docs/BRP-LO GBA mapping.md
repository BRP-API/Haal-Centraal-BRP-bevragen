---
layout: page-with-side-nav
title: BRP-LO GBA mapping
---
# BRP-LO GBA mapping op Haal Centraal Personen Bevragen API

De transformatie van de met de Haal Centraal Personen Bevragen API op te halen gegevens naar het response bericht gebeurt in twee stappen.
Eerst wordt vanuit de BRP getransformeerd naar de GBA variant van de Haal Centraal Personen Bevragen API en dat wordt weer getransformeerd naar de proxy variant van de Haal Centraal Personen Bevragen API.

De eerste stap wordt beschreven in het CSV bestand [BRP-LO GBA mapping - Personen gba.csv](BRP-LO%20GBA%20mapping%20-%20Personen%20gba.csv).
De tweede stap in het CSV bestand [BRP-LO GBA mapping - Personen proxy.csv](BRP-LO%20GBA%20mapping%20-%20Personen%20proxy.csv).

Enkele kolommen in beide bestanden verdienen een toelichting.

| Mapping | Kolomnaam | Toelichting |
| --- | --- | --- |
| Personen gba</br>Personen proxy | categorie, element | Nummer van het corresponderende gegeven zoals beschreven in LO BRP. |
| Personen gba | leveringsvorm | Indien van toepassing de (t.o.v. definitie in LO BRP) aangepaste vorm waarin het gegeven wordt geleverd. |
| Personen proxy | aanpassing door proxy | Beschrijft de aanpassing die de proxy applicatie aan het gegeven aanbrengt. |
| Personen proxy | afleiding of feature | Naam van het/de feauture bestand(en) waarin de logica achter de omzetting beschreven is. |
| Personen gba</br>Personen proxy | Buitengemeentelijke autorisatie | Geeft aan of gemeenten het gegeven ook voor niet-ingezetenen mogen ontvangen. |
| Personen gba</br>Personen proxy | Beperkt zoekresultaat | Geeft aan of het gegeven ook kan worden geleverd als antwoord op een zoekvraag. |
