const { When } = require('@cucumber/cucumber');
const fs = require('node:fs');
const { promisify } = require('node:util');
const writeFile = promisify(fs.writeFile);
const { executeSqlStatements } = require('./postgresqlHelpers');
const { execute } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { objectToDataTable, mapDataTableToEntiteit } = require('./dataTableFactory');
const { getAdres,
        getPersoon,
        getBsn,
        getGeslachtsnaam,
        getGeboortedatum } = require('./contextHelpers');

function getPersoonBsn(context, aanduiding) {
    return getBsn(getPersoon(context, aanduiding));
}

function getPersoonGeslachtsnaam(context, aanduiding) {
    return getGeslachtsnaam(getPersoon(context, aanduiding));
}

function getPersoonGeboortedatum(context, aanduiding) {
    return getGeboortedatum(getPersoon(context, aanduiding)).replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
}

function getAdresseerbaarObjectIdentificatie(context, aanduiding) {
    return getAdres(context, aanduiding).adres.verblijf_plaats_ident_code;
}

function getNummeraanduidingIdentificatie(context, aanduiding) {
    return getAdres(context, aanduiding).adres.nummer_aand_ident_code;
}

function getPostcode(context, aanduiding) {
    return getAdres(context, aanduiding).adres.postcode;
}

function getHuisnummer(context, aanduiding) {
    return getAdres(context, aanduiding).adres.huis_nr;
}

function getStraatnaam(context, aanduiding) {
    return getAdres(context, aanduiding).adres.straat_naam;
}

function getGemeentecode(context, aanduiding) {
    return getAdres(context, aanduiding).adres.gemeente_code.padStart(4, '0');
}

const { addDefaultAutorisatieSettings,
        handleRequest } = require('./requestHelpers');

function initializeAfnemerIdAndGemeenteCode(context) {
    if(context.afnemerID === undefined) {
        context.afnemerID = context.oAuth.clients[0].afnemerID;
        context.gemeenteCode = context.oAuth.clients[0].gemeenteCode;
    }
}

function mapEndpointToRelativeUrl(context, endpoint) {
    return context.apiEndpointPrefixMap.has(endpoint)
        ? `${context.apiEndpointPrefixMap.get(endpoint)}/${endpoint}`
        : '';
}

function copyPrimaryKeyValues(context, sqlStatements) {
    for(const autorisatie of sqlStatements.autorisaties) {
        let input = context.data.autorisaties.find(a => a.id === autorisatie.stap);
        if(input) {
            input.autorisatieId = autorisatie.autorisatieId;
        }
    }
    for(const adres of sqlStatements.adressen) {
        let input = context.data.adressen.find(a => a.id === adres.stap);
        if(input) {
            input.adresId = adres.adresId;
        }
    }
    for(const persoon of sqlStatements.personen) {
        let input = context.data.personen.find(p => p.id === persoon.stap);
        if(input) {
            input.plId = persoon.plId;
        }
    }
}

async function execSqlStatements(context) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    if(context.data) {
        const sqlStatements = generateSqlStatementsFrom(context.data);
        global.logger.info('uit te voeren sql statements', sqlStatements);

        if(!context.isStapDocumentatieScenario) {
            await execute(sqlStatements);

            copyPrimaryKeyValues(context, sqlStatements);
        }
    }
    else if(!context.isStapDocumentatieScenario) {
        await executeSqlStatements(context.sql, context.sqlData, global.pool);
    }
}

function createDataTableForRaadpleegMetBurgerservicenummer(burgerservicenummer, fields, parametersDataTable) {
    let requestBody = {
        type: 'RaadpleegMetBurgerservicenummer',
        fields: fields
    };

    if(burgerservicenummer) {
        requestBody.burgerservicenummer = burgerservicenummer;
    }

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetAdresseerbaarObjectIdentificatie(adresseerbaarObjectIdentificatie, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetAdresseerbaarObjectIdentificatie',
        fields: fields
    };

    requestBody.adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie || '0000000000000001';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(geslachtsnaam, geboortedatum, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetGeslachtsnaamEnGeboortedatum',
        fields: fields
    };

    requestBody.geslachtsnaam = geslachtsnaam || 'doe';
    requestBody.geboortedatum = geboortedatum || '2000-01-01';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetGeslachtsnaamVoornamenEnGemeenteVanInschrijving(geslachtsnaam, voornamen, gemeenteVanInschrijving, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetNaamEnGemeenteVanInschrijving',
        fields: fields
    };

    requestBody.geslachtsnaam = geslachtsnaam || 'doe';
    requestBody.voornamen = voornamen || 'john';
    requestBody.gemeenteVanInschrijving = gemeenteVanInschrijving || '0000';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetNummeraanduidingIdentificatie(nummeraanduidingIdentificatie, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetNummeraanduidingIdentificatie',
        fields: fields
    };

    requestBody.nummeraanduidingIdentificatie = nummeraanduidingIdentificatie || '0000000000000001';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetPostcodeEnHuisnummer(postcode, huisnummer, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetPostcodeEnHuisnummer',
        fields: fields
    };

    requestBody.postcode = postcode || '1000 AA';
    requestBody.huisnummer = huisnummer || '1';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(straat, huisnummer, gemeenteVanInschrijving, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetStraatHuisnummerEnGemeenteVanInschrijving',
        fields: fields
    };

    requestBody.straat = straat || 'straat';
    requestBody.huisnummer = huisnummer || '1';
    requestBody.gemeenteVanInschrijving = gemeenteVanInschrijving || '0000';

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForRequest(parameterNames, fields) {
    switch(parameterNames) {
        case 'burgerservicenummer':
            return createDataTableForRaadpleegMetBurgerservicenummer('000000001', fields, undefined);
        case 'adresseerbaar object identificatie':
            return createDataTableForZoekMetAdresseerbaarObjectIdentificatie(undefined, fields, undefined);
        case 'geslachtsnaam en geboortedatum':
            return createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(undefined, undefined, fields, undefined);
        case 'geslachtsnaam, voornamen en gemeente van inschrijving':
            return createDataTableForZoekMetGeslachtsnaamVoornamenEnGemeenteVanInschrijving(undefined, undefined, undefined, fields, undefined);
        case 'nummeraanduiding identificatie':
            return createDataTableForZoekMetNummeraanduidingIdentificatie(undefined, fields, undefined);
        case 'postcode en huisnummer':
            return createDataTableForZoekMetPostcodeEnHuisnummer(undefined, undefined, fields, undefined);
        case 'straatnaam, huisnummer en gemeente van inschrijving':
            return createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(undefined, undefined, undefined, fields, undefined);
        default:
            return undefined;
    }
}

async function handleRequestWithParameters(context, endpoint, parametersDataTable) {
    initializeAfnemerIdAndGemeenteCode(context);

    const writePromises = [];

    if(context.gezag !== undefined) {
        writePromises.push(writeFile(context.gezagDataPath, JSON.stringify(context.gezag, null, '\t')));
    }
    if(context.downstreamApiResponseHeaders !== undefined) {
        writePromises.push(writeFile(context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(context.downstreamApiResponseHeaders[0], null, '\t')));
    }
    if(context.downstreamApiResponseBody !== undefined) {
        writePromises.push(writeFile(context.downstreamApiDataPath + '/response-body.json',
                         context.downstreamApiResponseBody));
    }
    if(writePromises.length > 0) {
        // wait for all files to be written before the request is made
        await Promise.all(writePromises);
    }

    addDefaultAutorisatieSettings(context, context.afnemerID);

    await execSqlStatements(context);

    await handleRequest(context,
                        mapEndpointToRelativeUrl(context, endpoint),
                        parametersDataTable);
}

When(/^([a-zA-Z-]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    global.logger.info(`als ${endpoint} wordt gezocht met de volgende parameters`);

    await handleRequestWithParameters(this.context, endpoint, dataTable);
});

When(/^([a-zA-Z-]*) wordt gezocht met een '(\w*)' aanroep$/, async function (endpoint, httpMethod) {
    initializeAfnemerIdAndGemeenteCode(this.context);

    const relativeUrl = mapEndpointToRelativeUrl(this.context, endpoint);

    await handleRequest(this.context, relativeUrl, undefined, httpMethod);
});

function setFieldsHasBurgerservicenummer(context, fields) {
    context.fieldsHasBurgerservicenummer = fields.split(',').includes('burgerservicenummer');
}

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd van personen gezocht met ([a-zA-Z, ]*)$/, async function (fields, parameterNames) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
                                      'personen',
                                      createDataTableForRequest(parameterNames, fields));
});

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd van personen gezocht met burgerservicenummer(?:s)? '([0-9, ]*)'$/, async function (fields, burgerserservicenummers) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForRaadpleegMetBurgerservicenummer(burgerserservicenummers, fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met burgerservicenummer (van ){aanduidingen} en parameters', async function (fields, persoonAanduidingen, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    const burgerservicenummers = persoonAanduidingen.map(aanduiding => /^\d{9}$/.test(aanduiding) ? aanduiding : getPersoonBsn(this.context, aanduiding)).join(',');

    await handleRequestWithParameters(this.context,
                                     'personen',
                                     createDataTableForRaadpleegMetBurgerservicenummer(burgerservicenummers, fields, dataTable));
});

When('{string} wordt gevraagd (van personen gezocht met burgerservicenummer )van {aanduidingen}', async function (fields, persoonAanduidingen) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    const burgerservicenummers = persoonAanduidingen.map(aanduiding => getPersoonBsn(this.context, aanduiding)).join(',');

    if(this.context.isGezagApiAanroep) {
        let requestBody = {
            burgerservicenummer: burgerservicenummers,
        };
    
        await handleRequestWithParameters(this.context,
            'gezag',
            objectToDataTable(requestBody));
    }
    else {
        await handleRequestWithParameters(this.context,
            'personen',
            createDataTableForRaadpleegMetBurgerservicenummer(burgerservicenummers, fields, undefined));
    }
});

When('{string} wordt gevraagd van personen gezocht met adresseerbaar object identificatie van {aanduiding}', async function (fields, adresAanduiding) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetAdresseerbaarObjectIdentificatie(getAdresseerbaarObjectIdentificatie(this.context, adresAanduiding), fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met adresseerbaar object identificatie van {aanduiding} en parameters', async function (fields, adresAanduiding, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetAdresseerbaarObjectIdentificatie(getAdresseerbaarObjectIdentificatie(this.context, adresAanduiding), fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met geslachtsnaam {string} en geboortedatum {string}', async function (fields, geslachtsnaam, geboortedatum) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(geslachtsnaam, geboortedatum, fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met geslachtsnaam {string} en geboortedatum {string} en parameters', async function (fields, geslachtsnaam, geboortedatum, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(geslachtsnaam, geboortedatum, fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met geslachtsnaam en geboortedatum van {aanduiding} en parameters', async function (fields, persoonAanduiding, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(
            getPersoonGeslachtsnaam(this.context, persoonAanduiding),
            getPersoonGeboortedatum(this.context, persoonAanduiding),
            fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met geslachtsnaam {string}, voornamen {string} en gemeente van inschrijving {string}', async function (fields, geslachtsnaam, voornamen, gemeenteVanInschrijving) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetGeslachtsnaamVoornamenEnGemeenteVanInschrijving(geslachtsnaam, voornamen, gemeenteVanInschrijving, fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met geslachtsnaam {string}, voornamen {string} en gemeente van inschrijving {string} en parameters', async function (fields, geslachtsnaam, voornamen, gemeenteVanInschrijving, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetGeslachtsnaamVoornamenEnGemeenteVanInschrijving(geslachtsnaam, voornamen, gemeenteVanInschrijving, fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met nummeraanduiding identificatie van {aanduiding}', async function (fields, adresAanduiding) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetNummeraanduidingIdentificatie(getNummeraanduidingIdentificatie(this.context, adresAanduiding), fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met nummeraanduiding identificatie van {aanduiding} en parameters', async function (fields, adresAanduiding, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetNummeraanduidingIdentificatie(getNummeraanduidingIdentificatie(this.context, adresAanduiding), fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met postcode en huisnummer van {aanduiding}', async function (fields, adresAanduiding) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetPostcodeEnHuisnummer(
            getPostcode(this.context, adresAanduiding),
            getHuisnummer(this.context, adresAanduiding),
            fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met postcode {string} en huisnummer {string}', async function (fields, postcode, huisnummer) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetPostcodeEnHuisnummer(postcode, huisnummer, fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met postcode en huisnummer van {aanduiding} en parameters', async function (fields, adresAanduiding, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetPostcodeEnHuisnummer(
            getPostcode(this.context, adresAanduiding),
            getHuisnummer(this.context, adresAanduiding),
            fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met postcode {string} en huisnummer {string} en parameters', async function (fields, postcode, huisnummer, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetPostcodeEnHuisnummer(postcode, huisnummer, fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met straatnaam, huisnummer en gemeentecode van {aanduiding}', async function (fields, adresAanduiding) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(
            getStraatnaam(this.context, adresAanduiding), getHuisnummer(this.context, adresAanduiding), getGemeentecode(this.context, adresAanduiding),
            fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met straatnaam {string}, huisnummer {string} en gemeentecode {string}', async function (fields, straatnaam, huisnummer, gemeenteCode) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(straatnaam, huisnummer, gemeenteCode, fields, undefined));
});

When('{string} wordt gevraagd van personen gezocht met straatnaam, huisnummer en gemeentecode van {aanduiding} en parameters', async function (fields, adresAanduiding, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(
            getStraatnaam(this.context, adresAanduiding), getHuisnummer(this.context, adresAanduiding), getGemeentecode(this.context, adresAanduiding),
            fields, dataTable));
});

When('{string} wordt gevraagd van personen gezocht met straatnaam {string}, huisnummer {string} en gemeentecode {string} en parameters', async function (fields, straatnaam, huisnummer, gemeenteCode, dataTable) {
    setFieldsHasBurgerservicenummer(this.context, fields);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(straatnaam, huisnummer, gemeenteCode, fields, dataTable));
});
