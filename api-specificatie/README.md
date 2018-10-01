# API specificaties bevragingen ingeschreven natuurlijk personen
Hier vind je de API specificaties in drie verschillende formaten:
* Open API Specificaties 3 [(yaml)](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0.yaml) en [swagger](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/master/api-specificatie/BRPB1.0.yaml#/ingeschrevennatuurlijkpersonen/ingeschrevennatuurlijkpersonen)
* [JSON schema Draft 5](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0.json)
* [JSON schema Draft 4 ](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/blob/master/api-specificatie/BRPB1.0-2.0.json)


In deze versie zijn nu handmatig enkele wijzigingen in het .yaml bestand doorgevoerd die niet in de .json bestanden zijn doorgevoerd. 
Op hooflijnen zijn dit :
* Het toevoegen van een oneOf constructie in de embedded van ingeschreven personen voor kinderen, ouders en partners.
* Het verwijderen van een 6-tal schema-componenten waarnaar niet verwezen wordt. 
