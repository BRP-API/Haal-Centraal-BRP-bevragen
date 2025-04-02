const { createArrayFrom } = require('./dataTable2Array');
const { createPersoon } = require('./persoon');
const { columnNameMap } = require('./brp');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

function getAdresIndex(context, adresId) {
    if(adresId === undefined) {
        return undefined;
    }

    const adressenData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    return adresIndex;
}

function createVerblijfplaatsVoorkomenData(dataTable, adresIndex = undefined, isWoonadres = undefined) {
    let verblijfplaatsData = [];
    if(adresIndex !== undefined) {
        verblijfplaatsData.push(['adres_id', adresIndex + '' ]);
    }

    verblijfplaatsData.push([ 'volg_nr', '0' ]);

    if(isWoonadres !== undefined) {
        verblijfplaatsData.push([ 'adres_functie', isWoonadres ? 'W' : 'B' ]);
    }

    return verblijfplaatsData.concat(createArrayFrom(dataTable, columnNameMap))
}

function createVerblijfplaatsVoorkomen(sqlData, adresIndex, dataTable, isWoonadres, isCorrectie) {
    if(sqlData['verblijfplaats'] === undefined) {
        sqlData['verblijfplaats'] = [];
    }

    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0' && isCorrectie) {
            data.push(['onjuist_ind','O']);
            if(adresIndex === undefined) {
                adresIndex = data.find(el => el[0] === 'adres_id')[1];
            }
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    sqlData['verblijfplaats'].push(createVerblijfplaatsVoorkomenData(dataTable, adresIndex, isWoonadres));
}

function createPersoonMetWoonadres(context, burgerservicenummer, adresId, dataTable) {
    createPersoon(context, burgerservicenummer);
    createWoonadres(context, adresId, dataTable);
}

function createPersoonMetBriefadres(context, burgerservicenummer, adresId, dataTable) {
    createPersoon(context, burgerservicenummer);
    createBriefadres(context, adresId, dataTable);
}

function createPersoonMetVerblijfplaatsBuitenland(context, burgerservicenummer, dataTable) {
    createPersoon(context, burgerservicenummer);
    createVerblijfplaatsBuitenland(context, dataTable);
}

function createPersoonMetVerblijfplaats(context, burgerservicenummer, dataTable) {
    createPersoon(context, burgerservicenummer);

    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, undefined, dataTable, undefined, false);
}

function createWoonadres(context, adresId, dataTable, index=-1) {
    let sqlData = context.sqlData.at(index);

    createVerblijfplaatsVoorkomen(sqlData, getAdresIndex(context, adresId), dataTable, true, false);
}

function createBriefadres(context, adresId, dataTable) {
    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, getAdresIndex(context, adresId), dataTable, false, false);
}

function createVerblijfplaatsBuitenland(context, dataTable) {
    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, undefined, dataTable, undefined, false);
}

function createVerblijfplaats(context, dataTable) {
    createVerblijfplaatsBuitenland(context, dataTable);
}

function corrigeerVerblijfplaats(context, adresId, dataTable, isWoonadres) {
    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, getAdresIndex(context, adresId), dataTable, isWoonadres, true);
}

module.exports = { 
    createPersoonMetWoonadres,
    createPersoonMetBriefadres,
    createPersoonMetVerblijfplaats,
    createPersoonMetVerblijfplaatsBuitenland,
    createWoonadres,
    createBriefadres,
    createVerblijfplaatsBuitenland,
    createVerblijfplaats,
    corrigeerVerblijfplaats
}
