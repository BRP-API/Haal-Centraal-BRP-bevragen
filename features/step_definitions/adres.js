const { createArrayFrom, fromHash } = require('./dataTable2Array');
const { columnNameMap } = require('./brp');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

function createAdres(context, adresId, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{ adres: {} }];
    }

    let sqlData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    if(sqlData === undefined) {
        sqlData = { adres: {} };
        context.sqlData.push(sqlData);
    }

    sqlData['adres'][adresId] = {
        index: Object.keys(sqlData['adres']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
}

function infrastructureelWijzigenAdres(context, sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    let sqlData = context.sqlData.find(el => el['adres'] !== undefined);

    const oudAdres = sqlData.adres[sourceAdresId];
    should.exist(oudAdres, `geen adres gevonden met id '${sourceAdresId}'`);
    const adresIndex = oudAdres.index;

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    if(targetAdresId === undefined) {
        targetAdresId = nieuwAdresIndex + 1 + '';
    }
    const nieuwAdresData = structuredClone(oudAdres.data);

    for (const elem of createArrayFrom(dataTable, columnNameMap)) {
        let foundElem = nieuwAdresData.find(el => el[0] === elem[0]);
        if(foundElem === undefined) {
            nieuwAdresData.push(elem);
        }
        else {
            foundElem[1] = elem[1];
        }
    }
    sqlData['adres'][targetAdresId] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    for (const elem of context.sqlData) {
        let verblijfplaats = elem['verblijfplaats']?.at(-1);
        if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
            for (const data of elem['verblijfplaats']) {
                let volgNr = data.find(el => el[0] === 'volg_nr');
                volgNr[1] = Number(volgNr[1]) + 1 + '';
            };

            let nieuwVerblijfplaatsData = structuredClone(elem['verblijfplaats'].at(-1));
            nieuwVerblijfplaatsData.find(el => el[0] === 'adres_id')[1] = nieuwAdresIndex + '';
            nieuwVerblijfplaatsData.find(el => el[0] === 'volg_nr')[1] = '0';
            nieuwVerblijfplaatsData.find(el => el[0] === 'adreshouding_start_datum')[1] = ingangsdatum.replaceAll('-', '');

            const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');
            if(nieuwGemeenteCode !== undefined) {
                nieuwVerblijfplaatsData.find(el => el[0] === 'inschrijving_gemeente_code')[1] = nieuwGemeenteCode[1];
            }

            nieuwVerblijfplaatsData.push(['aangifte_adreshouding_oms', 'W'])

            elem.verblijfplaats.push(nieuwVerblijfplaatsData);
        }
    }
}

function actualiseerAdres(context, adresId, ingangsdatum, dataTable) {
    let sqlData = context.sqlData.at(0);

    const oudAdres = sqlData.adres[adresId];
    should.exist(oudAdres, `geen adres gevonden met id '${adresId}'`);
    const adresIndex = oudAdres.index;

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    const nieuwAdresData = oudAdres.data.concat(createArrayFrom(dataTable, columnNameMap));
    sqlData['adres'][nieuwAdresIndex + 1 + ''] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');

    for (const elem of context.sqlData) {
        cloneActueleVerblijfplaats(elem, 'T', adresIndex, nieuwAdresIndex, nieuwGemeenteCode, ingangsdatum);
    }
}

function adressenSamenvoegen(context, sourceAdresIds, ingangsdatum, targetAdresId, dataTable) {
    let sqlData = context.sqlData;
    let adressenData = sqlData.at(0);

    const nieuwAdresIndex = Object.keys(adressenData['adres']).length;
    const nieuwAdresData = createArrayFrom(dataTable, columnNameMap);
    adressenData['adres'][targetAdresId] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');

    const adresIds = sourceAdresIds.split(',').map((item)=> item.trim());
    for (const adresId of adresIds) {
        const adresIndex = sqlData.at(0).adres[adresId]?.index;
        should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

        for (const elem of sqlData) {
            cloneActueleVerblijfplaats(elem, 'W', adresIndex, nieuwAdresIndex, nieuwGemeenteCode, ingangsdatum);
        }
    }
}

function cloneActueleVerblijfplaats(elem, omschrijvingAangifteAdreshouding, adresIndex, nieuwAdresIndex, nieuwGemeenteCode, ingangsdatum) {
    let verblijfplaats = elem['verblijfplaats']?.at(-1);
    if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
        for (const data of elem['verblijfplaats']) {
            let volgNr = data.find(el => el[0] === 'volg_nr');
            volgNr[1] = Number(volgNr[1]) + 1 + '';
        }

        let nieuwVerblijfplaatsData = [
            [ 'adres_id', nieuwAdresIndex + '' ],
            [ 'volg_nr', '0'],
            [ 'adres_functie', verblijfplaats.find(el => el[0] === 'adres_functie')[1]], // adres_functie overnemen
            [ 'adreshouding_start_datum', ingangsdatum.replaceAll('-', '')],
            [ 'aangifte_adreshouding_oms', omschrijvingAangifteAdreshouding ]
        ];
        if(nieuwGemeenteCode !== undefined) {
            nieuwVerblijfplaatsData.push([ 'inschrijving_gemeente_code', nieuwGemeenteCode[1] ]);
        }

        elem.verblijfplaats.push(nieuwVerblijfplaatsData);
    }
}

function splitsAdres(context, dataTable) {
    let sqlData = context.sqlData;
    let adressenData = sqlData.at(0);
    let adresIndex = Object.keys(adressenData).length;

    for (const adresData of dataTable.hashes()) {
        const adresId = adresData.adres;
        delete adresData.adres;

        adressenData['adres'][adresId] = {
            index: adresIndex,
            data: fromHash(adresData, columnNameMap)
        };

        adresIndex++;
    }
}

module.exports = {
    createAdres,
    infrastructureelWijzigenAdres,
    actualiseerAdres,
    adressenSamenvoegen,
    splitsAdres
}
