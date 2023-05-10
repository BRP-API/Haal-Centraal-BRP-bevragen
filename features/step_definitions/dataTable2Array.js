const { toDateOrString } = require("./calcDate");

function getGbaPersoonType(persoonType) {
    switch(persoonType) {
        case 'persoon':
            return 'P';
        case 'kind':
            return 'K';
        case 'partner':
            return 'R';
        case '1':
            return '1';
        case '2':
            return '2';
        default:
            return undefined;
    }
}

function createCollectieDataFromArray(persoonType, data, stapelNr=0) {
    const gbaPersoonType = getGbaPersoonType(persoonType);

    return gbaPersoonType !== undefined
        ? [
            [ 'stapel_nr', stapelNr+''],
            [ 'volg_nr', '0'],
            [ 'persoon_type', gbaPersoonType]
          ].concat(data)
        : [
            [ 'stapel_nr', stapelNr+''],
            [ 'volg_nr', '0']
          ].concat(data);
}

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

function createVoorkomenDataFromArray(data) {
    return [
        [ 'volg_nr', '0']
    ].concat(data);
}

module.exports = { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray }
