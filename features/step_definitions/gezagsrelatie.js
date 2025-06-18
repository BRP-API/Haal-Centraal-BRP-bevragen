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
    if((context.isAllApiScenario && context.isAllApiAanroep) || (context.isInfoApiScenario && context.isInfoApiAanroep)) {
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

module.exports = {
    createGezag,
    createPersoonMetGezag
};