const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');
const { setObjectPropertiesFrom } = require('./dataTable2Object');
const { getBsn,
        getGeslachtsaanduiding,
        getGeslachtsnaam,
        getVoornamen,
        getGeboortedatum,
        getPersoon } = require('./contextHelpers');

function getLeeftijd(persoon) {
    const geboortedatum = getGeboortedatum(persoon);
    const jaar = parseInt(geboortedatum.substring(0, 4), 10);
    const maand = parseInt(geboortedatum.substring(4, 6), 10) - 1; // 0-based in JavaScript
    const dag = parseInt(geboortedatum.substring(6, 8), 10);

    const vandaag = new Date();

    let leeftijd = vandaag.getFullYear() - jaar;
    if (vandaag.getMonth() < maand ||
        (vandaag.getMonth() === maand && vandaag.getDate() < dag)) {
        leeftijd--;
    }
    return leeftijd + '';
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

function setGezagRelatieProperties(persoon, retval, isMinderjarige) {
    retval.naam = {};

    setProperty(retval.naam, 'voornamen', getVoornamen(persoon));
    setProperty(retval.naam, 'geslachtsnaam', getGeslachtsnaam(persoon));
    const geslachtsaanduiding = getGeslachtsaanduiding(persoon);
    if(geslachtsaanduiding) {
        retval.geslacht = {};

        setProperty(retval.geslacht, 'code', geslachtsaanduiding);
    }

    if(isMinderjarige) {
        retval.geboorte = {};

        setProperty(retval.geboorte, 'datum', getGeboortedatum(persoon));
    }
}

function createGezagspersoon(context, aanduiding, isMinderjarige = false) {
    const persoon = getPersoon(context, aanduiding);

    let retval = {};

    setProperty(retval, 'burgerservicenummer', getBsn(persoon));

    global.logger.info(`isAllApiScenario: ${context.isAllApiScenario}, isInfoApiScenario: ${context.isInfoApiScenario}, isDataApiScenario: ${context.isDataApiScenario}, isGezagApiScenario: ${context.isGezagApiScenario}, isInfoApiAanroep: ${context.isInfoApiAanroep}, isDataApiAanroep: ${context.isDataApiAanroep}, isGezagApiAanroep: ${context.isGezagApiAanroep}`);
    if((context.isAllApiScenario || context.isInfoApiScenario) && context.isInfoApiAanroep) {
        retval.naam = {};

        setProperty(retval.naam, 'volledigeNaam', getGeslachtsnaam(persoon));

        if(isMinderjarige) {
            setProperty(retval, 'leeftijd', getLeeftijd(persoon));
        }
    }
    if((context.isAllApiScenario || context.isDataApiScenario) && context.isDataApiAanroep) {
        setGezagRelatieProperties(persoon, retval, isMinderjarige);
    }
    if((context.isAllApiScenario || context.isGezagApiScenario) && context.isGezagApiAanroep) {
        if(!context.isDeprecatedScenario) {
            setGezagRelatieProperties(persoon, retval, isMinderjarige);
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

function createGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting = undefined) {
    let gezag = {
        type: type,
        minderjarige: createGezagspersoon(context, aanduidingMinderjarige, true)
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

    return gezag;
}

function createPersoonMetGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting = undefined) {
    let retval = {
        gezag: []
    }
    if(context.isGezagApiAanroep) {
        retval.burgerservicenummer = getBsn(getPersoon(context, aanduidingMinderjarige));
    }
    retval.gezag.push(createGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting));

    return retval;
}

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

Then(/^(?:is )?het gezag over '([a-zA-Z0-9À-ž-]*)' (?:is )?(eenhoofdig ouderlijk gezag|gezamenlijk gezag) met ouder '([a-zA-Z0-9À-ž-]*)'(?: en een onbekende derde)?$/, function (aanduidingMinderjarige, type, aanduidingOuder) {
    initExpected(this.context, type, aanduidingMinderjarige, aanduidingOuder);
});

Then(/^(?:is )?het gezag over '([a-zA-Z0-9À-ž-]*)' (?:is )?(gezamenlijk gezag|gezamenlijk ouderlijk gezag) met ouder '([a-zA-Z0-9À-ž-]*)' en (?:ouder|derde) '([a-zA-Z0-9À-ž-]*)'$/, function (aanduidingMinderjarige, type, aanduidingMeerderjarige1, aanduidingMeerderjarige2) {
    initExpected(this.context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2);
});
       
Then(/^(?:is )?het gezag over '([a-zA-Z0-9À-ž-]*)' (?:is )?voogdij(?: met derde '([a-zA-Z0-9À-ž-]*)')?$/, function (aanduidingMinderjarige, aanduidingMeerderjarige) {
    initExpected(this.context, 'voogdij', aanduidingMinderjarige, aanduidingMeerderjarige);
});

Then('is het gezag over {aanduiding} {tijdelijk geen gezag of niet te bepalen} met de toelichting {toelichting}', function (aanduidingMinderjarige, type, toelichting) {
    initExpected(this.context, type, aanduidingMinderjarige, undefined, undefined, toelichting);
});

Then(/^heeft de (minderjarige|ouder|derde) de volgende gegevens$/, function (type, dataTable) {
    let expected = this.context.expected.personen.at(-1).gezag.at(-1);

    setObjectPropertiesFrom(expected[type], dataTable);
});

Then(/^heeft de (minderjarige|ouder|derde) geen (\w*)$/, function (type, property) {
    let expected = this.context.expected.personen.at(-1).gezag.at(-1);

    if(expected[type][property]) {
        delete expected[type][property];
    }
});

Then('heeft {aanduiding} geen gezaghouder', function (aanduidingMinderjarige) {
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
