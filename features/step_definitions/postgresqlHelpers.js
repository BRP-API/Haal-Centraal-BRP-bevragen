const {
    deleteStatement,
    insertIntoAdresStatement,
    insertIntoAutorisatieStatement,
    insertIntoGemeenteStatement,
    insertIntoPersoonlijstStatement,
    insertIntoStatement,
    queryRowCountStatement,
    queryLastRowStatement } = require('./parameterizedSqlStatementFactory');
const { tableNameMap } = require('./brp');

function noSqlData(sqlData) {
    return sqlData === undefined ||
        (sqlData.length === 1 && Object.keys(sqlData[0]).length === 0);
}

function mustLog(result) {
    return (result.rowCount === null || result.rowCount === 0) && global.scenario.tags.some(t => ['@protocollering'].includes(t));
}

async function ExecuteAndLogStatement(client, sqlStatement) {
    global.logger.info('execute', sqlStatement);

    try {
        const result = await client.query(sqlStatement);

        if(mustLog(result)) {
            global.logger.warn(`${global.scenario.name}. 0 rows affected`, sqlStatement);
        }
    
        return result;
    }
    catch(ex) {
        global.logger.error(`exception in ${global.scenario.name}`, sqlStatement, ex);
        throw ex;
    }
}

async function ExecuteAndLogDeleteStatement(client, tabelNaam, id=undefined) {
    return await ExecuteAndLogStatement(client, deleteStatement(tabelNaam, id));
}

function getAdresId(sqlData, adresIndex) {
    const adressenData = sqlData.find(e => Object.keys(e).includes('adres'));

    for(const key of Object.keys(adressenData.adres)) {
        if(adressenData.adres[key].index === adresIndex) {
            return adressenData.adres[key].data?.find(elem => elem[0] === 'adres_id')[1];
        }
    }
    return undefined;
}

function setAdresIdForVerblijfplaatsen(sqlDataElement, sqlData) {
    if(sqlDataElement['verblijfplaats'] === undefined) {
        return;
    }

    for(const verblijfplaatsElem of sqlDataElement['verblijfplaats']) {
        let adresIdElem = verblijfplaatsElem.find(elem => elem[0] === 'adres_id');
        if(adresIdElem !== undefined) {
            adresIdElem[1] = getAdresId(sqlData, Number(adresIdElem[1])) + '';
        }
    }
}

async function executeSqlStatements(sqlContext, sqlData, pool) {
    if (pool === undefined || noSqlData(sqlData)) {
        global.logger.info('geen pool of geen sqlData');
        return;
    }

    const client = await pool.connect();
    try {
        await client.query('BEGIN');

        for(const sqlDataElement of sqlData) {
            setAdresIdForVerblijfplaatsen(sqlDataElement, sqlData);

            await executeSql(client, sqlDataElement);
        }

        await client.query('COMMIT');
    }
    catch(ex) {
        global.logger.error(ex);
        await client.query('ROLLBACK');
    }
    finally {
        client?.release();
    }
}

async function deleteAllRowsInAllTables(client) {
    global.logger.debug('delete all rows in all tables');

    const aggregateRoots = ['adres'];

    for(const [key] of tableNameMap) {
        if(aggregateRoots.includes(key)) {
            continue;
        }

        await ExecuteAndLogDeleteStatement(client, key);
    }

    for(const key of aggregateRoots) {
        await ExecuteAndLogDeleteStatement(client, key)
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

async function rollbackSqlStatements(sqlContext, sqlData, pool) {
    if(sqlData === undefined) {
        return;
    }
    if(!sqlContext.cleanup) {
        return;
    }

    const deleteIndividualRecords = sqlContext.deleteIndividualRecords;

    const client = await pool.connect();

    try {
        if(deleteIndividualRecords) {
            await deleteInsertedRows(client, sqlData);
        }
        else {
            await deleteAllRowsInAllTables(client);
        }
    }
    catch(ex) {
        global.logger.error(ex.stack);
    }
    finally {
        if(client !== undefined) {
            client.release();
        }
    }
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

        await ExecuteAndLogDeleteStatement(client, 'adres', id);
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

        await ExecuteAndLogDeleteStatement(client, 'autorisatie', id);
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

        await ExecuteAndLogDeleteStatement(client, 'gemeente', id);
    }
}

async function deleteProtocolleringRecords(client) {
    await ExecuteAndLogDeleteStatement(client, 'protocollering', undefined);
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
            await ExecuteAndLogDeleteStatement(client, tabelNaam, id);
        }
    }
}

async function insertAdressen(client, sqlData) {
    const adresData = sqlData['adres'];
    if(adresData === undefined) {
        return;
    }

    for(const key of Object.keys(adresData)) {
        const res = await ExecuteAndLogStatement(client,
                                                 insertIntoAdresStatement(adresData[key].data));

        adresData[key].data.push(['adres_id', res.rows[0]['adres_id']]);
    }
}

async function insertAutorisatieRijen(client, sqlData) {
    const autorisatieData = sqlData['autorisatie']; 
    if(autorisatieData === undefined) {
        return;
    }

    for(const rowData of autorisatieData) {
        const res = await ExecuteAndLogStatement(client, insertIntoAutorisatieStatement(rowData));

        rowData.push(['autorisatie_id', res.rows[0]['autorisatie_id']]);
    }
}

async function insertGemeenten(client, sqlData) {
    const gemeenteData = sqlData['gemeente'];
    if(gemeenteData === undefined) {
        return;
    }

    for(const key of Object.keys(gemeenteData)) {
        await ExecuteAndLogStatement(client, insertIntoGemeenteStatement(gemeenteData[key].data));
    }
}

async function insertInschrijvingRij(client, sqlData) {
    const inschrijvingData = sqlData['inschrijving'];
    if(inschrijvingData === undefined) {
        return;
    }

    let plId;

    for(const rowData of inschrijvingData) {
        const res = await ExecuteAndLogStatement(client, insertIntoPersoonlijstStatement(rowData));

        plId = res.rows[0]['pl_id'];
        rowData.push(['pl_id', plId]);
    }

    return plId;
}

async function executeSql(client, sqlData) {
    await insertAutorisatieRijen(client, sqlData);
    await insertGemeenten(client, sqlData);
    await insertAdressen(client, sqlData);
    const plId = await insertInschrijvingRij(client, sqlData);

    for(const key of Object.keys(sqlData)) {
        if (['inschrijving', 'gemeente', 'adres', 'ids', 'autorisatie'].includes(key)) {
            continue;
        }

        for(const rowData of sqlData[key]) {
            const data = createStatementData(key, plId, rowData);

            const name = key.replace(/-\d/g, '');

            await ExecuteAndLogStatement(client, insertIntoStatement(name, data));
        }
    }
}

function createStatementData(key, plId, rowData) {
    return [
        [ 'pl_id', plId ]
    ].concat(rowData);
}

async function queryRowCount(pool, tableName, filter = undefined) {
    if(pool === undefined) {
        return undefined;
    }

    const statement = queryRowCountStatement(tableName, filter);
    global.logger.info('execute', statement);

    const client = await pool.connect();

    try {
        const res = await client.query(statement);

        return res.rows[0]['count'];
    }
    catch(ex) {
        global.logger.error(ex.stack);
    }
    finally {
        client.release();
    }
}

async function queryLastRow(pool, tableName, orderByColumnName, filter = undefined) {
    if(pool === undefined) {
        return undefined;
    }

    const statement = queryLastRowStatement(tableName, orderByColumnName, filter);
    global.logger.info('execute', statement);

    const client = await pool.connect();

    try {
        const res = await client.query(statement);

        return res.rows[0];
    }
    catch(ex) {
        global.logger.error(ex.stack);
    }
    finally {
        client.release();
    }
}

module.exports = {
    executeSqlStatements,
    rollbackSqlStatements,
    queryRowCount,
    queryLastRow
}
