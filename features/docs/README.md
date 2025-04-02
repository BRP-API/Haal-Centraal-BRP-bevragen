## Cucumber profielen

De volgende Cucumber profielen zijn toegevoegd om het uitvoeren van de features voor de Personen Informatie Service, Personen Data Service en Gezag API te vereenvoudigen. De profielen zijn te vinden in het cucumber.js bestand

- InfoApi
- InfoApiDeprecated
- DataApi
- DataApiDeprecated
- GezagApi
- GezagApiDeprecated

De GezagApi profiel is als volgt gedefinieerd:

```
  GezagApi: {
    worldParameters: {
      apiUrl: 'http://localhost:8080/api/v1/opvragenBevoegdheidTotGezag',
      api: 'gezag-api',
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @skip-verify and not @deprecated and ((not @data-api and not @info-api) or @gezag-api)'
  }
```

| parameter                   | omschrijving |
| --------------------------- | ------------ |
| apiUrl                      | endpoint van de API |
| api                         | context waarin de scenarios moet worden uitgevoerd. Deze wordt in de automation gebruikt bij het opbouwen van de verwachte Gezag response voor de info/data/gezag api|
| logger.level                | kan worden gezet op 'info' om te kunnen zien welke sql statements zijn uitgevoerd |
| addAcceptGezagVersionHeader | hiermee wordt aangegeven of de accept-gezag-version header moet worden meegestuurd met een request |
| tags                        | geeft aan welke scenarios moet worden uitgevoerd. Bij het aanroepen van Cucumber met de GezagApi profiel worden alle scenarios uitgevoerd die zijn getagd met @gezag-api, óf die niet zijn getagd met @info-api, @data-api én @gezag-api |

Het uitvoeren van documentatie features met de GezagApi profiel ziet er als volgt uit:

```
npx cucumber-js features/docs -p GezagApi
```

## Taggen van functionaliteit/regels/scenarios

Een tag is een woord met de '@' teken als prefix. Voor personen/gezag scenarios worden de volgende tags gebruikt:
- @info-api
- @data-api
- @gezag-api
- @deprecated

Een scenario die alleen voor een api geldt moet alleen met de betreffende @[xxx]-api worden getagd. Bijv. een scenario specifiek voor de Gezag API moet worden getagd met de @gezag-api tag.
Een scenario die voor alle drie APIs (informatie/data/gezag API) geldt, moet worden getagd met alle drie @[xxx]-api tags óf moet niet worden getagd met geen van de drie @[xxx]-tags. De laatste optie wordt geprefereerd.

Een scenario kan ook worden getagd met de @deprecated tag. Deze tag moet worden gebruikt om aan te geven dat een scenario een functionaliteit beschrijft/valideert die in de toekomst wordt verwijderd. Voor de Gezag API worden deze tas gebruikt bij bsn-loze ouder scenarios. Een scenario dat beschrijft dat het gezag niet kan worden bepaald bij een bsn-loze ouder, maar die in de volgende Gezag API versie wel kan worden bepaald, moet worden getagd met de @deprecated tag. Zie de 'ouder-zonder-bsn.feature'
