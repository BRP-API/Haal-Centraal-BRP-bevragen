const { tableNameMap } = require('./brp');

function mustLog(result) {
    return (result.rowCount === null || result.rowCount === 0) && global.scenario.tags.some(t => ['@protocollering'].includes(t));
}

async function executeAndLogStatement(client, statement) {
    global.logger.info('execute', statement);

    try {
        const result = await client.query(statement.text, statement.values);

        if(mustLog(result)) {
            global.logger.warn(`${global.scenario.name}. 0 rows affected`, sqlStatement);
        }

        return result;
    }
    catch(ex) {
        global.logger.error(`exception in ${global.scenario.name}`, statement, ex);
        throw ex;
    }
}

async function executeInsertInschrijving(client, statement) {
    const result = await executeAndLogStatement(client, statement);

    return result.rows[0]['pl_id'];
}

async function executeStatements(client, statements) {
    let pkId;

    for(const statement of statements) {
        if(statement.categorie === 'inschrijving') {
            pkId = await executeInsertInschrijving(client, statement);
        }
        else {
            statement.values[0] = pkId;
            await executeAndLogStatement(client, statement);
        }
    }

    return pkId;
}

async function execute(sqlStatements) {
    if(!global.pool) {
        global.logger.info('geen pool');
        return;
    }

    const client = await global.pool.connect();
    try {
        await client.query('BEGIN');

        for(let persoon of sqlStatements.personen) {
            persoon.plId = await executeStatements(client, persoon.statements);
        }

        await client.query('COMMIT');
    }
    catch(ex) {
        global.logger.error(ex.message);
        await client.query('ROLLBACK');
    }
    finally {
        client?.release();
    }
}

function deleteStatement(tabelNaam, id) {
    return {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)}`,
        values: []
    }
}

async function executeAndLogDeleteStatement(client, tabelNaam, id=undefined) {
    return await executeAndLogStatement(client, deleteStatement(tabelNaam, id));
}

async function deleteAllRowsInAllTables(client) {
    global.logger.debug('delete all rows in all tables');

    for(const [key] of tableNameMap) {
        await executeAndLogDeleteStatement(client, key);
    }
}

async function deleteInsertedRows(client, sqlData) {
    global.logger.debug('delete inserted rows');

    if(sqlData === undefined) {
        return;
    }

    let adresData = [];

    for(const sqlDataElement of sqlData) {
        if (sqlDataElement['adres'] !== undefined) {
            adresData.push(sqlDataElement);
        }
        else {
            await deleteRecords(client, sqlDataElement, true);
        }
    }

    for(const adrData of adresData) {
        await deleteAdresRij(client, adrData);
    }
    await deleteGemeenteRijen(client, sqlData.find(el => el['gemeente'] !== undefined));
    await deleteAutorisatieRecords(client, sqlData.find(el => el['autorisatie'] !== undefined));
    await deleteProtocolleringRecords(client);
}

function getElementValue(data, elementName) {
    const elem = data.find(e => e[0] === elementName);

    return elem !== undefined
        ? Number(elem[1])
        : undefined;
}

async function deleteAdresRij(client, sqlData) {
    const adresData = sqlData?.adres;
    if(adresData === undefined) {
        return;
    }

    for(const key of Object.keys(adresData)) {
        const id = getElementValue(adresData[key].data, 'adres_id');
        if(id === undefined) {
            continue;
        }

        await executeAndLogDeleteStatement(client, 'adres', id);
    }
}

async function deleteAutorisatieRecords(client, sqlData) {
    if(sqlData === undefined || sqlData['autorisatie'] === undefined) {
        return;
    }
    const autorisatieData = sqlData['autorisatie']; 

    for(const rowData of autorisatieData) {
        const id = getElementValue(rowData, 'afnemer_code');
        if(id === undefined) {
            continue;
        }

        await executeAndLogDeleteStatement(client, 'autorisatie', id);
    }
}

async function deleteGemeenteRijen(client, sqlData) {
    if(sqlData === undefined || sqlData['gemeente'] === undefined) {
        return;
    }
    const gemeenteData = sqlData['gemeente'];

    for(const key of Object.keys(gemeenteData)) {
        const id = getElementValue(gemeenteData[key].data, 'gemeente_code');
        if(id === undefined) {
            continue;
        }

        await executeAndLogDeleteStatement(client, 'gemeente', id);
    }
}

async function deleteProtocolleringRecords(client) {
    await executeAndLogDeleteStatement(client, 'protocollering', undefined);
}

async function deleteRecords(client, sqlData, deleteIndividualRecords = true) {
    const inschrijvingData = sqlData?.inschrijving;
    if(inschrijvingData === undefined) {
        return;
    }

    const id = deleteIndividualRecords
        ? getElementValue(inschrijvingData[0], 'pl_id')
        : undefined;

    // bijhouden van reeds opgeschoonde tabellen, zodat deze niet opnieuw wordt opgeschoond met als gevolg rowCount == 0
    let opgeschoondeTabellen = [];
    for(const key of Object.keys(sqlData)) {
        const tabelNaam = key.replace(/-\w*/g, '');

        if(['autorisatie', 'ouder', 'kind', 'partner'].includes(tabelNaam)) {
            continue;
        }

        if(tableNameMap.has(tabelNaam) && !opgeschoondeTabellen.includes(tabelNaam)) {
            opgeschoondeTabellen.push(tabelNaam);
            await executeAndLogDeleteStatement(client, tabelNaam, id);
        }
    }
}

async function rollback(sqlContext, sqlData) {
    if(!global.pool) {
        global.logger.info('geen pool');
        return;
    }

    if(!sqlContext.cleanup) {
        global.logger.info('geen cleanup');
        return;
    }

    const deleteIndividualRecords = sqlContext.deleteIndividualRecords;

    const client = await global.pool.connect();

    try {
        if(deleteIndividualRecords) {
            await deleteInsertedRows(client, sqlData);
        }
        await deleteAllRowsInAllTables(client);
    }
    catch(ex) {
        global.logger.error(ex.stack);
    }
    finally {
        client?.release();
    }
}

module.exports = {
    execute,
    rollback
}
