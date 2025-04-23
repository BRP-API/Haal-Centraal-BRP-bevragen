const { toDbTableName } = require('./brp');

function createAndReturnInsertedStatement(entityName, primaryKey, entity, additionalColumns = {}) {
    const tableName = toDbTableName(entityName);

    let statementText = `INSERT INTO public.${tableName}(`;
    let values = [];

    // Add primary key and additional columns
    statementText += primaryKey;
    Object.keys(additionalColumns).forEach(column => {
        statementText += `,${column}`;
    });

    // Add entity columns
    Object.keys(entity).forEach(key => {
        statementText += `,${key}`;
    });

    statementText += ') VALUES(';

    // Add primary key value
    statementText += `(SELECT COALESCE(MAX(${primaryKey}), 0)+1 FROM public.${tableName})`;

    // Add additional column values
    Object.values(additionalColumns).forEach(value => {
        statementText += `,${value}`;
    });

    // Add entity values
    Object.keys(entity).forEach((key, index) => {
        values.push(entity[key]);
        statementText += `,$${index + 1}`;
    });

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

    Object.keys(entity).forEach((key, index) => {
        statementText += index === 0
            ? key
            : `,${key}`;
    });

    statementText += ') VALUES(';

    Object.keys(entity).forEach((key, index) => {
        values.push(entity[key]);

        statementText += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });

    statementText += ')';

    return {
        text: statementText,
        categorie: entityNaam,
        values: values
    };
}

function generateAdresSqlStatements(adressen) {
    let sqlStatements = [];

    adressen?.forEach(adres => {
        let adresStatements = {
            stap: adres.id,
            statements: []
        };

        adresStatements.statements.push(createInsertIntoAdresStatement(adres.adres));

        sqlStatements.push(adresStatements);
    });

    return sqlStatements;
}

function generateAutorisatieSqlStatements(autorisaties) {
    let sqlStatements = [];

    autorisaties?.forEach(autorisatie => {
        let autorisatieStatements = {
            stap: autorisatie.id,
            statements: []
        };

        autorisatieStatements.statements.push(createInsertAutorisatieIntoStatement(autorisatie.autorisatie));

        sqlStatements.push(autorisatieStatements);
    });

    return sqlStatements;
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function generateSqlStatementsFrom(data) {
    if(!data) {
        global.logger.warn('no data to generate sql statements');
        return undefined;
    }

    let sqlStatements = {
        personen: [],
        adressen: generateAdresSqlStatements(data.adressen),
        autorisaties: generateAutorisatieSqlStatements(data.autorisaties)
    };

    data.personen?.forEach(persoon => {
        let persoonStatements = {
            stap: persoon.id,
            statements: []
        };

        if(getBsn(persoon) === undefined) {
            global.logger.info('persoon zonder burgerservicenummer. Geen sql statements generatie', persoon);
        }
        else {
            Object.keys(persoon).forEach(key => {
                let statement;
                switch(key) {
                    case 'id':
                        break;
                    case 'inschrijving':
                        statement = createInsertIntoPersoonslijstStatement(persoon.inschrijving);
                        break;
                    default:
                        persoon[key].forEach(p => {
                            persoonStatements.statements.push(createInsertIntoStatement(key, p));
                        });
                        break;
                }

                if(statement) {
                    persoonStatements.statements.push(statement);
                }
            });

            sqlStatements.personen.push(persoonStatements);
        }
    });

    return sqlStatements;
}

module.exports = {
    generateSqlStatementsFrom
}
