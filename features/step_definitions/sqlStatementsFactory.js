const { toDbTableName } = require('./brp');

function createAndReturnInsertedStatement(entityName, primaryKey, entity, additionalColumns = {}) {
    const tableName = toDbTableName(entityName);

    let statementText = `INSERT INTO public.${tableName}(`;
    let values = [];

    // Add primary key and additional columns
    statementText += primaryKey;
    for (const column of Object.keys(additionalColumns)) {
        statementText += `,${column}`;
    }

    // Add entity columns
    for (const key of Object.keys(entity)) {
        statementText += `,${key}`;
    }

    statementText += ') VALUES(';

    // Add primary key value
    statementText += `(SELECT COALESCE(MAX(${primaryKey}), 0)+1 FROM public.${tableName})`;

    // Add additional column values
    for (const value of Object.values(additionalColumns)) {
        statementText += `,${value}`;
    }

    // Add entity values
    let index = 0;
    for (const key of Object.keys(entity)) {
        values.push(entity[key]);
        statementText += `,$${index + 1}`;
        index++;
    }

    statementText += ') RETURNING *';

    return {
        text: statementText,
        categorie: entityName,
        values: values
    };
}

function createInsertIntoPersoonslijstStatement(inschrijving) {
    return createAndReturnInsertedStatement(
        'inschrijving',
        'pl_id',
        inschrijving,
        { mutatie_dt: 'current_timestamp' }
    );
}

function createInsertIntoAdresStatement(adres) {
    return createAndReturnInsertedStatement(
        'adres',
        'adres_id',
        adres
    );
}

function createInsertAutorisatieIntoStatement(autorisatie) {
    return createAndReturnInsertedStatement(
        'autorisatie',
        'autorisatie_id',
        autorisatie
    );
}

function createInsertIntoStatement(entityNaam, entity) {
    const tableName = toDbTableName(entityNaam.replace(/-.*$/, ''));

    let statementText = `INSERT INTO public.${tableName}(`;
    let values = [];

    let index = 0;
    for (const key of Object.keys(entity)) {
        statementText += index === 0
            ? key
            : `,${key}`;
        index++;
    }

    statementText += ') VALUES(';

    index = 0;
    for (const key of Object.keys(entity)) {
        values.push(entity[key]);

        statementText += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
        index++;
    }

    statementText += ')';

    return {
        text: statementText,
        categorie: entityNaam,
        values: values
    };
}

function generateAdresSqlStatements(adressen) {
    let sqlStatements = [];

    if (!adressen) {
        return sqlStatements;
    }

    for (const adres of adressen) {
        let adresStatements = {
            stap: adres.id,
            statements: []
        };

        adresStatements.statements.push(createInsertIntoAdresStatement(adres.adres));

        sqlStatements.push(adresStatements);
    }

    return sqlStatements;
}

function generateAutorisatieSqlStatements(autorisaties) {
    let sqlStatements = [];

    if (!autorisaties) {
        return sqlStatements;
    }

    for (const autorisatie of autorisaties) {
        let autorisatieStatements = {
            stap: autorisatie.id,
            statements: []
        };

        autorisatieStatements.statements.push(createInsertAutorisatieIntoStatement(autorisatie.autorisatie));

        sqlStatements.push(autorisatieStatements);
    }

    return sqlStatements;
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function generatePersoonSqlStatements(persoon) {
    let persoonStatements = {
        stap: persoon.id,
        statements: []
    };

    for (const key of Object.keys(persoon)) {
        let statement;
        switch (key) {
            case 'id':
                break;
            case 'inschrijving':
                statement = createInsertIntoPersoonslijstStatement(persoon.inschrijving);
                break;
            default:
                for (const p of persoon[key]) {
                    persoonStatements.statements.push(createInsertIntoStatement(key, p));
                }
                break;
        }

        if (statement) {
            persoonStatements.statements.push(statement);
        }
    }
    return persoonStatements;
}

function generateSqlStatementsFrom(data) {
    if(!data) {
        globalThis.logger.warn('no data to generate sql statements');
        return undefined;
    }

    let sqlStatements = {
        personen: [],
        adressen: generateAdresSqlStatements(data.adressen),
        autorisaties: generateAutorisatieSqlStatements(data.autorisaties)
    };

    if (!data.personen) {
        return sqlStatements;
    }

    for (const persoon of data.personen) {
        if(getBsn(persoon) === undefined) {
            globalThis.logger.info('persoon zonder burgerservicenummer. Geen sql statements generatie', persoon);
        }
        else {
            sqlStatements.personen.push(generatePersoonSqlStatements(persoon));
        }
    }

    return sqlStatements;
}

module.exports = {
    generateSqlStatementsFrom
}