# Toepassen van polymorfisme binnen de BRP Bevraging API

In de 1.x versie van de Haal Centraal BRP API worden data types gebruikt om meerdere gelijksoortige data te representeren. Voorbeelden van dit soort data types zijn de Verblijfplaats type en DatumOnvolledig type. Vanwege zijn simpele aard is het DatumOnvolledig type gebruikt om de issues en de gekozen oplossing te illustreren.

Het DatumOnvolledig type wordt gebruikt om vier soorten datums te representeren:
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
- Alle velden zijn gedefinieerd als optionele velden om de vier soorten datums te kunnen representeren. Hierdoor representeert deze definitie echter ook datums die niet in de BRP voorkomen, zoals een datum waarvan jaar en dag bekend zijn en maand onbekend of een datum waarvan alleen de dag of maand bekend zijn.
- De definitie kan niet worden gebruikt om een datum waarde te valideren. De volgende datum representatie is geen geldige datum waarde, maar is volgens de DatumOnvolledig definitie wel valide:
  ```json
  {
    "jaar": 2022,
    "maand": 2,
    "dag": 31
  }
  ```
- Uit alleen de definitie is niet af te leiden of bij een 'volledige' datum alleen het datum veld is gevuld, of ook de velden jaar, maand en dag. Er is extra documentatie nodig.
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

De logica voor het bepalen van het datum type kan worden versimpeld, door een extra veld op te nemen in de DatumOnvolledig definitie om het datum type aan te geven. De DatumOnvolledig definitie ziet er dan als volgt uit:

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
        - DatumOnbekend
  required:
    - type
```

Het 'type' veld is gedefinieerd als een enumeratie om aan te geven wat de mogelijke waarden zijn. Ook is dit veld verplicht gemaakt om aan te geven dat dit veld altijd een waarde heeft.

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
else if(type === 'DatumOnbekend') {
    console.log("datum onbekend");
}
else {
    console.log("datum niet ondersteund");
}
```

Wat deze DatumOnvolledig definitie niet oplost, is dat het mogelijk is om een type aan te geven en niet alle bijhorende velden een waarde te geven.  

Een manier om dit op te lossen is om voor elk datum type een eigen definitie te maken zodat expliciet kan worden aangegeven welke velden bij elk datum type horen. De vier datum types zien er dan als volgt uit:

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
DatumOnbekend:
  type: object
  properties:
    type:
      type: string
      enum:
        - DatumOnbekend
  required:
    - type
```

Met deze vier datum definities is nu expliciet gedefinieerd welk datum type welke velden heeft en wat de bijbehorende waarde is in het 'type' veld.

Om de datum types te kunnen gebruiken als de mogelijke types van een datum veld moet [polymorfisme](https://nl.wikipedia.org/wiki/Polymorfisme) worden toegepast. In een OpenAPI Specificatie wordt [polymorfisme](https://spec.openapis.org/oas/v3.0.3#composition-and-inheritance-polymorphism) toegepast met behulp van de **allOf** en **discriminator** elementen:
- er moet een basis type worden gedefinieerd voor de vier datum types. Deze basis type (AbstractDatum) kan dan worden gebruikt als type voor een datum veld. De vier datum types gebruiken de **allOf** element om de basis type te overerven.
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
    DatumOnbekend: '#/components/schemas/DatumOnbekend'
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
DatumOnbekend:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
      properties:
        indicatieOnbekend:
          type: bool
  required:
    - indicatieOnbekend
```

In de nieuwe datum definities zijn de type enum waarden verwijderd. Deze zijn niet meer nodig omdat standaard de naam van de afgeleide schemas (in dit geval: VolledigeDatum,JaarMaandDatum,JaarDatum,DatumOnbekend) als enum waarde wordt gebruikt. Van deze standaard 'mapping' kan worden afgeweken door gebruik te maken van het **mapping** element van de discriminator. In bovenstaande definities is gebruik gemaakt van het **mapping** element omdat 'Datum' als type waarde is gekozen voor een VolledigeDatum type.

Het toepassen van polymorfisme in de OpenAPI specificatie van de BRP API leidt tot een duidelijker API contract definitie. Er kan op een eenduidige manier worden afgeleid welke data types er aan een veld kan worden toegekend, wat de velden zijn voor elk data type, welke van de velden verplicht zijn en welke optioneel. Hierdoor kan tooling worden gebruikt om de request en response van de API te valideren, zodat er geen onjuiste data bij de consumers en bij de provider terecht kan komen.

Ook wordt de logica, die nodig is om te bepalen om welk data type het gaat, simpeler. Alleen het **discriminator** veld is nodig om de data type te kunnen bepalen. Wanneer een code generator wordt gebruikt die polymorfisme ondersteunt, dan kan deze logica door de code generator worden gegenereerd en door de code generator aan het serialisatie/deserialisatie proces worden toegevoegd. Dit houdt de business logica vrij van de nodige 'plumbling' code.

Waar wel rekening mee gehouden moet worden is dat niet alle OpenAPI tooling polymorfisme ondersteunt/zal ondersteunen. Zo kan Swagger UI een OpenAPI specificatie waarin polymorfisme is toegepast (nog) niet goed tonen. Ook de Swagger code generator en Postman ondersteunen polymorfisme (nog) niet. Er moet dan worden gekeken naar alternatieven, zoals [ReDoc](https://redocly.github.io/redoc/), [OpenAPI Generator](https://openapi-generator.tech/) en [NSwag](https://github.com/RicoSuter/NSwag).

Verder brengt het toepassen van polymorfisme een zekere mate van complexiteit met zich mee. Voor een simpele type als de datum type met slechts vier velden kun je je afvragen of het noodzakelijk is om vijf datum types te introduceren in plaats van één datum type. Voor de Verblijfplaats type biedt het zeker meerwaarde omdat elk Verblijfplaats type meerdere velden heeft die niet bij een andere Verblijfplaats type voorkomt. Ook is de logica om te bepalen om welk Verblijfplaats type het gaat veel complexer.

Echter, een bijkomend maar misschien wel het belangrijkste voordeel is dat polymorfisme het mogelijk maakt om een API zonder breaking changes te evolueren. Om de nieuwe data types backward compatible te maken moet de 'oude' data type ook afleiden van de basis type. In het geval van de datum types moet de DatumOnvolledig type ook afleiden van AbstractDatum:

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
    DatumOnbekend: '#/components/schemas/DatumOnbekend'
    JaarDatum: '#/components/schemas/JaarDatum'
    JaarMaandDatum: '#/components/schemas/JaarMaandDatum'
    OnvolledigDatum: '#/components/schemas/DatumOnvolledig'
DatumOnvolledig:
  allOf:
    - $ref: '#/components/schemas/AbstractDatum'
    - type: object
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

Vervolgens kan met een header, bijvoorbeeld de version header worden aangegeven of de 'oude' of de nieuwe data types moet worden geretourneerd.

Uit de definitie hierboven is te zien er geen breaking changes nodig zijn om een bestaande data type polymorfisch te maken. Hierdoor hoeft er in de design van een API beperkt rekening (polyformisme kan alleen worden toegepast bij 'object' data type) worden gehouden met het mogelijk toepassen van polymorfisme in de toekomst.
