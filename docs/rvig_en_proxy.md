---
layout: page-with-side-nav
title: RvIG API en Proxy API
---

# RvIG API en Proxy API

In de implementatie van de BRP-bevragen API door RvIG zullen niet alle gegevens die zijn gedefinieerd worden geleverd. Dit betreft afgeleide gegevens die om juridische redenen nog niet door RvIG geleverd mogen worden.

Er wordt daarom een proxy API ontwikkeld die tussen een client en de door RvIG geleverde API zal worden gepositioneerd en deze afgeleide gegevens zal toevoegen.

## Gegevens die niet geleverd worden

Het betreft de volgende gegevens die niet door de RvIG API geleverd zullen worden:
  - IngeschrevenPersoon:
    - naam.aanhef
    - naam.aanschrijfwijze
    - naam.regelVoorafgaandAanAanschrijfwijze
    - naam.gebruikInLopendeTekst
    - naam.voorletters
    - leeftijd
    - ouders.naam.voorletters
    - partners.naam.voorletters
    - kinderen.naam.voorletters
    - kinderen.leeftijd

## Proxy API
Er wordt een proxy API ontwikkeld die ter beschikking zal worden gesteld als Docker container. Deze draait u lokaal en zal door de API clients worden aangesproken.

De proxy API werkt in grote lijnen zo:
1. Een client stuurt een request naar de BRP-bevragen API van de proxy API.
2. De proxy API stuurt het request door naar de BRP-bevragen API bij RvIG.
3. De proxy voegt aan het antwoord van de BRP-bevragen API van RvIG de afgeleide gegevens toe op basis van de gegevens in dat antwoord.
4. De proxy retourneert het antwoord inclusief afgeleide gegevens aan de client.

