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

function addSqlGeneratedColumns(sqlData, statement, isValue = false) {
    if (sqlData !== undefined) {
        sqlData.forEach((row, index) => {
            statement.text += index === 0
                ? `${row[isValue ? 1 : 0]}`
                : `,${row[isValue ? 1 : 0]}`;
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

    addSqlGeneratedColumns(sqlGeneratedData, statement);
    addColumnNamesAndValues(data, statement);

    statement.text += ') VALUES(';

    addSqlGeneratedColumns(sqlGeneratedData, statement, true);
    addParameterizedValues(statement);

    statement.text += ')';

    return statement;
}

function insertIntoStatement(tabelNaam, data) {
    return insertIntoStatementMetSqlGeneratedData(tabelNaam, data);
}

function insertIntoStatementMetSqlGeneratedDataReturning(tabelNaam, data, sqlGeneratedPrimaryKey) {
    const statement = insertIntoStatementMetSqlGeneratedData(tabelNaam, data, sqlGeneratedPrimaryKey);

    statement.text += ' RETURNING *';

    return statement;
}

function insertIntoAutorisatieStatement(data) {
    return insertIntoStatementMetSqlGeneratedDataReturning('autorisatie', data, [
        ['autorisatie_id', '(SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie)']
    ]);
}

function insertIntoGemeenteStatement(data) {
    return insertIntoStatementMetSqlGeneratedData('gemeente', data);
}

function insertIntoAdresStatement(data) {
    return insertIntoStatementMetSqlGeneratedDataReturning('adres', data, [
        ['adres_id', '(SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres)']
    ]);
}

function insertIntoPersoonlijstStatement(data) {
    let sqlGeneratedData = [];
    if (data[0][0] === 'pl_id') {
        sqlGeneratedData.push(['pl_id', data[0][1]]);
        data.shift();
    }
    else {
        sqlGeneratedData.push(['pl_id', '(SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl)']);
    }
    sqlGeneratedData.push(['mutatie_dt', 'current_timestamp']);

    return insertIntoStatementMetSqlGeneratedDataReturning('inschrijving', data, sqlGeneratedData);
}

function queryStatement(tabelNaam, selectFilter, whereFilter) {
    const tableName = toDbTabelNaam(tabelNaam);

    const statement = {
        text: `SELECT ${selectFilter} FROM public.${tableName}`,
        values: []
    };

    if (whereFilter) {
        const whereClauses = Object.keys(whereFilter).map((key, index) => {
            statement.values.push(whereFilter[key]);
            return `${key}=$${index + 1}`;
        });

        statement.text += ` WHERE ${whereClauses.join(' AND ')}`;
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

const tabelPrimaryKeyMap = {
    adres: 'adres_id',
    autorisatie: 'autorisatie_id',
    gemeente: 'gemeente_code',
    default: 'pl_id'
};

function deleteStatement(tabelNaam, id = undefined) {
    const primaryKeyName = tabelPrimaryKeyMap[tabelNaam] || tabelPrimaryKeyMap.default;

    const statement = {
        text: id !== undefined
            ? `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE ${primaryKeyName}=$1`
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