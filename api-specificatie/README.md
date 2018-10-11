# API specificaties bevragingen ingeschreven natuurlijk personen
Hier vind je de API specificaties in drie verschillende formaten:
* Open API Specificaties 3 [(yaml)](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0.yaml) en [swagger](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/master/api-specificatie/openapi.yaml#/ingeschrevennatuurlijkpersonen/ingeschrevennatuurlijkpersonen)
* [JSON schema Draft 5](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0.json)
* [JSON schema Draft 4 ](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0-2.0.json)


In deze versie zijn nu handmatig enkele wijzigingen in het .yaml bestand doorgevoerd die niet in de .json bestanden zijn doorgevoerd. 
Op hooflijnen zijn dit :
* De verwijzing naar “ouders” omzetten naar een array met maxItems=4. Ook op het niveau van de gerelateerde. – Nog een issue voor aanmaken
* Alle verwijzingen naar ouders, partners en kinderen voorzien van de oneOf met AnderNatuurlijkPersoon. Issue is bekend (met de Xor) nogmaals benadrukken.  – Bestaande Issue prioriteren
* Verwijderen van embedded elementen waar die niet aangemaakt hoeven te worden (bij verwijzing naar “lege” gerelateerde entiteittypen ) – Nog een issue voor aanmaken
* Verblijfstitelhistorie is geen array. Dus array van maken . – Known issue

