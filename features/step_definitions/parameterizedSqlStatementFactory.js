const { tableNameMap } = require('./brp');

function toDbTabelNaam(tabelNaam) {
    return tableNameMap.has(tabelNaam)
        ? tableNameMap.get(tabelNaam)
        : tabelNaam;
}

function addColumnNamesAndValues(data, statement) {
    data.forEach(function(row, index) {
        statement.text += index === 0
            ? `${row[0]}`
            : `,${row[0]}`;
        statement.values.push(row[1]);
    });
}

function addParameterizedValues(statement) {
    statement.values.forEach(function(_value, index) {
        statement.text += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });
}

function addSqlGeneratedColumnNames(sqlData, statement) {
    if(sqlData !== undefined) {
        sqlData.forEach(function(row, index) {
            statement.text += index === 0
            ? `${row[0]}`
            : `,${row[0]}`;
        });
        statement.text += ',';
    }
}

function addSqlGeneratedColumnValues(sqlData, statement) {
    if(sqlData !== undefined) {
        sqlData.forEach(function(row, index) {
            statement.text += index === 0
            ? `${row[1]}`
            : `,${row[1]}`;
        });
        statement.text += ',';
    }
}

function insertIntoStatementMetSqlGeneratedData(tabelNaam, data, sqlGeneratedData = undefined) {
    let tableName = toDbTabelNaam(tabelNaam);

    let statement = {
        text: `INSERT INTO public.${tableName}(`,
        values: []
    };

    addSqlGeneratedColumnNames(sqlGeneratedData, statement);
    addColumnNamesAndValues(data, statement);

    statement.text += ') VALUES(';

    addSqlGeneratedColumnValues(sqlGeneratedData, statement);
    addParameterizedValues(statement);

    statement.text += ')';

    return statement;
}

function insertIntoStatement(tabelNaam, data) {
    return insertIntoStatementMetSqlGeneratedData(tabelNaam, data);
}

function insertIntoAutorisatieStatement(data) {
    let statement = insertIntoStatementMetSqlGeneratedData(
        'autorisatie',
        data,
        [
            ['autorisatie_id', '(SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie)']
        ]
    );
    statement.text += ' RETURNING *';

    return statement;
}

function insertIntoGemeenteStatement(data) {
    return insertIntoStatement(
        'gemeente',
        data);
}

function insertIntoAdresStatement(data) {
    let statement = insertIntoStatementMetSqlGeneratedData(
        'adres',
        data,
        [
            ['adres_id', '(SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres)']
        ]
    );
    statement.text += ' RETURNING *';

    return statement;
}

function insertIntoPersoonlijstStatement(data) {
    let sqlGeneratedData = [];
    if(data[0][0] === 'pl_id'){
        sqlGeneratedData.push(['pl_id', data[0][1]]);
        data.shift();
    }
    else{
        sqlGeneratedData.push(['pl_id', '(SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl)']);

    }
    sqlGeneratedData.push(['mutatie_dt', 'current_timestamp']);

    let statement = insertIntoStatementMetSqlGeneratedData(
        'inschrijving',
        data,
        sqlGeneratedData
    );
    statement.text += ' RETURNING *';

    return statement;
}

function queryStatement(tabelNaam, selectFilter, whereFilter) {
    let tableName = toDbTabelNaam(tabelNaam);

    let statement = {
        text: `SELECT ${selectFilter} FROM public.${tableName}`,
        values: []
    };

    if(whereFilter !== undefined) {
        Object.keys(whereFilter).forEach(function(key, index) {
            if(index === 0) {
                statement.text += ' WHERE';
            }
            else {
                statement.text += ' AND';
            }
            statement.text += ` ${key}=$${index+1}`;
            statement.values.push(whereFilter[key]);
        });
    }

    return statement;
}

function queryRowCountStatement(tabelNaam, filter = undefined) {
    return queryStatement(tabelNaam, 'COUNT(*)', filter);
}

function queryLastRowStatement(tabelNaam, orderByColumnName, filter = undefined) {
    let statement = queryStatement(tabelNaam, '*', filter);

    statement.text += ` ORDER BY ${orderByColumnName} DESC LIMIT 1`;

    return statement;
}

function deleteStatement(tabelNaam, id = undefined) {
    let paramName;
    
    switch(tabelNaam) {
        case 'adres':
            paramName = 'adres_id';
            break;
        case 'autorisatie':
            paramName = 'afnemer_code';
            break;
        case 'gemeente':
            paramName = 'gemeente_code';
            break;
        default:
            paramName = 'pl_id';
            break;
    }

    const statement = {
        text: id !== undefined
            ? `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE ${paramName}=$1`
            : `DELETE FROM public.${tableNameMap.get(tabelNaam)}`,
        values: id !== undefined
            ? [id]
            : []
    };

    return statement;
}

module.exports = {
    deleteStatement,
    insertIntoAdresStatement,
    insertIntoAutorisatieStatement,
    insertIntoGemeenteStatement,
    insertIntoPersoonlijstStatement,
    insertIntoStatement,
    queryRowCountStatement,
    queryLastRowStatement
}