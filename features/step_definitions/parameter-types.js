const { defineParameterType } = require('@cucumber/cucumber');
const { toDateOrString } = require('./brpDatum');

const DEFAULT_DATEPART = '00';
const DEFAULT_JAAR = '0000';
const ONBEKENDE_DATUM = `${DEFAULT_JAAR}${DEFAULT_DATEPART}${DEFAULT_DATEPART}`;

function formatDatePart(value, defaultValue = DEFAULT_DATEPART) {
    if (!value) return defaultValue;
    return value.length === 1 ? '0' + value : value;
}

function getJaar(jaar) {
    return formatDatePart(jaar, DEFAULT_JAAR);
}

function getMaand(maand) {
    const maanden = {
        januari: '01',
        februari: '02',
        maart: '03',
        april: '04',
        mei: '05',
        juni: '06',
        juli: '07',
        augustus: '08',
        september: '09',
        oktober: '10',
        november: '11',
        december: '12'
    };
    return maanden[maand] || DEFAULT_DATEPART;
}

function getDag(dag) {
    return formatDatePart(dag);
}

function defineDateParameterType(name, regexp, transformer) {
    defineParameterType({ name, regexp, transformer });
}

defineParameterType({
    name: 'aanduidingen',
    regexp: /'([a-zA-Z0-9À-ž-, ]*)'/,
    transformer(aanduidingen) {
        return aanduidingen.replace(' en ', ',').split(',').map(aanduiding => aanduiding.trim());
    }
});

defineParameterType({
    name: 'aanduiding',
    regexp: /'([a-zA-Z0-9À-ž-]*)'/
});

defineParameterType({
    name: 'onbekende datum',
    regexp: /(?:op )?(?:een )?onbekende datum/,
    transformer() {
        return ONBEKENDE_DATUM;
    }
});

defineDateParameterType(
    'dd-mm-yyyy datum',
    /(?:op )?(?:')?(\d{1,2})-(\d{1,2})-(\d{4})(?:')?/,
    (dag, maand, jaar) => jaar + formatDatePart(maand) + formatDatePart(dag)
);

defineDateParameterType(
    'dd maand yyyy datum',
    /(?:op )?(?:in )?'?(?:(\d{1,2}) )?(?:(januari|februari|maart|april|mei|juni|juli|augustus|september|oktober|november|december) )?(\d{4})'?/,
    (dag, maand, jaar) => getJaar(jaar) + getMaand(maand) + getDag(dag)
);

defineParameterType({
    name: 'vandaag, gisteren of morgen x jaar geleden',
    regexp: /(?:(gisteren|vandaag|morgen) )?(\d{1,2}) jaar geleden/,
    transformer(dag, aantalJaren) {
        return !dag
            ? toDateOrString(`vandaag - ${aantalJaren} jaar`, false)
            : toDateOrString(`${dag} - ${aantalJaren} jaar`, false);
    }
});

defineParameterType({
    name: 'vandaag, gisteren of morgen - x jaar',
    regexp: /(gisteren|vandaag|morgen) - (\d{1,2}) jaar/,
    transformer(dag, aantalJaren) {
        return toDateOrString(`${dag} - ${aantalJaren} jaar`, false);
    }
});

defineParameterType({
    name: 'deze-, vorige- of volgende maand - x jaar',
    regexp: /(deze|vorige|volgende) maand - (\d{1,2}) jaar/,
    transformer(maand, aantalJaren) {
        return toDateOrString(`${maand} maand - ${aantalJaren} jaar`, false);
    }
});

defineParameterType({
    name: 'dit-, vorig- of volgend jaar - x jaar',
    regexp: /(dit|vorig|volgend) jaar - (\d{1,2}) jaar/,
    transformer(jaar, aantalJaren) {
        return toDateOrString(`${jaar} jaar - ${aantalJaren} jaar`, false);
    }
});

defineParameterType({
    name: 'relatieve datum',
    regexp: /(gisteren|vandaag|morgen|deze maand|vorige maand|volgende maand)/
});

function jarigheidGeboorteDatum(omschrijvingLeeftijd) {
    const omschrijvingLeeftijdMap = new Map([
        ['minderjarige', 'gisteren - 17 jaar'],
        ['meerderjarige', 'gisteren - 45 jaar']
    ]);

    return omschrijvingLeeftijdMap.get(omschrijvingLeeftijd) || omschrijvingLeeftijd
}

defineParameterType({
    name: 'meer- of minderjarige',
    regexp: /(minderjarige|meerderjarige)/,
    transformer(omschrijvingLeeftijd) {
        return jarigheidGeboorteDatum(omschrijvingLeeftijd);
    }
});

function toGeslachtsaanduiding(omschrijvingGeslacht) {
    const geslachtMap = new Map([
        ['man', 'M'],
        ['vrouw', 'V']
    ]);

    return geslachtMap.get(omschrijvingGeslacht) || omschrijvingGeslacht;
}

defineParameterType({
    name: 'geslachtsaanduiding',
    regexp: /(?:(man|vrouw))?/,
    transformer(geslacht) {
        if(!geslacht) {
            return undefined;
        }
        return toGeslachtsaanduiding(geslacht);
    }
});

defineParameterType({
    name: 'erkenningstype',
    regexp: /(?:(bij geboorteaangifte|na geboorteaangifte|bij notariële akte|met gerechtelijke vaststelling ouderschap))?/,
    transformer(soortErkenning) {
        const erkenningsMap = {
            'bij geboorteaangifte': 'B',
            'na geboorteaangifte': 'C',
            'bij notariële akte': 'J',
            'met gerechtelijke vaststelling ouderschap': 'V'
        };
        return erkenningsMap[soortErkenning] || 'C';
    }
});

defineParameterType({
    name: 'tijdelijk geen gezag of niet te bepalen',
    regexp: /(tijdelijk geen gezag|niet te bepalen)/,
});

defineParameterType({
    name: 'toelichting',
    regexp: /'([a-zA-Z0-9À-ž /;:.\-?()]{1,400})'/
});

defineParameterType({
    name: 'soort verbintenis',
    regexp: /(gehuwd|een geregistreerd partnerschap aangegaan)/,
    transformer(soortRelatie) {
        return soortRelatie === 'gehuwd' ? 'H' : 'P';
    }
});
