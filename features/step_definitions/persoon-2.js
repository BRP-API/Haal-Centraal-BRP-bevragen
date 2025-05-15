const { toDbColumnName, toDbPersoonType } = require('./brp');
const { mapDataTableToEntiteit } = require('./dataTableFactory');

function getNextStapelNr(entiteit, gegevensgroep) {
    let stapelNr = 0;

    Object.keys(entiteit).forEach(property => {
        if (property.startsWith(gegevensgroep)) {
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

function createPersoonType(persoonType, dataTable, stapelNr, retainEmptyValues) {
    let persoon = {
        pl_id: 'null',
        stapel_nr: stapelNr + '',
        volg_nr: '0',
        persoon_type: toDbPersoonType(persoonType)
    };

    mapDataTableToEntiteit(persoon, dataTable, retainEmptyValues);

    if (!retainEmptyValues) {
        Object.keys(persoon).forEach(property => {
            if (!persoon[property]) {
                delete persoon[property];
            }
        });
    }

    return persoon;
}

function createPersoon(context, aanduiding, dataTable) {
    if (!context.data) {
        context.data = {};
    }
    if (!context.data.personen) {
        context.data.personen = [];
    }

    let persoon = {
        inschrijving: createInschrijving(),
        persoon: [createPersoonType('persoon', dataTable, 0)]
    };

    persoon.id = !aanduiding
        ? `persoon-${context.data.personen.length + 1}`
        : `persoon-${aanduiding}`;

    context.data.personen.push(persoon);
}

function aanvullenPersoon(persoon, dataTable) {
    mapDataTableToEntiteit(persoon.persoon.at(-1), dataTable);
}

function aanvullenPartner(persoon, dataTable) {
    mapDataTableToEntiteit(persoon.partner.at(-1), dataTable);
}

function aanvullenGezagsverhouding(persoon, dataTable) {
    if (!persoon.gezagsverhouding) {
        persoon.gezagsverhouding = [];
        createGezagsverhouding(persoon, null);
    }

    mapDataTableToEntiteit(persoon.gezagsverhouding.at(-1), dataTable);
}

function aanvullenInschrijving(persoon, dataTable) {
    if (!persoon.inschrijving) {
        persoon.inschrijving = createInschrijving();
    }

    mapDataTableToEntiteit(persoon.inschrijving, dataTable);
}

function wijzigPersoon(persoon, dataTable, isCorrectie = false) {
    persoon.persoon.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    persoon.persoon.push(createPersoonType('persoon', dataTable, 0));
}

function wijzigGeadopteerdPersoon(persoon, dataTable, isCorrectie = false) {
    persoon.persoon.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie) { // corrigeer voor alle inschrijvingen
            p.onjuist_ind = 'O';
        }
    });

    persoon.persoon.push(createPersoonType('persoon', dataTable, 0));
}

function createKind(persoon, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'kind');

    persoon[`kind-${stapelNr}`] = [
        createPersoonType('kind', dataTable, stapelNr - 1)
    ];
}

function createKindMetAanduiding(persoon, aanduiding, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'kind');

    persoon[`kind-${aanduiding}`] = [
        createPersoonType('kind', dataTable, stapelNr - 1)
    ];
}

function wijzigKind(persoon, dataTable, isCorrectie = false, kindBsn = null) {
    let kindData = createPersoonType('kind', dataTable, 0);
    
    let kind;
    
    Object.keys(persoon).forEach(property => {
        if (property.startsWith('kind')) {
            if (persoon[property][0].burger_service_nr === kindBsn || persoon[property].at(-1).burger_service_nr === kindData.burger_service_nr) {
               kind = persoon[property]
            }
        }
    });

    if (!kind) {
        // wanneer het kind niet gevonden wordt op burgerservicenummer, dan wordt het laatst opgevoerde kind (zonder burgerservicenummer) gezocht
        Object.keys(persoon).forEach(property => {
            if (property.startsWith('kind')) {
                if (!persoon[property].at(-1).burger_service_nr || !kindData.burger_service_nr) {
                    kind = persoon[property];
                }
            }
        });
    }

    if (!kind) {
        global.logger.warn(`geen kind met bsn ${kindData.burger_service_nr} gevonden`, persoon);
        return;
    }

    kindData.stapel_nr = kind.at(-1).stapel_nr;

    kind.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    Object.keys(kindData).forEach(property => {
        if (!kindData[property]) {
            delete kindData[property];
        }
    });

    kind.push(kindData);
}

function wijzigKindMetAanduiding(persoon, aanduiding, dataTable, isCorrectie = false) {
    const type = `kind-${aanduiding}`;
    let actueleKind = persoon[type].at(-1);
    const stapelnr = actueleKind.stapel_nr;

    if(isCorrectie) {
        actueleKind.onjuist_ind = 'O';
    }

    persoon[type].forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
    });

    persoon[type].push(createPersoonType('kind', dataTable, stapelnr));
}

function createOuder(persoon, ouderType, dataTable) {
    const type = `ouder-${ouderType}`;
    if (!persoon[type]) {
        persoon[type] = [];
    }
    persoon[type].push(createPersoonType(type, dataTable, 0));
}

function wijzigOuder(persoon, ouderType, dataTable, isCorrectie = false) {
    const type = `ouder-${ouderType}`;

    persoon[type].forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    persoon[type].push(createPersoonType(type, dataTable, 0));
}

function createPartner(persoon, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'partner');

    persoon[`partner-${stapelNr}`] = [
        createPersoonType('partner', dataTable, stapelNr - 1)
    ];
}

function createPartnerMetAanduiding(persoon, aanduiding, dataTable) {
    const stapelNr = getNextStapelNr(persoon, 'partner');

    persoon[`partner-${aanduiding}`] = [
        createPersoonType('partner', dataTable, stapelNr - 1)
    ];
}

/**
 * Wijzigt de partnergegevens van een persoon.
 * 
 * @param {object} persoon - Het persoon-object dat wordt aangepast.
 * @param {} dataTable - De partner-gegevens.
 * @param {boolean} [isCorrectie=false] - Geeft aan of de wijziging een correctie is. Standaardwaarde is `false`.
 * @param {boolean} [mergeProperties=false] - Voeg gegevens samen met bestaande waarden. Standaardwaarde is `false`.
 * @param {boolean} [retainEmptyValues=false] - Lege waarden behouden. Standaardwaarde is `false`.
 * @param {string} [partnerBsn=null] - Het burgerservicenummer (BSN) van de partner, te gebruiken bij correcties waarbij burgerservicenummer (01.20) niet voorkomt in de partner-gegevens. Standaardwaarde is `null`.
 * @returns {void}
 */
function wijzigPartner(persoon, dataTable, isCorrectie = false, mergeProperties = false, retainEmptyValues = false, partnerBsn = null) {
    let partnerData = createPersoonType('partner', dataTable, 0, retainEmptyValues);

    let partner;
    Object.keys(persoon).forEach(property => {
        if (property.startsWith('partner')) {
            if (persoon[property].at(-1).burger_service_nr === partnerBsn || persoon[property].at(-1).burger_service_nr === partnerData.burger_service_nr) {
                partner = persoon[property];
            }
        }
    });

    if (!partner) {
        Object.keys(persoon).forEach(property => {
            if (property.startsWith('partner')) {
                if (!persoon[property].at(-1).burger_service_nr || !partnerData.burger_service_nr) {
                    partner = persoon[property];
                }
            }
        });
    }

    if (!partner) {
        global.logger.warn(`geen partner met bsn ${partnerData.burger_service_nr} gevonden`, persoon);
        return;
    }

    if (mergeProperties) {
        let oldPartner = partner[0];
        let mergedPartner = { ...oldPartner, ...partnerData };
        partnerData = mergedPartner;
    }

    partnerData.stapel_nr = partner.at(-1).stapel_nr;

    partner.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    Object.keys(partnerData).forEach(property => {
        if (!partnerData[property]) {
            delete partnerData[property];
        }
    });

    partner.push(partnerData);
}

function wijzigPartnerMetAanduiding(persoon, aanduiding, dataTable, isCorrectie = false) {
    const type = `partner-${aanduiding}`;
    let actuelePartner = persoon[type].at(-1);
    const stapelnr = actuelePartner.stapel_nr;

    if(isCorrectie) {
        actuelePartner.onjuist_ind = 'O';
    }

    persoon[type].forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
    });

    persoon[type].push(createPersoonType('partner', dataTable, stapelnr));
}

function createGezagsverhouding(persoon, dataTable) {
    if (!persoon.gezagsverhouding) {
        persoon.gezagsverhouding = [];
    }

    let gezagsverhouding = {
        pl_id: 'null',
        volg_nr: '0'
    }

    mapDataTableToEntiteit(gezagsverhouding, dataTable);

    persoon.gezagsverhouding.push(gezagsverhouding);
}

function wijzigGezagsverhouding (persoon, dataTable, isCorrectie) {
    persoon.gezagsverhouding?.forEach(p => {
      p.volg_nr = Number(p.volg_nr) + 1 + '';
      if(isCorrectie && p.volg_nr === '1') {
          p.onjuist_ind = 'O';
      }
    });
  
    createGezagsverhouding(persoon, dataTable);
  };

function createVerblijfplaats(persoon, dataTable) {
    if (!persoon.verblijfplaats) {
        persoon.verblijfplaats = [];
    }

    let verblijfplaats = {
        pl_id: 'null',
        volg_nr: '0'
    };

    mapDataTableToEntiteit(verblijfplaats, dataTable);

    persoon.verblijfplaats.push(verblijfplaats);
}

function wijzigVerblijfplaats(persoon, dataTable, isCorrectie) {
    persoon.verblijfplaats?.forEach(p => {
        p.volg_nr = Number(p.volg_nr) + 1 + '';
        if (isCorrectie && p.volg_nr === '1') {
            p.onjuist_ind = 'O';
        }
    });

    createVerblijfplaats(persoon, dataTable);
}

function createOverlijden(persoon, dataTable) {
    if (!persoon.overlijden) {
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
    wijzigGeadopteerdPersoon,
    createKind,
    createKindMetAanduiding,
    wijzigKind,
    wijzigKindMetAanduiding,
    createOuder,
    wijzigOuder,
    createPartner,
    createPartnerMetAanduiding,
    wijzigPartner,
    wijzigPartnerMetAanduiding,
    createGezagsverhouding,
    wijzigGezagsverhouding,
    aanvullenGezagsverhouding,
    createVerblijfplaats,
    wijzigVerblijfplaats,
    createOverlijden,
    aanvullenInschrijving
}