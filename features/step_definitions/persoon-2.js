const { toDbColumnName, toDbPersoonType } = require('./brp');
const { mapDataTableToEntiteit} = require('./dataTableFactory');

function getNextStapelNr(entiteit, gegevensgroep) {
    let stapelNr = 0;

    Object.keys(entiteit).forEach(property => {
        if(property.startsWith(gegevensgroep)) {
            stapelNr += 1;
        }
    });

    return stapelNr + 1;
}

function createInschrijving() {
    return {
        geheim_ind: '0'
    }
}

function createPersoonType(persoonType, dataTable, stapelNr) {
    let persoon = {
        pl_id: 'null',
        stapel_nr: stapelNr + '',
        volg_nr: '0',
        persoon_type: toDbPersoonType(persoonType)
    };

    mapDataTableToEntiteit(persoon, dataTable);

    return persoon;
}

function createPersoon(context, aanduiding, dataTable) {
    if(!context.data) {
        context.data = {};
    }
    if(!context.data.personen) {
        context.data.personen = [];
    }

    let persoon = {
        inschrijving: createInschrijving(),
        persoon: [ createPersoonType('persoon', dataTable, 0) ]
    };

    persoon.id = !aanduiding
        ? `persoon-${context.data.personen.length + 1}`
        : `persoon-${aanduiding}`;

    context.data.personen.push(persoon);
}

function aanvullenPersoon(persoon, dataTable) {
    mapDataTableToEntiteit(persoon.persoon.at(-1), dataTable);
}

function aanvullenGezagsverhouding(persoon, dataTable) {
    if(!persoon.gezagsverhouding) {
        persoon.gezagsverhouding = [];
        createGezagsverhouding(persoon, null);
    }

    mapDataTableToEntiteit(persoon.gezagsverhouding.at(-1), dataTable);
}

function aanvullenInschrijving(persoon, dataTable) {
    if(!persoon.inschrijving) {
        persoon.inschrijving = createInschrijving();
    }

    mapDataTableToEntiteit(persoon.inschrijving, dataTable);
}

function wijzigPersoon(persoon, dataTable, isCorrectie = false) {
    persoon.persoon.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if(isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    persoon.persoon.push(createPersoonType('persoon', dataTable, 0));
}

function createKind(persoon, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'kind');

    persoon[`kind-${stapelNr}`] = [
        createPersoonType('kind', dataTable, stapelNr-1)
    ];
}

function createOuder(persoon, ouderType, dataTable) {
    const type = `ouder-${ouderType}`;
    if(!persoon[type]) {
        persoon[type] = [];
    }
    persoon[type].push(createPersoonType(type, dataTable, 0));
}

function wijzigOuder(persoon, ouderType, dataTable, isCorrectie = false) {
    const type = `ouder-${ouderType}`;

    persoon[type].forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if(isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    persoon[type].push(createPersoonType(type, dataTable, 0));
}

function createPartner(persoon, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'partner');

    persoon[`partner-${stapelNr}`] = [
        createPersoonType('partner', dataTable, stapelNr-1)
    ];
}

function wijzigPartner(persoon, dataTable) {
    const partnerData = createPersoonType('partner', dataTable, 0);

    let partner;
    Object.keys(persoon).forEach(property => {
        if (property.startsWith('partner') &&
            persoon[property].at(-1).burger_service_nr === partnerData.burger_service_nr) {
                partner = persoon[property];
        }
    })

    if(!partner) {
        global.logger.warn(`geen partner met bsn ${partnerData.burger_service_nr} gevonden`, persoon);
        return;
    }

    partner.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
    });

    partnerData.stapel_nr = partner.at(-1).stapel_nr;

    partner.push(partnerData);
}

function createGezagsverhouding(persoon, dataTable) {
    if(!persoon.gezagsverhouding) {
        persoon.gezagsverhouding = [];
    }

    let gezagsverhouding = {
        pl_id: 'null',
        volg_nr: '0'
    }

    mapDataTableToEntiteit(gezagsverhouding, dataTable);

    persoon.gezagsverhouding.push(gezagsverhouding);
}

function createVerblijfplaats(persoon, dataTable) {
    if(!persoon.verblijfplaats) {
        persoon.verblijfplaats = [];
    }

    let verblijfplaats = {
        pl_id: 'null',
        volg_nr: '0'
    };

    mapDataTableToEntiteit(verblijfplaats, dataTable);

    persoon.verblijfplaats.push(verblijfplaats);
}

function createOverlijden(persoon, dataTable) {
    if(!persoon.overlijden) {
        persoon.overlijden = [];
    }

    let overlijden = {
        pl_id: 'null',
        volg_nr: '0'
    };

    mapDataTableToEntiteit(overlijden, dataTable);

    persoon.overlijden.push(overlijden);
}

module.exports = {
    createPersoon,
    aanvullenPersoon,
    wijzigPersoon,
    createKind,
    createOuder,
    wijzigOuder,
    createPartner,
    wijzigPartner,
    createGezagsverhouding,
    aanvullenGezagsverhouding,
    createVerblijfplaats,
    createOverlijden,
    aanvullenInschrijving
}