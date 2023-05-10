function noSqlData(sqlData) {
    return sqlData === undefined ||
           (sqlData.length === 1 && Object.keys(sqlData[0]).length === 0);
}

async function executeSqlStatements(sqlData, pool, tableNameMap, logSqlStatements) {
    if (pool === undefined || noSqlData(sqlData)) {
        return;
    }

    const client = await pool.connect();
    try {
        await client.query('BEGIN');

        let adres_id;
        for(const sqlDataElement of sqlData) {
            if(adres_id !== undefined && sqlDataElement['adres'] === undefined) {
                sqlDataElement.ids = {
                    adres_id: adres_id
                }
            }

            await executeSql(client, sqlDataElement, tableNameMap, logSqlStatements);

            if(sqlDataElement.ids.adres_id !== undefined){
                adres_id = sqlDataElement.ids.adres_id;
            }
        }

        await client.query('COMMIT');
    }
    catch(ex) {
        console.log(ex);
        await client.query('ROLLBACK');
    }
    finally {
        if(client !== undefined){
            client.release();
        }
    }
}

async function rollbackSqlStatements(sqlData, pool, tableNameMap, logSqlStatements) {

    const client = await pool.connect();
    try {
        let adresData = [];

        for(const sqlDataElement of sqlData) {
            if (equals(sqlDataElement, ['adres', 'ids'])) {
                adresData.push(sqlDataElement);
            }
            else {
                if(adresData.find(adrData => adrData.ids.adres_id === sqlDataElement.ids.adres_id)) {
                    sqlDataElement.ids.adres_id = undefined;
                }

                await deleteRecords(client, sqlDataElement, tableNameMap, logSqlStatements);
            }
        }

        for(const adrData of adresData) {
            await deleteAdresRecord(client, adrData, tableNameMap, logSqlStatements);
        }
        await deleteAutorisatieRecords(client, tableNameMap, logSqlStatements);
    }
    catch(ex) {
        console.log(ex.stack);
    }
    finally {
        if(client !== undefined) {
            client.release();
        }
    }
}

function logIf(sqlStatement, logSqlStatements) {
    if(logSqlStatements) {
        console.log(sqlStatement);
    }
}

async function executeSql(client, sqlData, tableNameMap, logSqlStatements) {
    let plId = undefined;
    let adresId = undefined;
    let autorisatieId = undefined;

    if(sqlData.ids !== undefined && sqlData.ids.adres_id !== undefined) {
        adresId = sqlData.ids.adres_id;
    }
    if(sqlData['autorisatie'] !== undefined) {
        const sqlStatement = insertIntoAutorisatieStatement(sqlData['autorisatie'][0]);
        logIf(sqlStatement, logSqlStatements);
        const res = await client.query(sqlStatement);
        autorisatieId = res.rows[0]['autorisatie_id'];
    }
    if(sqlData['adres'] !== undefined) {
        const sqlStatement = insertIntoAdresStatement(sqlData['adres'][0]);
        logIf(sqlStatement, logSqlStatements);
        const res = await client.query(sqlStatement);
        adresId = res.rows[0]['adres_id'];
    }
    if(sqlData['inschrijving'] !== undefined) {
        const sqlStatement = insertIntoPersoonlijstStatement(sqlData['inschrijving'][0]);
        logIf(sqlStatement, logSqlStatements);
        const res = await client.query(sqlStatement);
        plId = res.rows[0]['pl_id'];
    }

    for(const key of Object.keys(sqlData)) {
        if (['inschrijving', 'adres', 'ids', 'autorisatie'].includes(key)) {
            continue;
        }

        for(const rowData of sqlData[key]) {
            const data = createStatementData(key, plId, adresId, rowData);

            const name = key.replace(/-\d$/, "");
            const sqlStatement = insertIntoStatement(name, data, tableNameMap);
            logIf(sqlStatement, logSqlStatements);
            await client.query(sqlStatement);
        }
    }

    sqlData.ids = {
        autorisatie_id: autorisatieId,
        adres_id: adresId,
        pl_id: plId
    };
}

function createStatementData(key, plId, adresId, rowData) {
    if(key === 'verblijfplaats') {
        if(adresId === undefined) {
            return [
                [ 'pl_id', plId ]
            ].concat(rowData);
        }
        return [
            [ 'pl_id', plId ],
            [ 'adres_id', adresId ]
        ].concat(rowData);
    }

    return [
        [ 'pl_id', plId ]
    ].concat(rowData);
}

function insertIntoAutorisatieStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_autorisatie(autorisatie_id',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie)';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoAdresStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_adres(adres_id',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres)';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoPersoonlijstStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_pl(pl_id,mutatie_dt',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoStatement(tabelNaam, data, tableNameMap) {
    let tableName = tableNameMap.get(tabelNaam);
    if(tableName === undefined) {
        tableName = tabelNaam;
    }
    let statement = {
        text: `INSERT INTO public.${tableName}(`,
        values: []
    };

    data.forEach(function(row, index) {
        statement.text += index === 0
            ? `${row[0]}`
            : `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES(';
    statement.values.forEach(function(_value, index) {
        statement.text += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });
    statement.text += ')';

    return statement;
}

function equals(sqlData, adresData) {
    return Object.keys(sqlData).length === adresData.length &&
           Object.keys(sqlData).every((v, i) => v === adresData[i])
}

async function deleteRecords(client, sqlData, tableNameMap, logSqlStatements) {
    if(sqlData.ids === undefined) {
        return;
    }

    let adresid;
    for(const [key] of tableNameMap) {
        let id;
        switch(key)
        {
            case 'adres':
                adresid = sqlData.ids.adres_id;
                break;
            case 'autorisatie':
                id = sqlData.ids.autorisatie_id;
                break;
            case 'protocollering':
                break;
            default:
                id = sqlData.ids.pl_id;
                break;
        }
        if(id !== undefined) {
            const sqlStatement = createDeleteStatement(key, id, tableNameMap);
            logIf(sqlStatement, logSqlStatements);
            await client.query(sqlStatement);
        }
    }
    if(adresid !== undefined) {
        const sqlStatement = createDeleteStatement('adres', adresid, tableNameMap);
        logIf(sqlStatement, logSqlStatements);
        await client.query(sqlStatement);
    }
}

function createDeleteStatement(tabelNaam, id, tableNameMap) {
    let naamId;
    
    switch(tabelNaam) {
        case 'adres':
            naamId = 'adres_id';
            break;
        case 'autorisatie':
            naamId = 'autorisatie_id';
            break;
        default:
            naamId = 'pl_id';
            break;
    }

    const statement = {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE ${naamId}=$1`,
        values: [id]
    };

    return statement;
}

async function deleteAdresRecord(client, sqlData, tableNameMap, logSqlStatements) {
    if(sqlData === undefined || sqlData.ids === undefined) {
        return;
    }

    const id = sqlData.ids.adres_id;

    if(id !== undefined) {
        const sqlStatement = createDeleteStatement('adres', id, tableNameMap);
        logIf(sqlStatement, logSqlStatements);
        await client.query(sqlStatement);
    }
}

async function deleteAutorisatieRecords(client, tableNameMap, logSqlStatements) {
    const statement = {
        text: `DELETE FROM public.${tableNameMap.get('autorisatie')} WHERE afnemer_code=$1`,
        values: [8]
    };

    logIf(statement, logSqlStatements);

    await client.query(statement);
}

module.exports = {
    noSqlData,
    executeSqlStatements,
    rollbackSqlStatements,
    insertIntoPersoonlijstStatement,
    insertIntoAdresStatement,
    insertIntoStatement
}
