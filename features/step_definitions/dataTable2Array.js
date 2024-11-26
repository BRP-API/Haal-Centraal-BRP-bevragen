const { toDateOrString } = require('./brpDatum');

function createArrayFrom(dataTable, columnNameMap) {
    let retval = [];

    if(dataTable.raw()[0][0] === "naam") {
        dataTable.hashes().forEach(function(row) {
            if(row.naam !== 'pl_id') {
                const propertyName = columnNameMap.get(row.naam);

                if(row.waarde !== undefined && row.waarde !== '') {
                    retval.push([ propertyName, toDateOrString(row.waarde, false) ]);
                }
            }
        });
    }
    else {
        retval = fromHash(dataTable.hashes()[0], columnNameMap);
    }

    return retval;
}

function fromHash(hash, columnNameMap) {
    let retval = [];

    Object.keys(hash).forEach(function(key) {
        if(key !== 'pl_id') {
            retval.push([ columnNameMap.get(key), toDateOrString(hash[key], false) ]);
        }
    });

    return retval;
}

function getPlId(dataTable) {
    if(dataTable === undefined) {
        return undefined;
    }
    
    if(dataTable.raw()[0][0] === "naam") {
        return dataTable.hashes().find(row => row.naam === 'pl_id')?.waarde;
    }
    else {
        return dataTable.hashes()[0]['pl_id'];
    }
}

module.exports = {
    createArrayFrom,
    fromHash,
    getPlId
}
