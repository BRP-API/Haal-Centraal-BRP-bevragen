const { createArrayFrom, getPlId } = require('./dataTable2Array');
const { columnNameMap, persoonTypeMap } = require('./brp');

function getNextStapelNr(sqlData, gegevensgroep) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(gegevensgroep)){
            stapelNr = Number(key.replace(`${gegevensgroep}-`, ''));
        }
    });

    return stapelNr+1;
}

function createInschrijving(context, dataTable, defaultGeheim = false, defaultPlId = undefined) {
    let sqlData = context.sqlData.at(-1);

    let data = [];

    if(defaultPlId !== undefined) {
        data.push([ 'pl_id', defaultPlId]);
    }
    if(defaultGeheim) {
        data.push([ 'geheim_ind', '0' ]);
    }
    if(dataTable !== undefined) {
        data = data.concat(createArrayFrom(dataTable, columnNameMap));
    }

    sqlData['inschrijving'] = [data];
}

function createPersoonTypeData(persoonType, dataTable, burgerservicenummer, stapelNr) {
    let data = [
        [ 'stapel_nr', stapelNr-1 + ''],
        [ 'volg_nr', '0'],
    ];

    if(persoonTypeMap.has(persoonType)){
        data.push([ 'persoon_type', persoonTypeMap.get(persoonType)]);
    }

    if(burgerservicenummer !== undefined) {
        data.push([ 'burger_service_nr', burgerservicenummer]);
    }

    if(dataTable !== undefined) {
        data = data.concat(createArrayFrom(dataTable, columnNameMap))
    };

    return data;
}

function createPersoon(context, burgerservicenummer, dataTable = undefined) {
    if(context.sqlData === undefined) {
        context.sqlData = [];
    }
    context.sqlData.push({});

    createInschrijving(context, undefined, true, getPlId(dataTable));

    let sqlData = context.sqlData.at(-1);

    sqlData['persoon'] = [ createPersoonTypeData('persoon', dataTable, burgerservicenummer, 1) ];

    return sqlData;
}

function createVoorkomenData(dataTable) {
    return [
        [ 'volg_nr', '0']
    ].concat(createArrayFrom(dataTable, columnNameMap));
}

function createGegevensgroep(context, gegevensgroep, dataTable) {
    let sqlData = context.sqlData.at(-1);

    if(gegevensgroep === 'inschrijving' || gegevensgroep === 'kiesrecht') {
        createInschrijving(context, dataTable, gegevensgroep !== 'inschrijving');
    }
    else {
        sqlData[gegevensgroep] = [ createVoorkomenData(dataTable) ];
    }
}

function createPersoonMetGegevensgroep(context, burgerservicenummer, gegevensgroep, dataTable) {
    createPersoon(context, burgerservicenummer, undefined);

    createGegevensgroep(context, gegevensgroep, dataTable);
}

function createGegevensgroepCollectie(context, relatieType, dataTable) {
    let sqlData = context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, relatieType);
    sqlData[`${relatieType}-${stapelNr}`] = [ createPersoonTypeData(relatieType, dataTable, undefined, stapelNr) ];
}

function createPersoonMetGegevensgroepCollectie(context, burgerservicenummer, gegevensgroep, dataTable) {
    createPersoon(context, burgerservicenummer, undefined);

    createGegevensgroepCollectie(context, gegevensgroep, dataTable);
}

function createStapelData(dataTable, columnNameMap, stapelNr=0) {
    return [
        [ 'stapel_nr', stapelNr-1 + '']
      ].concat(createArrayFrom(dataTable, columnNameMap));
}

function createStapel(context, gegevensgroep, dataTable) {
    let sqlData = context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, gegevensgroep);

    sqlData[`${gegevensgroep}-${stapelNr}`] = [
        createStapelData(dataTable, columnNameMap, stapelNr)
    ];
}

function createPersoonMetStapel(context, burgerservicenummer, gegevensgroep, dataTable) {
    createPersoon(context, burgerservicenummer);

    createStapel(context, gegevensgroep, dataTable);
}

function updatePersoon(context, dataTable) {
    let sqlData = context.sqlData.at(-1);

    sqlData['persoon'][0] = sqlData['persoon'][0].concat(createArrayFrom(dataTable, columnNameMap));
}

function ophogenVolgnr(sqlData, isCorrectie = false) {
    sqlData.forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0' && isCorrectie) {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
}

function wijzigPersoon(context, dataTable, isCorrectie = false) {
    let sqlData = context.sqlData.at(-1);

    ophogenVolgnr(sqlData['persoon'], isCorrectie);

    sqlData['persoon'].push(createPersoonTypeData('persoon', dataTable, undefined, 1));
}

function wijzigGegevensgroep(context, gegevensgroep, dataTable, isCorrectie = false) {
    let sqlData = context.sqlData.at(-1);

    const foundRelatie = Object.keys(sqlData).findLast(key => key.startsWith(gegevensgroep));

    ophogenVolgnr(sqlData[foundRelatie], isCorrectie);

    const stapelNr = sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');

    if(stapelNr !== undefined) {
        sqlData[foundRelatie].push(createPersoonTypeData(gegevensgroep, dataTable, undefined, Number(stapelNr[1])+1));
    }
    else {
        sqlData[foundRelatie].push(createVoorkomenData(dataTable));
    }
}

module.exports = {
    createPersoon,
    createPersoonMetGegevensgroep,
    createPersoonMetStapel,
    createStapel,
    createPersoonMetGegevensgroepCollectie,
    createInschrijving,
    createGegevensgroep,
    createGegevensgroepCollectie,
    updatePersoon,
    wijzigPersoon,
    wijzigGegevensgroep
}
