const { tableNameMap } = require('./brp');
const { toDateOrString } = require('./brpDatum');
const { deleteStatement } = require('./parameterizedSqlStatementFactory');

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

async function select(tableName, objecten) {
    if(!objecten) {
        global.logger.info('geen objecten');
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

        for(const obj of objecten) {
            let result = await executeAndLogStatement(client, selectStatement(tableName, Object.keys(obj), Object.values(obj)));
            results.push( {
                result: result,
                row: obj
            });
        }

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

async function executeAndLogDeleteStatement(client, tabelNaam, id = undefined) {
    return await executeAndLogStatement(client, deleteStatement(tabelNaam, id));
}

async function deleteAllRowsInAllTables(client) {
    global.logger.debug('delete all rows in all tables');

    for(const [key] of tableNameMap) {
        await executeAndLogDeleteStatement(client, key);
    }
}

async function deleteInsertedPersoonRows(client, personen) {
    if(!personen) {
        return;
    }

    for(const persoon of personen) {
        if(persoon.plId) {
            for(const key of Object.keys(persoon)) {
                if(tableNameMap.has(key)) {
                    await executeAndLogDeleteStatement(client, key, persoon.plId);
                }
            }
        }
    }
}

async function deleteInsertedAdresRows(client, adressen) {
    if(!adressen) {
        return;
    }

    for(const adres of adressen) {
        if(adres.adresId) {
            await executeAndLogDeleteStatement(client, 'adres', adres.adresId);
        }
    }
}

async function deleteInsertedRows(client, sqlData) {
    global.logger.debug('delete inserted rows');

    if(!sqlData) {
        return;
    }

    await deleteInsertedPersoonRows(client, sqlData.personen);
    await deleteInsertedAdresRows(client, sqlData.adressen);
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
        else {
            await deleteAllRowsInAllTables(client);
        }
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
    select,
    selectFirstOrDefault
}
