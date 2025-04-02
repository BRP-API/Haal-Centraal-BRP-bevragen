const { When } = require('@cucumber/cucumber');
const fs = require('fs');
const { executeSqlStatements } = require('./postgresqlHelpers');
const { execute } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { objectToDataTable, mapDataTableToEntiteit } = require('./dataTableFactory');

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data.personen.at(-1)
        : context.data.personen.find(p => p.id === `persoon-${aanduiding}`);
}

function getPersoonBsn(context, aanduiding) {
    return getPersoon(context, aanduiding).persoon.at(-1).burger_service_nr;
}

function getAdres(context, aanduiding) {
    return !aanduiding
        ? context.data.adressen.at(-1)
        : context.data.adressen.find(a => a.id === `adres-${aanduiding}`);
}

function getAdresseerbaarObjectIdentificatie(context, aanduiding) {
    return getAdres(context, aanduiding).adres.verblijf_plaats_ident_code;
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

async function execSqlStatements(context) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    if(context.data) {
        const sqlStatements = generateSqlStatementsFrom(context.data);
        global.logger.info('uit te voeren sql statements', sqlStatements);

        if(!context.isStapDocumentatieScenario) {
            await execute(sqlStatements);
        }
    }
    else {
        if(!context.isStapDocumentatieScenario) {
            await executeSqlStatements(context.sql, context.sqlData, global.pool);
        }
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

    requestBody.adresseerbaarObjectIdentificatie = !adresseerbaarObjectIdentificatie
        ? '0000000000000001'
        : adresseerbaarObjectIdentificatie;

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetGeslachtsnaamEnGeboortedatum(geslachtsnaam, geboortedatum, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetGeslachtsnaamEnGeboortedatum',
        fields: fields
    };

    requestBody.geslachtsnaam = !geslachtsnaam
        ? 'doe'
        : geslachtsnaam;
    requestBody.geboortedatum = !geboortedatum
        ? '2000-01-01'
        : geboortedatum;

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetGeslachtsnaamVoornamenEnGemeenteVanInschrijving(geslachtsnaam, voornamen, gemeenteVanInschrijving, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetNaamEnGemeenteVanInschrijving',
        fields: fields
    };

    requestBody.geslachtsnaam = !geslachtsnaam
        ? 'doe'
        : geslachtsnaam;
    requestBody.voornamen = !voornamen
        ? 'john'
        : voornamen;
    requestBody.gemeenteVanInschrijving = !gemeenteVanInschrijving
        ? '0000'
        : gemeenteVanInschrijving;

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetNummeraanduidingIdentificatie(nummeraanduidingIdentificatie, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetNummeraanduidingIdentificatie',
        fields: fields
    };

    requestBody.nummeraanduidingIdentificatie = !nummeraanduidingIdentificatie
        ? '0000000000000001'
        : nummeraanduidingIdentificatie;

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetPostcodeEnHuisnummer(postcode, huisnummer, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetPostcodeEnHuisnummer',
        fields: fields
    };

    requestBody.postcode = !postcode
        ? '1000 AA'
        : postcode;
    requestBody.huisnummer = !huisnummer
        ? '1'
        : huisnummer;

    mapDataTableToEntiteit(requestBody, parametersDataTable);

    return objectToDataTable(requestBody);
}

function createDataTableForZoekMetStraatnaamHuisnummerEnGemeenteVanInschrijving(straat, huisnummer, gemeenteVanInschrijving, fields, parametersDataTable) {
    let requestBody = {
        type: 'ZoekMetStraatHuisnummerEnGemeenteVanInschrijving',
        fields: fields
    };

    requestBody.straat = !straat
        ? 'straat'
        : straat;
    requestBody.huisnummer = !huisnummer
        ? '1'
        : huisnummer;
    requestBody.gemeenteVanInschrijving = !gemeenteVanInschrijving
        ? '0000'
        : gemeenteVanInschrijving;

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

    if(context.gezag !== undefined) {
        fs.writeFileSync(context.gezagDataPath, JSON.stringify(context.gezag, null, '\t'));
    }
    if(context.downstreamApiResponseHeaders !== undefined) {
        fs.writeFileSync(context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(context.downstreamApiResponseHeaders[0], null, '\t'));
    }
    if(context.downstreamApiResponseBody !== undefined) {
        fs.writeFileSync(context.downstreamApiDataPath + '/response-body.json',
                         context.downstreamApiResponseBody);
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

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd van personen gezocht met ([a-zA-Z, ]*)$/, async function (fields, parameterNames) {
    global.logger.info(`als '${fields} wordt gevraagd van personen gezocht met ${parameterNames}'`);

    await handleRequestWithParameters(this.context,
                                      'personen',
                                      createDataTableForRequest(parameterNames, fields));
});

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd van personen gezocht met burgerservicenummer(?:s)? '([0-9, ]*)'$/, async function (fields, burgerserservicenummers) {
    global.logger.info(`als '${fields} wordt gevraagd van personen gezocht met burgerserservicenummer(s) '${burgerserservicenummers}'`);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForRaadpleegMetBurgerservicenummer(burgerserservicenummers, fields, undefined));
});

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd van personen gezocht met burgerservicenummer(?:s)? '([0-9, ]*)' en parameters$/, async function (fields, burgerserservicenummers, dataTable) {
    global.logger.info(`als '${fields} wordt gevraagd van personen gezocht met burgerserservicenummer(s) '${burgerserservicenummers}' en parameters`);

    await handleRequestWithParameters(this.context,
                                      'personen',
                                      createDataTableForRaadpleegMetBurgerservicenummer(burgerserservicenummers, fields, dataTable));
});

When(/^'([a-zA-Z0-9.]*)' wordt gevraagd (?:van personen gezocht met burgerservicenummer )?van '([a-zA-Z0-9]*)'$/, async function (fields, persoonAanduiding) {
    global.logger.info(`als '${fields} wordt gevraagd van personen gezocht met burgerserservicenummer van '${persoonAanduiding}'`);

    if(this.context.isGezagApiAanroep) {
        let requestBody = {
            burgerservicenummer: getPersoonBsn(this.context, persoonAanduiding),
        };
    
        await handleRequestWithParameters(this.context,
            'gezag',
            objectToDataTable(requestBody));
    }
    else {
        await handleRequestWithParameters(this.context,
            'personen',
            createDataTableForRaadpleegMetBurgerservicenummer(getPersoonBsn(this.context, persoonAanduiding), fields, undefined));
    }
});

When('{string} wordt gevraagd van personen gezocht met adresseerbaar object identificatie van {string}', async function (fields, adresAanduiding) {
    global.logger.info(`als '${fields} wordt gevraagd van personen gezocht met adresseerbaar object identificatie van '${adresAanduiding}'`);

    await handleRequestWithParameters(this.context,
        'personen',
        createDataTableForZoekMetAdresseerbaarObjectIdentificatie(getAdresseerbaarObjectIdentificatie(this.context, adresAanduiding), fields, undefined));
});
