const { Then } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { queryLastRow, queryRowCount } = require('./postgresqlHelpers');

Then(/^heeft de persoon met burgerservicenummer '(\d*)' de volgende 'protocollering' gegevens$/, async function (burgerservicenummer, dataTable) {
    this.context.verifyResponse = false;

    this.context.response.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, undefined, '\t')}`);

    const sqlData = dataTable.hashes()[0];

    const persoonSqlData = this.context.sqlData.find(s => s.persoon?.at(0).find(a => a[0] == 'burger_service_nr' && a[1] == burgerservicenummer));
    should.exist(persoonSqlData);

    const pl_id = Number(persoonSqlData['inschrijving'][0].find(e => e[0] === 'pl_id')[1]);
    should.exist(pl_id);

    const actual = await queryLastRow(global.pool, 'protocollering', 'request_datum', {pl_id: pl_id});

    should.exist(actual, `Geen 'protocollering' gegevens gevonden voor persoon met burgerservicenummer ${burgerservicenummer}`);

    Object.keys(sqlData).forEach(function(key) {
        actual[key].split(' ').should.have.members(sqlData[key].split(' '), `${actual[key]} !== ${sqlData[key]}`);
    });
});

Then(/^is voor de geauthenticeerde consumer '(\d*)' protocollering regels vastgelegd$/, async function (aantal) {
    this.context.verifyResponse = false;

    this.context.response.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, undefined, '\t')}`);

    const tabelNaam = 'protocollering';
    const afnemerId = this.context.afnemerId ?? this.context.oAuth?.clients[0].afnemerID;

    const actual = await queryRowCount(global.pool, tabelNaam, {afnemer_code: afnemerId})

    should.exist(actual);
    actual.should.equal(aantal);
});
