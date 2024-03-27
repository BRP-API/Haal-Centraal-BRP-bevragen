const { toDateOrString } = require('./brpDatum');

function createArrayFrom(dataTable, columnNameMap) {
    let retval = [];

    if(dataTable.raw()[0][0] === "naam") {
        dataTable.hashes().forEach(function(row) {
            const propertyName = columnNameMap.get(row.naam);

            if(row.waarde !== undefined && row.waarde !== '') {
                retval.push([ propertyName, toDateOrString(row.waarde, false) ]);
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
        retval.push([ columnNameMap.get(key), toDateOrString(hash[key], false) ]);
    });

    return retval;
}

module.exports = {
    createArrayFrom,
    fromHash
}
