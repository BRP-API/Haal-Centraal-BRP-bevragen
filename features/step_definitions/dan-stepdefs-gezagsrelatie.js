const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data.personen.at(-1)
        : context.data.personen.find(p => p.id === `persoon-${aanduiding}`);
}


function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function getGeslachtsnaam(persoon) {
    return persoon.persoon.at(-1).geslachts_naam;
}

function getVoornamen(persoon) {
    return persoon.persoon.at(-1).voor_naam;
}

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

function setProperty(obj, key, value) {
    if(value) {
        if(!obj) {
            obj = {};
        }
        obj[key] = value;
    }
}

function createGezagspersoon(context, aanduiding) {
    const persoon = getPersoon(context, aanduiding);

    let retval = {};

    setProperty(retval, 'burgerservicenummer', getBsn(persoon));

    if(!context.isDeprecatedScenario) {
        retval.naam = {};

        if(!context.isDataApiScenario) {
            setProperty(retval.naam, 'volledigeNaam', getGeslachtsnaam(persoon));
        }
        else {
            setProperty(retval.naam, 'voornamen', getVoornamen(persoon));
            setProperty(retval.naam, 'geslachtsnaam', getGeslachtsnaam(persoon));
        }
    }

    return retval;
}

function createDerde(context, aanduiding) {
    if(!aanduiding) {
        return { type: 'OnbekendeDerde' };
    }

    let retval = createGezagspersoon(context, aanduiding);
    retval.type = 'BekendeDerde';

    return retval;
}

function createPersoonMetGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting = undefined) {
    let gezag = {
        type: type,
        minderjarige: createGezagspersoon(context, aanduidingMinderjarige)
    };

    switch(type) {
        case 'gezamenlijk ouderlijk gezag':
            gezag.type = !context.isDeprecatedScenario
                ? 'GezamenlijkOuderlijkGezag'
                : 'TweehoofdigOuderlijkGezag';
            gezag.ouders = [
                createGezagspersoon(context, aanduidingMeerderjarige1),
                createGezagspersoon(context, aanduidingMeerderjarige2)
            ];
            break;
        case 'eenhoofdig ouderlijk gezag':
            gezag.type = 'EenhoofdigOuderlijkGezag';
            gezag.ouder = createGezagspersoon(context, aanduidingMeerderjarige1);
            break;
        case 'gezamenlijk gezag':
            gezag.type = 'GezamenlijkGezag';
            gezag.ouder = createGezagspersoon(context, aanduidingMeerderjarige1);
            gezag.derde = createDerde(context, aanduidingMeerderjarige2);
            break;
        case 'voogdij':
            gezag.type = 'Voogdij';
            gezag.derden =[];
            if(aanduidingMeerderjarige1) {
                gezag.derden.push(createDerde(context, aanduidingMeerderjarige1));
            }
            break;
        case 'tijdelijk geen gezag':
            gezag.type = 'TijdelijkGeenGezag';
            gezag.toelichting = toelichting;
            break;
        case 'niet te bepalen':
            gezag.type = 'GezagNietTeBepalen';
            gezag.toelichting = toelichting;
            break;
    }

    return {
        gezag: [gezag]
    };
}

Then(/^is het gezag over '(\w*)' (eenhoofdig ouderlijk gezag|gezamenlijk gezag) met ouder '(\w*)'(?: en een onbekende derde)?$/, function (aanduidingMinderjarige, type, aanduidingOuder) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' ${type} met ouder '${aanduidingOuder}'( en een onbekende derde)`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, type, aanduidingMinderjarige, aanduidingOuder) ]
    };

    this.context.expected = expected;
});

Then(/^is het gezag over '(\w*)' (gezamenlijk gezag|gezamenlijk ouderlijk gezag) met ouder '(\w*)' en (?:ouder|derde) '(\w*)'$/, function (aanduidingMinderjarige, type, aanduidingMeerderjarige1, aanduidingMeerderjarige2) {
    this.context.verifyResponse = true;

    const expected = {
        personen: [ createPersoonMetGezag(this.context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2) ]
    };

    this.context.expected = expected;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' ${type} met ouder '${aanduidingMeerderjarige1}' en derde '${aanduidingMeerderjarige2}'`, this.context.expected);
});
       
Then(/^is het gezag over '(\w*)' voogdij(?: met derde '(\w*)')?$/, function (aanduidingMinderjarige, aanduidingMeerderjarige) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' voogdij (met derde '${aanduidingMeerderjarige}')`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, 'voogdij', aanduidingMinderjarige, aanduidingMeerderjarige, undefined) ]
    };

    this.context.expected = expected;
});

Then(/^is het gezag over '(\w*)' (niet te bepalen|tijdelijk geen gezag) met de toelichting '([\w. ]*)'$/, function (aanduidingMinderjarige, type, toelichting) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' ${type} met de toelichting '${toelichting}'`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, type, aanduidingMinderjarige, undefined, undefined, toelichting) ]
    };

    this.context.expected = expected;
});
