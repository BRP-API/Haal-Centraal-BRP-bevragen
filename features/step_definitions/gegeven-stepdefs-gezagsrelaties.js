const { Given } = require('@cucumber/cucumber');

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
