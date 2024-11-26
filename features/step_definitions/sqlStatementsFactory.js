const { toDbTableName } = require('./brp');

function createInsertIntoPersoonslijstStatement(inschrijving) {
    const tableName = toDbTableName('inschrijving');

    let statementText = `INSERT INTO public.${tableName}(`;
    let values = [];

    statementText += 'pl_id';

    statementText += ',' + 'mutatie_dt';

    Object.keys(inschrijving).forEach(key => {
        statementText += ',' + key;
    });

    statementText += ') VALUES(';

    statementText += '(SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl)';

    statementText += ',' + 'current_timestamp';

    Object.keys(inschrijving).forEach((key,index) => {
        values.push(inschrijving[key]);
        statementText += ',' + `$${index+1}`;
    });

    statementText += ')';

    statementText += ' RETURNING *';

    return {
        text: statementText,
        categorie: 'inschrijving',
        values: values
    };
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

function generateSqlStatementsFrom(data) {
    if(!data) {
        global.logger.warn('no data to generate sql statements');
        return undefined;
    }

    let sqlStatements = {
        personen: []
    };

    data.personen.forEach(persoon => {
        let persoonStatements = {
            stap: persoon.id,
            statements: []
        };

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
    });

    return sqlStatements;
}

module.exports = {
    generateSqlStatementsFrom
}
