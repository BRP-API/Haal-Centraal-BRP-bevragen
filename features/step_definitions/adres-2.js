const { mapDataTableToEntiteit} = require('./dataTableFactory');

function createAdresType(dataTable) {
    let adres = {};

    mapDataTableToEntiteit(adres, dataTable);

    return adres;
}

function createAdres(context, aanduiding, dataTable) {
    if(!context.data) {
        context.data = {};
    }
    if(!context.data.adressen) {
        context.data.adressen = [];
    }

    const adres = {
        adres: createAdresType(dataTable),
        id: aanduiding
            ? `adres-${aanduiding}`
            : `adres-${context.data.adressen.length + 1}`
    }

    context.data.adressen.push(adres);
}

module.exports = {
    createAdres
}
