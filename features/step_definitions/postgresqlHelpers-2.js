const { tableNameMap } = require('./brp');
const { toDateOrString } = require('./brpDatum');

function mustLog(result) {
    return (result.rowCount === null || result.rowCount === 0) && global.scenario.tags.some(t => ['@protocollering'].includes(t));
}

async function executeAndLogStatement(client, statement) {
    global.logger.info('execute', statement);

    try {
        const result = await client.query(statement.text, statement.values);

        if(mustLog(result)) {
            global.logger.warn(`${global.scenario.name}. 0 rows affected`, statement);
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
        switch(statement.categorie) {
            case 'inschrijving':
                pkId = await executeInsertInschrijving(client, statement);
                break;
            default:
                statement.values[0] = pkId;
                await executeAndLogStatement(client, statement);
        }
    }

    return pkId;
}

async function executeAdresStatements(client, statements) {
    let pkId;

    for(const statement of statements) {
        const result = await executeAndLogStatement(client, statement);
        pkId = result.rows[0]['adres_id'];
    }

    return pkId;
}

async function truncate(tableName) {
    if (!global.pool) {
        global.logger.info('geen pool');
        return;
    }

    const client = await global.pool.connect();
    try {
        await client.query('BEGIN');

        await executeAndLogTruncateStatement(client, tableName);

        await client.query('COMMIT');
    }
    catch (ex) {
        global.logger.error(ex.message);
        await client.query('ROLLBACK');
    }
    finally {
        client?.release();
    }
}

async function select(tableName, dataTable) {
    if(!dataTable) {
        global.logger.info('geen datatabel');
        return;
    }

    if (!global.pool) {
        global.logger.info('geen pool');
        return;
    }

    const client = await global.pool.connect();
    const results = [];

    try {
        await client.query('BEGIN');

        dataTable.hashes().forEach(async (row) => {
            let result = await executeAndLogStatement(client, selectStatement(tableName, Object.keys(row), Object.values(row)));
            results.push( {
                result: result,
                row: row
            });
        });

        await client.query('COMMIT');
    }
    catch (ex) {
        global.logger.error(ex.message);
        await client.query('ROLLBACK');
    }
    finally {
        client?.release();
    }

    return results;
}

async function selectFirstOrDefault(tabelNaam, columnNames, whereColumnName, whereValue, defaultValue = '') {
    let statement = {
        text: `SELECT ${columnNames.join(', ')} FROM public.${tabelNaam} WHERE ${whereColumnName} = $1`,
        values: [whereValue]
    };

    const client = await global.pool.connect();
    let result = [];
    try {

        await client.query('BEGIN');
        result = await executeAndLogStatement(client, statement);

        await client.query('COMMIT');
    }
    catch (ex) {
        global.logger.error(ex.message);
        await client.query('ROLLBACK');
    }
    finally {
        client?.release();
    }

    return result.rows ? result.rows[0][columnNames[0]] + '' : defaultValue;
}

function setAdresIdForVerblijfplaatsen(persoon, adressen) {
    for(let statement of persoon.statements) {
        if(statement.categorie === 'verblijfplaats' && statement.text.includes('adres_id')) {
            const match = statement.text.match(/^INSERT INTO [a-z0-9._]*\(([a-z_,]*)\) VALUES\([\d$,]*\)$/);
            const columns = match
                ? match[1].split(',').map(c => c.trim())
                : [];
            const adresIdIndex = columns.indexOf('adres_id');
            global.logger.info(`adresIdIndex: ${adresIdIndex}`, columns);
            if(adresIdIndex >= 0) {
                statement.values[adresIdIndex] = adressen[statement.values[adresIdIndex]].adresId;
            }
        }
    }
}

async function execute(sqlStatements) {
    if(!global.pool) {
        global.logger.info('geen pool');
        return;
    }

    const client = await global.pool.connect();
    try {
        await client.query('BEGIN');

        for(let adres of sqlStatements.adressen) {
            adres.adresId = await executeAdresStatements(client, adres.statements);
        }
        for(let persoon of sqlStatements.personen) {
            setAdresIdForVerblijfplaatsen(persoon, sqlStatements.adressen);
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

function selectStatement(tabelNaam, columns, values) {
    values = values.map((v) => toDateOrString(v));

    let counter = 0;
    const whereColumns = columns.map((column, index) => {
        return values[index].length == 0 ?
            column + ` IS NULL` :
            column + `=$${++counter}`;
    });
    
    values = values.filter(v => v.length > 0);
    
    return {
        text: `SELECT ${columns.join()} FROM public.${tabelNaam} WHERE ${whereColumns.join(` AND `)}`,
        categorie: tabelNaam,
        values: values
    };
}

function deleteStatement(tabelNaam, id = undefined) {
    return {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)}`,
        values: []
    }
}

function truncateStatement(tabelNaam, id = undefined) {
    return {
        text: `DELETE FROM public.${tabelNaam}`,
        values: []
    }
}

async function executeAndLogTruncateStatement(client, tabelNaam, id = undefined) {
    return await executeAndLogStatement(client, truncateStatement(tabelNaam, id));
}

async function executeAndLogDeleteStatement(client, tabelNaam, id = undefined) {
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
    rollback,
    truncate,
    select,
    selectFirstOrDefault
}
