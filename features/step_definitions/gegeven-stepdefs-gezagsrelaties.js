const { Given } = require('@cucumber/cucumber');
const { createObjectFrom } = require('./dataTable2Object');

Given(/^voor de persoon met burgerservicenummer '(\d*)' gelden de volgende gezagsrelaties$/, function (burgerservicenummer, dataTable) {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    this.context.gezag.push({
        burgerservicenummer: burgerservicenummer,
        gezagsrelaties: dataTable.hashes()
    });
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft geen gezagsrelaties$/, function (_) {
});

function getBsnFromCurrentPersoon(sqlData) {
    return sqlData.at(-1).persoon[0].find(p => p[0] === 'burger_service_nr')[1];
}

Given(/^voor de persoon geldt ?(?:ook)? het volgende gezag$/, function (dataTable) {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    const bsnCurrentPersoon = getBsnFromCurrentPersoon(this.context.sqlData);
    this.context.gezag.push({
        burgerservicenummer: bsnCurrentPersoon,
        gezag: [ createObjectFrom(dataTable) ]
    });
});

Given(/^voor de persoon geldt geen gezag$/, function () {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    const bsnCurrentPersoon = getBsnFromCurrentPersoon(this.context.sqlData);
    this.context.gezag.push({
        burgerservicenummer: bsnCurrentPersoon,
        gezag: []
    });
});

Given(/^het gezag heeft de volgende ouders$/, function(dataTable) {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.ouders = dataTable.hashes();
});

Given(/^het gezag heeft de volgende derden$/, function(dataTable) {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.derden = dataTable.hashes();
});

Given(/^het gezag heeft geen derden$/, function() {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.derden = [];
});
