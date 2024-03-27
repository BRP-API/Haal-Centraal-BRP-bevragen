const { createObjectFrom,
        createObjectArrayFrom,
        setObjectPropertiesFrom } = require('./dataTable2Object');
const { toCollectieNaam } = require('./brp');

function getExpected(context) {
    if(context.expected === undefined) {
        context.expected = {};
    }

    return context.expected;
}

function getCollectie(obj, naamColObj) {
    const naamCollectieVeld = toCollectieNaam(naamColObj);

    if(obj[naamCollectieVeld] === undefined) {
        obj[naamCollectieVeld] = [];
    }

    return obj[naamCollectieVeld];
}

function getLastCollectieObject(obj, naamColObj) {
    const naamCollectieVeld = toCollectieNaam(naamColObj);

    return obj[naamCollectieVeld].at(-1);
}

function getLastCollectieObjectFromExpected(context, naamColObj) {
    let expected = getExpected(context);

    return getLastCollectieObject(expected, naamColObj)
}

function createObject(context, dataTable = undefined) {
    return dataTable !== undefined
        ? createObjectFrom(dataTable, context.proxyAanroep)
        : {};
}

function createObjectMetObjectVeld(context, naamObjProp, dataTable = undefined) {
    let expectedObject = {};

    expectedObject[naamObjProp] = createObject(context, dataTable);

    return expectedObject;
}

function createCollectie(context, dataTable = undefined) {
    return dataTable !== undefined
        ? createObjectArrayFrom(dataTable, context.proxyAanroep)
        : [];
}

function createObjectMetCollectieVeld(context, naamColObj, dataTable = undefined) {
    let expectedObject = {};

    expectedObject[toCollectieNaam(naamColObj)] = createCollectie(context, dataTable);

    return expectedObject;
}

/**
 * Creeer aan de hand van de naam/waarde paren in de *dataTable* argument velden op het **expected** object van de *context* argument.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd en gevuld bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createVelden(context, dataTable) {
    let expected = getExpected(context);

    setObjectPropertiesFrom(expected, dataTable);
}

/**
 * Creeer een object met velden aan de hand van de naam/waarde paren in de *dataTable* argument in het *naamCollectieObject*en collectie veld op het 'expected' object van de *context* argument.
 * Het nieuw gecreeerde object toegevoegd aan het *naamCollectieObject*en collectie veld, wanneer deze al bestaat.
 * Een object zonder velden wordt toegevoegd aan het *naamCollectieObject*en collectie veld, wanneer de *dataTable* argument niet is opgegeven.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van naam van het (te creeeren) collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createCollectieObject(context, naamCollectieObject, dataTable = undefined) {
    let expected = getExpected(context);

    getCollectie(expected, naamCollectieObject).push(createObject(context, dataTable));
}

/**
 * Creeer voor elke rij van de *dataTable* argument een object met velden aan de hand van naam/waarde paren in het *naamCollectieObject*en collectie veld op het **expected** object van de *context* argument.
 * Het *naamCollectieObject*en collectie veld wordt overschreven, wanneer deze al bestaat.
 * Een leeg *naamCollectieObject*en veld wordt gecreeerd, wanneer de *dataTable* argument niet is opgegeven.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van de naam van het te creeeren collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd en gevuld bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createCollectieObjecten(context, naamCollectieObject, dataTable = undefined) {
    let expected = getExpected(context);

    expected[toCollectieNaam(naamCollectieObject)] = createCollectie(context, dataTable); 
}

/**
 * Creeer een object met velden aan de hand van de naam/waarde paren in de *dataTable* argument genaamd *naamObjectVeld* op een nieuw gecreeerd object in het *naamCollectieObject*en collectie veld op het 'expected' object van de *context* argument.
 * Het nieuw gecreeerde object toegevoegd aan het *naamCollectieObject*en collectie veld, wanneer deze al bestaat.
 * Een object zonder velden wordt gecreeerd voor het *naamObjectVeld* veld op het nieuw gecreeerde object, wanneer de dataTable argument niet is opgegeven.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van naam van het (te creeeren) collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} naamObjectVeld. De naam van het te creeeren object veld op het nieuw gecreeerde object in de *naamCollectieObject*en collectie 
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createCollectieObjectMetObjectVeld(context, naamCollectieObject, naamObjectVeld, dataTable = undefined) {
    let expected = getExpected(context);

    getCollectie(expected, naamCollectieObject).push(createObjectMetObjectVeld(context, naamObjectVeld, dataTable));
}

/**
 * Creeer een object met velden aan de hand van de naam/waarde paren in de *dataTable* argument genaamd *naamObjectVeld* op het laatste object in het *naamCollectieObject*en collectie veld op het 'expected' object van de *context* argument.
 * Een object zonder velden wordt gecreeerd voor het *naamObjectVeld* veld op het laatste object in de *naamCollectieObject*en collectie, wanneer de dataTable argument niet wordt opgegeven. 
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van naam van het (te creeeren) collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} naamObjectVeld. De naam van het te creeeren object veld op het laatste object in de *naamCollectieObject*en collectie 
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createObjectVeldInLastCollectieObject(context, naamCollectieObject, naamObjectVeld, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamCollectieObject)

    expectedObject[naamObjectVeld] = createObject(context, dataTable);
}

function createSubObjectVeldInObjectInLastCollectieObject(context, naamCollectieObject, naamObjectVeld, naamSubObjectVeld, dataTable = undefined) {
    let expected = getLastCollectieObjectFromExpected(context, naamCollectieObject)

    if(expected[naamObjectVeld] === undefined) {
        expected[naamObjectVeld] = {};
    }
    let expectedObject = expected[naamObjectVeld];

    expectedObject[naamSubObjectVeld] = createObject(context, dataTable);

}

/**
 * Creeer een object met velden aan de hand van de naam/waarde paren in de *dataTable* argument in het *naamSubCollectieObject*en collectie veld op een nieuw gecreeerd object in het *naamCollectieObject*en collectie veld op het **expected** object van de *context* argument.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van naam van het (te creeeren) collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} naamSubCollectieObject. De enkelvoudige vorm van de naam van het collectie veld op het nieuw gecreeerde object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand 
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createCollectieObjectMetSubCollectieObject(context, naamCollectieObject, naamSubCollectieObject, dataTable = undefined) {
    let expected = getExpected(context);

    let expectedObject = {};

    getCollectie(expected, naamCollectieObject).push(expectedObject);

    getCollectie(expectedObject, naamSubCollectieObject).push(createObject(context, dataTable));
}

/**
 * Creeer voor elke rij van de *dataTable* argument een object met velden aan de hand van naam/waarde paren in het *naamSubCollectieObject*en collectie veld op het nieuw gecreeerde object in het *naamCollectieObject*en collectie veld op het **expected** object van de *context* argument.
 * Een leeg *naamSubCollectieObject*en veld wordt gecreeerd, wanneer de *dataTable* argument niet is opgegeven.
 * @param {*} context. Het ouder object van het **expected** object. Het **expected** object wordt gecreeerd als deze nog niet bestaat 
 * @param {*} naamCollectieObject. De enkelvoudige vorm van de naam van het te creeeren collectie veld op het **expected** object. De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} naamSubCollectieObject. De enkelvoudige vorm van de naam van het te creeeren collectie veld op het gecreeerde *naamCollectieObject* object.  De meervoud vorm van de naam wordt bepaald aan de hand van de **collectionNameMap** map gedefinieerd in het brp.js bestand
 * @param {*} dataTable. Het DataTable object dat wordt gecreeerd bij het uitvoeren van een Gherkin Stap Definitie 
 */
function createCollectieObjectMetSubCollectieObjecten(context, naamCollectieObject, naamSubCollectieObject, dataTable = undefined) {
    let expected = getExpected(context);

    getCollectie(expected, naamCollectieObject).push(createObjectMetCollectieVeld(context, naamSubCollectieObject, dataTable));
}

/**
 * Creeer een object met velden aan de hand van de naam/waarde paren in de *dataTable* argument genaamd *naamObjectVeld* op een nieuw gecreeerd object in het *naamSubCollectieObject*en collectie veld op een nieuw gecreeerd object in het *naamCollectieObject*en collectie veld op het **expected** object van de *context* argument.
 * @param {*} context 
 * @param {*} naamCollectieObject 
 * @param {*} naamSubCollectieObject 
 * @param {*} naamObjectVeld 
 * @param {*} dataTable 
 */
function createCollectieObjectMetSubCollectieObjectMetObjectVeld(context, naamCollectieObject, naamSubCollectieObject, naamObjectVeld, dataTable = undefined) {
    let expected = getExpected(context);

    let expectedObject = {};

    getCollectie(expected, naamCollectieObject).push(expectedObject);

    getCollectie(expectedObject, naamSubCollectieObject).push(createObjectMetObjectVeld(context, naamObjectVeld, dataTable));
}

function createSubCollectieObjectInLastCollectieObject(context, naamCollectieObject, naamSubCollectieObject, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamCollectieObject);

    getCollectie(expectedObject, naamSubCollectieObject).push(createObject(context, dataTable));
}

function createSubCollectieObjectenInLastCollectieObject(context, naamColObj, naamSubColObj, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamColObj);

    expectedObject[toCollectieNaam(naamSubColObj)] = createCollectie(context, dataTable);
}

function createSubCollectieObjectMetObjectVeldInLastCollectieObject(context, naamCollectieObject, naamSubCollectieObject, naamObjectVeld, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamCollectieObject)

    getCollectie(expectedObject, naamSubCollectieObject).push(createObjectMetObjectVeld(context, naamObjectVeld, dataTable));
}

function createObjectVeldInLastSubCollectieObjectInLastCollectieObject(context, naamColObj, naamSubColObj, naamObjProp, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamColObj);
    let expectedSubObject = getLastCollectieObject(expectedObject, naamSubColObj);

    expectedSubObject[naamObjProp] = createObject(context, dataTable);
}

function createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject(context, naamColObj, naamSubColObj, naamSubSubColObj, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamColObj);
    let expectedSubObject = getLastCollectieObject(expectedObject, naamSubColObj);

    getCollectie(expectedSubObject, naamSubSubColObj).push(createObject(context, dataTable));
}

function createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject(context, naamColObj, naamSubColObj, naamSubSubColObj, dataTable = undefined) {
    let expectedObject = getLastCollectieObjectFromExpected(context, naamColObj);
    let expectedSubObject = getLastCollectieObject(expectedObject, naamSubColObj);

    expectedSubObject[toCollectieNaam(naamSubSubColObj)] = createCollectie(context, dataTable);
}

module.exports = {
    createVelden,
    createCollectieObject,
    createCollectieObjecten,
    createCollectieObjectMetObjectVeld,
    createObjectVeldInLastCollectieObject,
    createSubObjectVeldInObjectInLastCollectieObject,
    createCollectieObjectMetSubCollectieObject,
    createCollectieObjectMetSubCollectieObjecten,
    createCollectieObjectMetSubCollectieObjectMetObjectVeld,
    createSubCollectieObjectInLastCollectieObject,
    createSubCollectieObjectenInLastCollectieObject,
    createSubCollectieObjectMetObjectVeldInLastCollectieObject,
    createObjectVeldInLastSubCollectieObjectInLastCollectieObject,
    createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
    createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject
};
