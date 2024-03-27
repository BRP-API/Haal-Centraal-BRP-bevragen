const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { createArrayFrom } = require('./dataTable2Array');
const { columnNameMap } = require('./brp');

function createGemeente(context, gemeenteId, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{ gemeente:{} }];
    }

    let sqlData = context.sqlData.find(e => Object.keys(e).includes('gemeente'));
    if(sqlData === undefined) {
        sqlData = { gemeente:{} };
        context.sqlData.push(sqlData);
    }

    sqlData['gemeente'][gemeenteId] = {
        index: Object.keys(sqlData['gemeente']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
}

function samenvoegenGemeente(context, gemeenteId, dataTable) {
    let gemeenteData = context.sqlData.find(el => el['gemeente'] !== undefined);

    const gemeente = gemeenteData.gemeente[gemeenteId];
    should.exist(gemeente, `geen gemeente gevonden met id '${gemeenteId}'`);

    gemeente.data = gemeente.data.concat(createArrayFrom(dataTable, columnNameMap));

    const oudGemeenteCode = gemeente.data.find(el => el[0] === 'gemeente_code')[1];
    const nieuweGemeenteCode = gemeente.data.find(el => el[0] === 'nieuwe_gemeente_code')[1];
    const ingangsdatum = gemeente.data.find(el => el[0] === 'tabel_regel_eind_datum')[1];

    let gewijzigdAdressenIds = [];
    context.sqlData.forEach(function(elem) {
        let adres = elem['adres'];
        if(adres !== undefined) {
            Object.keys(adres).forEach(function(adresId) {
                if(adres[adresId].data.find(el => el[0] === 'gemeente_code' && el[1] === oudGemeenteCode)) {
                    const nieuwAdresIndex = Object.keys(adres).length;
                    const nieuwAdresData = JSON.parse(JSON.stringify(adres[adresId].data));
                    nieuwAdresData.find(el => el[0] === 'gemeente_code')[1] = nieuweGemeenteCode;
                    adres[nieuwAdresIndex + 1 + ''] = {
                        index: nieuwAdresIndex,
                        data: nieuwAdresData
                    };

                    gewijzigdAdressenIds.push([adresId, nieuwAdresIndex + 1 + '']);
                }
            });
        }
    });

    const sqlDatas = context.sqlData;
    const adressen = context.sqlData.find(el => el['adres'] !== undefined);

    gewijzigdAdressenIds.forEach(function(elem) {
        const oudAdres = adressen.adres[elem[0]];
        const nieuwAdres = adressen.adres[elem[1]];

        sqlDatas.forEach(function(elem) {
            let verblijfplaats = elem['verblijfplaats']?.at(-1);
            if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === oudAdres.index + '') !== undefined) {
                elem['verblijfplaats'].forEach(function(data) {
                    let volgNr = data.find(el => el[0] === 'volg_nr');
                    volgNr[1] = Number(volgNr[1]) + 1 + '';
                });

                let nieuwVerblijfplaatsData = JSON.parse(JSON.stringify(elem['verblijfplaats'].at(-1)));
                nieuwVerblijfplaatsData.find(el => el[0] === 'adres_id')[1] = nieuwAdres.index + '';
                nieuwVerblijfplaatsData.find(el => el[0] === 'volg_nr')[1] = '0';
                nieuwVerblijfplaatsData.find(el => el[0] === 'inschrijving_gemeente_code')[1] = nieuweGemeenteCode + '';
                nieuwVerblijfplaatsData.find(el => el[0] === 'adreshouding_start_datum')[1] = ingangsdatum + '';
                nieuwVerblijfplaatsData.push(['aangifte_adreshouding_oms', 'W'])

                elem.verblijfplaats.push(nieuwVerblijfplaatsData);
            }
        });
    });
}

module.exports = {
    createGemeente,
    samenvoegenGemeente
}