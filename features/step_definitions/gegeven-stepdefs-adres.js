const { Given } = require('@cucumber/cucumber');
const { createAdres,
        infrastructureelWijzigenAdres,
        actualiseerAdres,
        adressenSamenvoegen,
        splitsAdres } = require('./adres');

Given(/^adres '([a-zA-Z0-9\-]*)' heeft de volgende gegevens$/, function (adresId, dataTable) {
    createAdres(this.context, adresId, dataTable);
});

Given(/^adres '(.*)' is op '(.*)' geactualiseerd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    actualiseerAdres(this.context, adresId, ingangsdatum, dataTable);
});

Given(/^(?:adres|de adressen) '(.*)' (?:is|zijn) op '(.*)' samengevoegd tot adres '(.*)' met de volgende gegevens$/, function (sourceAdresIds, ingangsdatum, targetAdresId, dataTable) {
    adressenSamenvoegen(this.context, sourceAdresIds, ingangsdatum, targetAdresId, dataTable);
});

Given(/^adres '(.*)' is gesplitst in adressen met de volgende gegevens$/, function (_, dataTable) {
    splitsAdres(this.context, dataTable);
});

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    infrastructureelWijzigenAdres(this.context, adresId, ingangsdatum, undefined, dataTable);
});

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd naar adres '(.*)' met de volgende gegevens$/, function(sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    infrastructureelWijzigenAdres(this.context, sourceAdresId, ingangsdatum, targetAdresId, dataTable);
});
