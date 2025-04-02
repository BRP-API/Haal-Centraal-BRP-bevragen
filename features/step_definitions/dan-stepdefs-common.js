const { Then } = require('@cucumber/cucumber');
const { createVelden,
        createCollectieObjecten } = require('./dataTable2ObjectFactory')

Then(/^heeft de response de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createVelden(this.context, dataTable);
});
        
Then(/^heeft de response (\d*) (\w*)$/, function (aantal, naamCollectieObject) {
    if(Number(aantal) === 0) {
        this.context.verifyResponse = true;

        createCollectieObjecten(this.context, naamCollectieObject);
    }
    else {
        this.context.verifyAantal = [
            {
                'naamColObj': naamCollectieObject,
                'naamSubColObj': undefined,
                'aantal': aantal
            }
        ];
    }
});

Then(/^heeft de response geen personen$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjecten(this.context, 'personen');
});
