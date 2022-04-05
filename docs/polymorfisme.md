# Toepassen van polymorfisme binnen de BRP Bevraging API

In de Haal Centraal BRP API wordt data types die worden gebruikt om meerdere gelijksoortige data te representeren. Voorbeelden van dit soort data types zijn de Verblijfplaats en DatumOnvolledig type. Vanweze zijn simpele aard wordt de DatumOnvolledig type gebruikt om de issues en de gekozen oplossing te illustreren.

De DatumOnvolledig type wordt gebruikt om vier soorten datums te representeren:
- 'volledige' datum. Jaar, maand en dag zijn bekend
- 'jaar maand' datum. Jaar en maand zijn bekend, dag is onbekend
- 'jaar' datum. Jaar is bekend, maand en dag zijn onbekend
- 'volledig onbekende' datum. Jaar, maand en dag zijn onbekend

De DatumOnvolledig type is met behulp van de OpenApi Specificatie als volgt gedefinieerd:

```yaml
DatumOnvolledig:
  type: object
  properties:
    datum:
      type: string
      format: date
    jaar:
      type: integer
      maximum: 9999
    maand:
      type: integer
      minimum: 1
      maximum: 12
    dag:
      type: integer
      minimum: 1
      maximum: 31
```

Deze definitie kent een aantal nadelen:
- Alle velden zijn gedefinieerd als optioneel velden om de vier soorten datums te kunnen representeren. Hierdoor representeert deze definitie echter ook datums die niet in de BRP voorkomen, zoals een datum waarvan jaar en dag bekend zijn en maand onbekend of een datum waarvan alleen de dag of maand bekend zijn.
- De definitie kan niet worden gebruikt om een datum waarde te valideren. De volgende datum representatie is geen geldige datum waarde, maar is volgens de DatumOnvolledig definitie wel valide:
  ```json
  {
    "jaar": 2022,
    "maand": 2,
    "dag": 31
  }
  ```
- Uit alleen de definitie is niet af te leiden of bij een 'volledige' datum alleen het datum veld is gevuld, of ook de velden jaar, maand en dag. Er is extra documentatie nodig
- De logica om de datum soort te bepalen is complex. De velden jaar, maand en dag moeten worden gecontroleerd om te kunnen bepalen om welke soort datum het gaat:
  ```javascript
  // datum veld heeft een waarde óf jaar, maand en dag velden hebben een waarde
  if(datum !== undefined || (jaar !== undefined && maand !== undefined && dag !== undefined)} {
      console.log("datum");
  }
  // jaar en maand velden hebben een waarde en datum en dag velden hebben geen waarde
  else if(datum == undefined && jaar !== undefined && maand !== undefined && dag === undefined) {
      console.log("dag onbekend");
  }
  // jaar veld heeft een waarde en maand, dag en datum velden hebben geen waarde
  else if(datum == undefined && jaar !== undefined && maand === undefined && dag == undefined) {
      console.log("maand en dag onbekend");
  }
  // datum, jaar, maand en dag velden hebben geen waarde
  else if(jaar === undefined && maand === undefined && dag == undefined) {
      console.log("onbekend datum");
  }
  // alle andere veld combinaties worden niet ondersteund
  else {
      console.log("niet ondersteund datum");
  }
  ```

De logica voor het bepalen van de datum type kan worden versimpeld, door een extra veld op te nemen in de DatumOnvolledig definitie om de datum type aan te geven. De DatumOnvolledig definitie ziet er dan als volgt uit:

```yaml
DatumOnvolledig:
  type: object
  properties:
    datum:
      type: string
      format: date
    jaar:
      type: integer
      maximum: 9999
    maand:
      type: integer
      minimum: 1
      maximum: 12
    dag:
      type: integer
      minimum: 1
      maximum: 31
    type:
      type: string
      enum:
        - Datum
        - JaarMaandDatum
        - JaarDatum
        - OnbekendDatum
  required:
    - type
```

Het 'type' veld is gedefinieerd als een enumeratie om aan te kunnen geven wat de mogelijke waarden zijn. Ook is dit veld verplicht gemaakt om aan te geven dat dit veld altijd een waarde heeft.

De logica voor het bepalen van de datum type kan dan als volgt worden herschreven:

```javascript
if(type === 'Datum') {
    console.log("datum");
}
else if(type === 'JaarMaandDatum') {
    console.log("dag onbekend");
}
else if(type === 'JaarDatum') {
    console.log("maand en dag onbekend");
}
else if(type === 'OnbekendDatum') {
    console.log("onbekend datum");
}
else {
    console.log("niet ondersteund datum");
}
```

Wat deze DatumOnvolledig definitie niet oplost, is dat het mogelijk is om een type aan te geven en niet alle bijhorende velden een waarde te geven.  

Een manier om dit op te lossen is om voor elke datum type een eigen definitie te maken zodat expliciet kan worden aangegeven welke velden bij elk datum type horen. De vier datum types zien er dan als volgt uit:

```yaml
VolledigeDatum:
  type: object
  properties:
    datum:
      type: string
      format: date
    type:
      type: string
      enum:
        - Datum
  required:
    - datum
    - type
JaarMaandDatum:
  type: object
  properties:
    jaar:
      type: integer
      maximum: 9999
    maand:
      type: integer
      minimum: 1
      maximum: 12
    type:
      type: string
      enum:
        - JaarMaandDatum
  required:
    - jaar
    - maand
    - type
JaarDatum:
  type: object
  properties:
    jaar:
      type: integer
      maximum: 9999
    type:
      type: string
      enum:
        - JaarDatum
  required:
    - jaar
    - type
OnbekendDatum:
  type: object
  properties:
    type:
      type: string
      enum:
        - OnbekendDatum
  required:
    - type
```

Met deze vier datum definities is nu expliciet gedefinieerd welke datum type welke velden heeft en wat de bijbehorende waarde is in het 'type' veld. 

Om de datum types te kunnen gebruiken als de mogelijke types van een datum veld moet [polymorfisme](https://nl.wikipedia.org/wiki/Polymorfisme) worden toegepast. In een OpenAPI Specificatie wordt [polymorfisme](https://spec.openapis.org/oas/v3.0.3#composition-and-inheritance-polymorphism) toegepast met behulp van de **allOf** en **discriminator** elementen:
- er moet een basis type worden gedefinieerd voor de vier datum types. Deze basis type kan dan worden gebruikt als type voor een datum veld. De vier datum types gebruiken de **allOf** element om de basis type te overerven
- de **discriminator** element moet worden gebruikt om aan te geven welk veld moet worden gebruikt om de type van het datum veld te bepalen. De **discriminator** en de bijbehorende type worden in de basis type gedefinieerd zodat ze door alle vier datum types worden overgeërfd.

Na het toepassen van polymorfisme zien de datum types er als volgt uit:

```yaml
AbstractDatum:
  type: object
  properties:
    type: string
  required:
    - type
  discriminator:
    propertyName: type
  mapping:
    Datum: '#/components/schemas/VolledigeDatum'
    OnbekendDatum: '#/components/schemas/OnbekendDatum'
    JaarDatum: '#/components/schemas/JaarDatum'
    JaarMaandDatum: '#/components/schemas/JaarMaandDatum'
VolledigeDatum:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
      properties:
        datum:
          type: string
          format: date
  required:
    - datum
JaarMaandDatum:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
      properties:
        jaar:
          type: integer
          maximum: 9999
        maand:
          type: integer
          minimum: 1
          maximum: 12
  required:
    - jaar
    - maand
JaarDatum:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
      properties:
        jaar:
          type: integer
          maximum: 9999
  required:
    - jaar
OnbekendDatum:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
      properties:
        indicatieOnbekend:
          type: bool
  required:
    - indicatieOnbekend
```

In de nieuwe datum definities zijn de type enum waarden verwijderd. Deze zijn niet meer nodig omdat standaard de naam van de afgeleide schemas (in dit geval: VolledigeDatum,JaarMaandDatum,JaarDatum,OnbekendDatum) als enum waarde wordt gebruikt. Van deze standaard 'mapping' kan worden afgeweken door gebruik te maken van de **mapping** element van de discriminator. In bovenstaande definities is gebruik gemaakt van de **mapping** element omdat 'Datum' als type waarde is gekozen voor een VolledigeDatum type.

Het toepassen van polymorfisme is niet zonder consequenties. De belangrijkste nadelen voor het toepassen van polymorfisme zijn:
- de definitie wordt complexer. In plaats van één datum type zijn er nu vijf datum types. Voor een datum type met slechts vier velden kan worden afgevraagd of het handig is of het toepassen van polymorfisme handig is. Voor de Verblijfplaats type is het wel handig omdat elk Verblijfplaats type meerdere velden heeft die niet bij een andere Verblijfplaats type voorkomt. Ook is de logica om te bepalen om welk Verblijfplaats type het gaat veel complexer.
- Ondersteuning van polymorfisme door tooling is (nog) beperkt. Zo ondersteunt Swagger UI en Swagger code generator geen polymorfisme. Als deze tooling wordt gebruikt, moet er worden gezocht naar alternatieven.

Belangrijk is om de nadelen af te wegen tegen de voordelen:
- Logica die met polymorfe data types werken zijn voor zowel consumer als provider veel simpeler. Ook voor consumers die geen code generatie gebruiken
- Het is makkelijker om polymorfe data types te evolueren. Er kunnen nieuwe afgeleide data types worden toegevoegd en bestaande afgeleide data types kunnen worden uitgebreid, zonder dat het een impact heeft op de andere afgeleide data types.
