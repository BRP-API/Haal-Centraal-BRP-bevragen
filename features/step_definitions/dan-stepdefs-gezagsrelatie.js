const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');
const { setObjectPropertiesFrom } = require('./dataTable2Object');
const { getBsn,
        getPersoon } = require('./contextHelpers');
const { createPersoonMetGezag, createGezag } = require('./gezagsrelatie');

Then(/^heeft de response een persoon met een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft de persoon ?(?:nog)? een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft ?(?:het)? 'gezag' ?(?:nog)? een '(\w*)' met de volgende gegevens$/, function (relatie, dataTable) {
    createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', relatie, dataTable);
});

Then(/^heeft de response een persoon zonder gezag$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'gezag');
});

Then(/^heeft de persoon geen gezag$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'gezag');
});

Then(/^heeft ?(?:het)? 'gezag' geen derden$/, function () {
    createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', 'derde');
});

function initExpected(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting = undefined) {
    context.verifyResponse = true;

    if(!context.expected) {
        context.expected = {
            personen: []
        };
    }

    const expectedPersoon = context.expected.personen.at(-1);
    if(!expectedPersoon) {
        context.expected.personen.push(createPersoonMetGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting));
    }
    else {
        expectedPersoon.gezag.push(createGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting));
    }
}

Then('(is )het gezag over {aanduiding} (is )eenhoofdig ouderlijk gezag met ouder {aanduiding}', function (aanduidingMinderjarige, aanduidingOuder) {
    initExpected(this.context, 'eenhoofdig ouderlijk gezag', aanduidingMinderjarige, aanduidingOuder);
});

Then('(is )het gezag over {aanduiding} (is )gezamenlijk gezag met ouder {aanduiding} en een onbekende derde', function (aanduidingMinderjarige, aanduidingOuder) {
    initExpected(this.context, 'gezamenlijk gezag', aanduidingMinderjarige, aanduidingOuder);
});

Then('(is )het gezag over {aanduiding} (is )gezamenlijk ouderlijk gezag met ouder {aanduiding} en ouder {aanduiding}', function (aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2) {
    initExpected(this.context, 'gezamenlijk ouderlijk gezag', aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2);
});

Then('(is )het gezag over {aanduiding} (is )gezamenlijk gezag met ouder {aanduiding} en derde {aanduiding}', function (aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2) {
    initExpected(this.context, 'gezamenlijk gezag', aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2);
});

Then('(is )het gezag over {aanduiding} (is )voogdij', function (aanduidingMinderjarige) {
    initExpected(this.context, 'voogdij', aanduidingMinderjarige);
});

Then('(is )het gezag over {aanduiding} (is )voogdij met derde {aanduiding}', function (aanduidingMinderjarige, aanduidingMeerderjarige) {
    initExpected(this.context, 'voogdij', aanduidingMinderjarige, aanduidingMeerderjarige);
});

Then('is het gezag over {aanduiding} tijdelijk geen gezag met de toelichting {toelichting}', function (aanduidingMinderjarige, toelichting) {
    initExpected(this.context, 'tijdelijk geen gezag', aanduidingMinderjarige, undefined, undefined, toelichting);
});

Then('is het gezag over {aanduiding} niet te bepalen met de toelichting {toelichting}', function (aanduidingMinderjarige, toelichting) {
    initExpected(this.context, 'niet te bepalen', aanduidingMinderjarige, undefined, undefined, toelichting);
});

function setGezagsrelatiePropertiesFrom(context, type, dataTable) {
    let expected = context.expected.personen.at(-1).gezag.at(-1);

    setObjectPropertiesFrom(expected[type], dataTable);
}

Then('heeft de minderjarige de volgende gegevens', function (dataTable) {
    setGezagsrelatiePropertiesFrom(this.context, 'minderjarige', dataTable);
});

Then('heeft de ouder de volgende gegevens', function (dataTable) {
    setGezagsrelatiePropertiesFrom(this.context, 'ouder', dataTable);
});

Then('heeft de derde de volgende gegevens', function (dataTable) {
    setGezagsrelatiePropertiesFrom(this.context, 'derde', dataTable);
});

function deleteGezagsrelatieProperty(context, type, property) {
    let expected = context.expected.personen.at(-1).gezag.at(-1);

    if(expected[type][property]) {
        delete expected[type][property];
    }
}

Then('heeft de minderjarige geen {word}', function (type, property) {
    deleteGezagsrelatieProperty(this.context, 'minderjarige', property);
});

Then('heeft de ouder geen {word}', function (type, property) {
    deleteGezagsrelatieProperty(this.context, 'ouder', property);
});

Then('heeft de derde geen {word}', function (type, property) {
    deleteGezagsrelatieProperty(this.context, 'derde', property);
});

Then('heeft {aanduiding} geen gezag(houder)', function (aanduidingMinderjarige) {
    this.context.verifyResponse = true;

    const expected = {
        personen: [
            {
                gezag: []
            }
        ]
    };

    if(this.context.isGezagApiAanroep) {
        expected.personen[0].burgerservicenummer = getBsn(getPersoon(this.context, aanduidingMinderjarige));
    }

    this.context.expected = expected;
});

Then('is het gezag in onderzoek', function () {
    this.context.expected.personen.at(-1).gezag.at(-1).inOnderzoek = "true";
});

Then('heeft {aanduiding} de volgende gezagsrelaties', function (aanduiding) {
    this.context.verifyResponse = true;

    if(!this.context.expected) {
        this.context.expected = {
            personen: []
        };
    }

    let persoon = {
        gezag: []
    }
    if(this.context.isGezagApiAanroep) {
        persoon.burgerservicenummer = getBsn(getPersoon(this.context, aanduiding));
    }
    this.context.expected.personen.push(persoon);
});
