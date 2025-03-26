const { DataTable } = require('@cucumber/cucumber');
const { toDbColumnName } = require('./brp');
const { toDateOrString } = require('./brpDatum');

function cloneEntityToDataTableArray(arrayOfArrays, entiteit) {
    if(entiteit) {
        Object.keys(entiteit).forEach(key => {
            switch(key) {
                case 'pl_id':
                case 'stapel_nr':
                case 'volg_nr':
                case 'persoon_type':
                    // skip
                    break;
                default:
                    arrayOfArrays.push([key, entiteit[key]]);
                    break;
            }
        });
    }
}

function mapNaamWaardeDataTableToEntiteit(entiteit, dataTable, retainEmptyValues) {
    dataTable.hashes().forEach(hash => {
        if(retainEmptyValues || hash.waarde) {
            entiteit[toDbColumnName(hash.naam)] = toDateOrString(hash.waarde, false);
        }
        else {
            delete entiteit[toDbColumnName(hash.naam)];
        }
    });
}

function mapHashToEntiteit(entiteit, hash) {
    Object.keys(hash).forEach(naam => {
        if(hash[naam]) {
            entiteit[toDbColumnName(naam)] = toDateOrString(hash[naam], false);
        }
        else {
            delete entiteit[toDbColumnName(naam)];
        }
    });
}

function mapDataTableToEntiteit(entiteit, dataTable, retainEmptyValues) {
    if(!dataTable) {
        return;
    }

    if(dataTable.raw()[0][0] === 'naam') {
        mapNaamWaardeDataTableToEntiteit(entiteit, dataTable, retainEmptyValues);
    }
    else {
        const hash = dataTable.hashes()[0];
        mapHashToEntiteit(entiteit, hash);
    }
}

function mapDataTableToArrayOfArrays(arrayOfArrays, dataTable) {
    if(!dataTable) {
        return;
    }

    if(dataTable.raw()[0][0] === 'naam') {
        dataTable.hashes().forEach(hash => {
            arrayOfArrays.push([toDbColumnName(hash.naam), toDateOrString(hash.waarde, false)]);
        });
    }
    else {
        const hash = dataTable.hashes()[0];
        Object.keys(hash).forEach(naam => {
            arrayOfArrays.push([toDbColumnName(naam), toDateOrString(hash[naam], false)]);
        });
    }
}

function objectToDataTable(entiteit, dataTable) {
    let data = [
        ['naam', 'waarde']
    ];

    mapDataTableToEntiteit(entiteit, dataTable);

    cloneEntityToDataTableArray(data, entiteit);

    return new DataTable(data);
}

function arrayOfArraysToDataTable(arrayOfArrays, dataTable) {
    let data = [
        ['naam', 'waarde']
    ];

    arrayOfArrays.forEach(array => {
        data.push(array);
    })

    mapDataTableToArrayOfArrays(data, dataTable);

    return new DataTable(data);
}

module.exports = {
    objectToDataTable,
    arrayOfArraysToDataTable,
    mapDataTableToEntiteit
}
