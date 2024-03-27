const { Then } = require('@cucumber/cucumber');
const { createSubObjectVeldInObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

Then(/^heeft de 'verblijfplaats' de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createSubObjectVeldInObjectInLastCollectieObject(this.context, 'persoon', 'verblijfplaats', naamObjectProperty, dataTable);
});

Then(/^heeft de 'verblijfplaats' geen 'verblijfadres' gegevens$/, function () {
    createSubObjectVeldInObjectInLastCollectieObject(this.context, 'persoon', 'verblijfplaats', 'verblijfadres');
});
