const { Given, When, Then } = require('@cucumber/cucumber');
const { queryRowCount } = require('./postgresqlHelpers');
const { execute, select } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { assert } = require('chai');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { createObjectArrayFrom } = require('./dataTable2Object');


When(/^de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd$/, async function () {
    if(this.context.data) {
        const sqlStatements = generateSqlStatementsFrom(this.context.data);

        this.context.aantalRijen = {
            'lo3_pl': await queryRowCount(global.pool, 'inschrijving'),
            'lo3_pl_persoon': await queryRowCount(global.pool, 'persoon')
        }

        await execute(sqlStatements);

        for(const adres of sqlStatements.adressen) {
            let input = this.context.data.adressen.find(a => a.id === adres.stap);
            if(input) {
                input.adresId = adres.adresId;
            }
        }
        for(const persoon of sqlStatements.personen) {
            let input = this.context.data.personen.find(p => p.id === persoon.stap);
            if(input) {
                input.plId = persoon.plId;
            }
        }
    }
});

Then(/heeft ([a-z]*) '(.*)' de volgende rij(?:en)? in tabel '(.*)'/, async function(type, aanduiding, tabelNaam, dataTable) {
    const objecten = createObjectArrayFrom(dataTable);

    objecten.forEach(item => {
        if(item.adres_id) {
            const src = this.context.data.adressen.find(a => a.id === `adres-${item.adres_id}`);
            if(src) {
                item.adres_id = src.adresId;
            }
        }
        if(item.pl_id) {
            const src = this.context.data.personen.find(p => p.id === `persoon-${item.pl_id}`);
            if(src) {
                item.pl_id = src.plId;
            }
        }
    });

    const results = await select(tabelNaam, objecten);

    validateResult(results);
});

function validateResult(results) {
    results.forEach(item => {
        if (item.result.rows.length > 0) {
            assert.containsAllKeys(item.result.rows[0], Object.keys(item.row));
        } else {
            assert.fail(undefined, undefined, 'No matching records found!', item.row);
        }
    })
}

Then(/^zijn er geen rijen in tabel '([a-z0-9_]*)'$/, async function (tabelNaam) {
    const actual = await queryRowCount(global.pool, tabelNaam);

    should.exist(actual);
    actual.should.equal(this.context.aantalRijen[tabelNaam]);
});
