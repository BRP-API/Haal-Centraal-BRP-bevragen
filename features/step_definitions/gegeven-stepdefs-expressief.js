const { Given, DataTable } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('./dataTableFactory');
const { createPersoon,
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
        wijzigVerblijfplaats,
        aanvullenInschrijving,
        createOverlijden
} = require('./persoon-2');
const { createAdres } = require('./adres-2');
const { toDbColumnName } = require('./brp');

const { toDateOrString, toBRPDate } = require('./brpDatum');

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data.personen.at(-1)
        : context.data.personen.find(p => p.id === `persoon-${aanduiding}`);
}

function getAdres(context, aanduiding) {
    return !aanduiding
        ? context.data.adressen.at(-1)
        : context.data.adressen.find(a => a.id === `adres-${aanduiding}`);
}

function getAdresIndex(context, aanduiding) {
    return context.data.adressen.findIndex(a => a.id === `adres-${aanduiding}`);
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function getGeslachtsnaam(persoon) {
    return persoon.persoon.at(-1).geslachts_naam;
}

function getGeboortedatum(persoon) {
    return persoon.persoon.at(-1).geboorte_datum;
}

function deleteHuwelijkProperties(entiteit) {
    delete entiteit.relatie_start_datum;
    delete entiteit.relatie_start_plaats;
    delete entiteit.relatie_start_land_code;
}

function getPartnerActueleGegevens(persoon, bsnPartner) {
    let partner;

    Object.keys(persoon).forEach(property => {
        if (property.includes('partner') &&
            persoon[property].at(-1).burger_service_nr === bsnPartner) {
            partner = persoon[property].at(-1);
        }
    });

    return partner;
}

function getPartner(persoon) {
    let partner;

    Object.keys(persoon).forEach(property => {
        if (property.includes('partner')) {
            partner = persoon[property].at(-1);
        }
    });

    return partner;
}

function createOntbindingPartnerschap(context, aanduiding, dataTable) {
    let overledenPersoon = getPersoon(context, aanduiding);

    Object.keys(overledenPersoon).some(property => {
        if (property.includes('partner')) {
            const partner = { ...getPartner(overledenPersoon) };
            if(partner.relatie_start_datum) {
                const partnerPersoon = getPersoon(context, partner.geslachts_naam);
                wijzigPartner(partnerPersoon, dataTable);
                return true;
            }
        }
        return false;
    });
}

/**
 * Expressieve Gegeven-stappen voor Persoon
 */

function dataTableHasColumn(dataTable, columnName) {
    return dataTable?.raw()[0].includes(columnName);
}


function gegevenDePersoonMetBsn(context, aanduiding, burgerservicenummer, dataTable) {
    const data = [];

    if (burgerservicenummer) {
        data.push(['burgerservicenummer (01.20)', burgerservicenummer]);
    }
    if (aanduiding && !dataTableHasColumn(dataTable, 'geslachtsnaam (02.40)')) {
        data.push(['geslachtsnaam (02.40)', aanduiding]);
    }

    createPersoon(
        context,
        aanduiding,
        arrayOfArraysToDataTable(data, dataTable)
    );
}

Given(/^(?:de )?persoon '([a-zA-Z0-9]*)'$/, function (aanduiding, dataTable) {
    gegevenDePersoonMetBsn(this.context, aanduiding, undefined, dataTable);

    global.logger.info(`gegeven persoon '${aanduiding}'`, getPersoon(this.context, aanduiding));
});

Given(/^(?:de persoon(?: '(.*)')? )?met burgerservicenummer '(\d*)'$/, function (aanduiding, burgerservicenummer) {
    gegevenDePersoonMetBsn(this.context, aanduiding, burgerservicenummer, undefined);
});

Given(/^adres '([a-zA-Z0-9]*)'$/, function (aanduiding, dataTable) {
    createAdres(this.context, aanduiding, dataTable);

    global.logger.info(`gegeven adres '${aanduiding}'`, getAdres(this.context, aanduiding));
});

function getJaar(jaar) {
    if(!jaar) {
        return '0000';
    }
    return jaar;
}

function getMaand(maand) {
    switch(maand) {
        case 'januari':
            return '01';
        case 'februari':
            return '02';
        case 'maart':
            return '03';
        case 'april':
            return '04';
        case 'mei':
            return '05';
        case 'juni':
            return '06';
        case 'juli':
            return '07';
        case 'augustus':
            return '08';
        case 'september':
            return '09';
        case 'oktober':
            return '10';
        case 'november':
            return '11';
        case 'december':
            return '12';
        default:
            return '00';
    }
}

function getDag(dag) {
    if(!dag) {
        return '00';
    }
    else if (dag.length === 1) {
        return '0' + dag;
    }

    return dag;
}

function gegevenPersonenZijnIngeschrevenOpAdres(context, aanduidingAdres, aanduidingPersoon, datumAanvangAdreshouding) {
    const data = [
        ['adres_id', getAdresIndex(context, aanduidingAdres) + ''],
        ['functie adres (10.10)', 'W'],
        ['datum aanvang adreshouding (10.30)', datumAanvangAdreshouding]
    ];

    createVerblijfplaats(getPersoon(context, aanduidingPersoon),
                         arrayOfArraysToDataTable(data));
}

Given(/^(?:persoon |personen )?'([a-zA-Z0-9, ]*)' (?:is|zijn) ingeschreven op adres '([a-zA-Z0-9]*)' op '(?:(\d{1,2}) )?(?:(januari|februari|maart|april|mei|juni|juli|augustus|september|oktober|november|december) )?(\d{4})'$/, function (persoonAanduidingen, adresAanduiding, dag, maand, jaar) {
    const aanduidingen = persoonAanduidingen.replace(' en ', ',').split(',').map(aanduiding => aanduiding.trim());
    for(const persoonAanduiding of aanduidingen) {
        gegevenPersonenZijnIngeschrevenOpAdres(this.context, adresAanduiding, persoonAanduiding, getJaar(jaar) + getMaand(maand) + getDag(dag));
    }

    global.logger.info(`gegeven persoon|personen '${persoonAanduidingen}' is|zijn ingeschreven op adres '${adresAanduiding}' op '${dag} ${maand} ${jaar}'`, getPersoon(this.context, aanduidingen[0]));
});

Given(/^(?:persoon |personen )?'([a-zA-Z0-9, ]*)' (?:is|zijn) ingeschreven op adres '([a-zA-Z0-9]*)' op een onbekende datum$/, function (persoonAanduidingen, adresAanduiding) {
    const aanduidingen = persoonAanduidingen.replace(' en ', ',').split(',').map(aanduiding => aanduiding.trim());
    for(const persoonAanduiding of aanduidingen) {
        gegevenPersonenZijnIngeschrevenOpAdres(this.context, adresAanduiding, persoonAanduiding, '00000000');
    }

    global.logger.info(`gegeven persoon|personen '${persoonAanduidingen}' is|zijn ingeschreven op adres '${adresAanduiding}' op een onbekende datum`, getPersoon(this.context, aanduidingen[0]));
});

Given(/^(?:persoon |personen )?'([a-zA-Z0-9, ]*)' (?:is|zijn) (?:(gisteren|vandaag|morgen) )?(\d*) jaar geleden ingeschreven op adres '([a-zA-Z0-9]*)'$/, function (persoonAanduidingen, dag, aantalJaren, adresAanduiding) {
    const date = !dag
        ? toDateOrString(`vandaag - ${aantalJaren} jaar`, false)
        : toDateOrString(`${dag} - ${aantalJaren} jaar`, false);

    const aanduidingen = persoonAanduidingen.replace(' en ', ',').split(',').map(aanduiding => aanduiding.trim());
    for(const persoonAanduiding of aanduidingen) {
        gegevenPersonenZijnIngeschrevenOpAdres(this.context, adresAanduiding, persoonAanduiding, date);
    }

    global.logger.info(`gegeven persoon|personen '${persoonAanduidingen}' is|zijn ${dag} ${aantalJaren} jaar geleden ingeschreven op adres '${adresAanduiding}'`, getPersoon(this.context, aanduidingen[0]));
});

Given(/^heeft de volgende persoon zonder burgerservicenummer als ouder ([1-2])$/, function (ouderType, dataTable) {
    createOuder(
        getPersoon(this.context, undefined),
        ouderType,
        dataTable
    );

    global.logger.info(`heeft de volgende persoon zonder burgerservicenummer als ouder ${ouderType}`, getPersoon(this.context, undefined));
});

Given(/^is minderjarig/, function () {
    const datumGeboorte = 'gisteren - 17 jaar';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );
});

Given(/^is meerderjarig(?:, niet overleden en staat niet onder curatele)?$/, function () {
    const datumGeboorte = 'gisteren - 45 jaar';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', datumGeboorte]
        ])
    );
});

Given(/^is in Nederland geboren$/, function () {
    const landGeboorte = '6030';
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );
});

Given(/^is in het buitenland geboren$/, function () {
    const landGeboorte = '9999'; // any code except 6030
    const nummerAkte = '1AA0100';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', landGeboorte],
            ['aktenummer (81.20)', nummerAkte]
        ])
    );
});

Given(/^voor '(.*)' is een gerechtelijke uitspraak over het gezag gedaan met de volgende gegevens$/, function (aanduiding, dataTable) {
    createGezagsverhouding(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});

Given(/^'(.*)' is onder curatele gesteld$/, function (aanduiding) {
    const curateleRegisterIndicatie = '1';

    aanvullenGezagsverhouding(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['indicatie curateleregister (33.10)', curateleRegisterIndicatie]
        ])
    );
});

Given(/^is onder curatele gesteld/, function () {
    const curateleRegisterIndicatie = '1';

    aanvullenGezagsverhouding(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['indicatie curateleregister (33.10)', curateleRegisterIndicatie]
        ])
    );
});

Given(/^(?:'(.*)' )?is overleden$/, function (aanduiding) {
    const datumOpschortingBijhouding = 'gisteren - 2 jaar';
    const redenOpschortingBijhouding = 'O';
    const datumOverlijden = 'gisteren - 2 jaar';
    const gemeenteCode = '0518';
    const landCode = '6030';

    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouding],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );

    createOverlijden(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum overlijden (08.10)', datumOverlijden]
        ])
    );

    createOntbindingPartnerschap(this.context, aanduiding,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(this.context, aanduiding))],
            ['geslachtsnaam (02.40)', aanduiding],
            ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datumOverlijden],
            ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', gemeenteCode],
            ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landCode],
            ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', redenOpschortingBijhouding]
        ])
    );
});

Given(/^'(.*)' is overleden met de volgende gegevens$/, function (aanduiding, dataTable) {
    const datumOpschortingBijhouden = 'gisteren - 2 jaar';
    const redenOpschortingBijhouding = 'O';

    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        arrayOfArraysToDataTable([
            ['datum opschorting bijhouding (67.10)', datumOpschortingBijhouden],
            ['reden opschorting bijhouding (67.20)', redenOpschortingBijhouding]
        ])
    );

    createOverlijden(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});


Given(/^bijhouding van de persoonsgegevens van '(.*)' is opgeschort met de volgende gegevens$/, function (aanduiding, dataTable) {
    aanvullenInschrijving(
        getPersoon(this.context, aanduiding),
        dataTable
    );
});

Given(/^heeft de volgende gegevens$/, function (dataTable) {
    aanvullenPersoon(
        getPersoon(this.context, undefined),
        dataTable
    );
});

Given(/^zijn de volgende gegevens gewijzigd$/, function (dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const persoonData = { ...persoon[`persoon`].at(-1) };

    wijzigPersoon(
        persoon,
        objectToDataTable(persoonData, dataTable)
    );
});

Given(/^zijn de volgende gegevens gecorrigeerd$/, function (dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const persoonData = { ...persoon[`persoon`].at(-1) };

    wijzigPersoon(
        persoon,
        objectToDataTable(persoonData, dataTable),
        true
    );
});

/**
 * Expressieve Gegeven-stappen voor Partner
 */

function gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, dataTable) {
    createPartner(
        getPersoon(context, aanduiding1),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding2))],
            ['geslachtsnaam (02.40)', aanduiding2]
        ], dataTable)
    );

    createPartner(
        getPersoon(context, aanduiding2),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding1))],
            ['geslachtsnaam (02.40)', aanduiding1]
        ], dataTable)
    );
}

function gegevenDePersonenZijnGehuwdGecorrigeerd(context, aanduiding1, aanduiding2, dataTable) {
    wijzigPartner(
        getPersoon(context, aanduiding1),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding2))],
            ['geslachtsnaam (02.40)', aanduiding2]
        ], dataTable),
        true,
        true
    );

    wijzigPartner(
        getPersoon(context, aanduiding2),
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(getPersoon(context, aanduiding1))],
            ['geslachtsnaam (02.40)', aanduiding1]
        ], dataTable),
        true,
        true
    );
}

Given(/^'(.*)' en '(.*)' zijn met elkaar gehuwd$/, function (aanduiding1, aanduiding2) {
    const datumHuwelijk = 'gisteren - 20 jaar';
    const plaatsHuwelijk = '0518';
    const landHuwelijk = '6030';

    const huwelijkData = arrayOfArraysToDataTable([
        ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', datumHuwelijk],
        ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', plaatsHuwelijk],
        ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', landHuwelijk],
    ]);

    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, huwelijkData);
});

Given(/^'(.*)' en '(.*)' zijn met elkaar gehuwd met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGehuwd(this.context, aanduiding1, aanduiding2, dataTable);
});

Given(/^beide ouders zijn nooit met elkaar getrouwd geweest en hebben nooit een geregistreerd partnerschap gehad$/, function () {
    // doe niets
});

function gegevenDePersonenZijnGescheiden(context, aanduiding1, aanduiding2, dataTable) {
    const persoon1 = getPersoon(context, aanduiding1);
    const persoon2 = getPersoon(context, aanduiding2);

    const partner1 = { ...getPartnerActueleGegevens(persoon1, getBsn(persoon2)) };
    deleteHuwelijkProperties(partner1);

    wijzigPartner(
        persoon1,
        objectToDataTable(partner1, dataTable)
    );

    const partner2 = { ...getPartnerActueleGegevens(persoon2, getBsn(persoon1)) };
    deleteHuwelijkProperties(partner2);

    wijzigPartner(
        persoon2,
        objectToDataTable(partner2, dataTable)
    );
}

Given(/^'(.*)' en '(.*)' zijn gescheiden$/, function (aanduiding1, aanduiding2) {
    const datumScheiding = 'gisteren - 1 jaar';
    const plaatsScheiding = '0518';
    const landScheiding = '6030';

    const scheidingData = arrayOfArraysToDataTable([
        ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', datumScheiding],
        ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', plaatsScheiding],
        ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', landScheiding],
    ])

    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, scheidingData);
});

Given(/^'(.*)' en '(.*)' zijn gescheiden met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGescheiden(this.context, aanduiding1, aanduiding2, dataTable);
});

Given(/^is het huwelijk van '(.*)' en '(.*)' gecorrigeerd met de volgende gegevens$/, function (aanduiding1, aanduiding2, dataTable) {
    gegevenDePersonenZijnGehuwdGecorrigeerd(this.context, aanduiding1, aanduiding2, dataTable);
});

/**
 * Expressieve Gegeven-stappen voor Ouder
 */

function gegevenHeeftPersoonAlsOuder(context, aanduiding, ouderType, dataTable) {
    const kind = getPersoon(context, undefined);
    const ouder = getPersoon(context, aanduiding);

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)]
        ], dataTable)
    );

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)]
        ])
    )
}

Given(/^heeft '(.*)' als ouder ([1-2])$/, function (aanduiding, ouderType) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'gisteren - 17 jaar']
    ]);

    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, ouderData);
});

Given(/^heeft '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduiding, ouderType, dataTable) {
    gegevenHeeftPersoonAlsOuder(this.context, aanduiding, ouderType, dataTable);
});

function gegevenIsGeadopteerdDoorPersoonAlsOuder(context, aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    const kind = getPersoon(context, aanduidingKind);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable);
}

function gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable) {
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = '1AQ0100'

    wijzigPersoon(
        kind,
        objectToDataTable(kindData),
        true
    );

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)]
        ], dataTable)
    );

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
        ])
    )
}

Given(/^is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, undefined);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'morgen - 4 jaar']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});


Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingKind, aanduidingOuder, ouderType) {
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'morgen - 4 jaar']
    ]);

    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder, ouderType, dataTable);
});

Given(/^is niet in Nederland geadopteerd$/, function () {
    // doe niets
});

Given(/^zijn van ouder ([1-2]) de volgende gegevens gewijzigd$/, function (ouderType, dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const ouderData = { ...persoon[`ouder-${ouderType}`].at(-1) };

    wijzigOuder(
        persoon,
        ouderType,
        objectToDataTable(ouderData, dataTable),
        false
    );
});

Given(/^zijn van ouder ([1-2]) de volgende gegevens gecorrigeerd$/, function (ouderType, dataTable) {
    const persoon = getPersoon(this.context, undefined);

    const ouderData = { ...persoon[`ouder-${ouderType}`].at(-1) };

    wijzigOuder(
        persoon,
        ouderType,
        objectToDataTable(ouderData, dataTable),
        true
    );
});

Given(/^beide ouders zijn meerderjarig, niet overleden en staan niet onder curatele$/, function () {
    // doe niets
});

/**
 * Expressieve Gegeven-stappen voor Verblijfplaats
 */

function gegevenPersoonIsIngeschrevenInGemeente(context, aanduiding, dataTable) {
    createVerblijfplaats(
        getPersoon(context, aanduiding),
        dataTable
    );
}

Given(/^is ingeschreven in de BRP$/, function () {
    gegevenPersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '0518']
        ])
    );
});

Given(/^is niet ingeschreven in de BRP$/, function () {
    gegevenPersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '1999']
        ])
    );
});

Given(/^is ingeschreven in de BRP met de volgende gegevens$/, function (dataTable) {
    gegevenPersoonIsIngeschrevenInGemeente(this.context, undefined, dataTable);
});

Given(/^is ingeschreven in de RNI$/, function () {
    gegevenPersoonIsIngeschrevenInGemeente(
        this.context,
        undefined,
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '1999']
        ])
    );
});

Given(/^is ingeschreven in de RNI met de volgende gegevens$/, function (dataTable) {
    gegevenPersoonIsIngeschrevenInGemeente(this.context, undefined, dataTable);
});

Given(/^(?:de persoon(?: '(.*)')? )?is niet geëmigreerd geweest$/, function (_) {
    // doe niets
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest met de volgende gegevens?$/, function (_, dataTable) {
    createVerblijfplaats(this.context, dataTable);
});

Given(/^(?:de persoon(?: '(.*)')? )?is geëmigreerd geweest?$/, function (_) {
    const datumVestiging = 'vandaag - 1 jaar';
    const gemeenteVanInschrijving = '0518';

    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['datum vestiging in Nederland (14.20)', datumVestiging],
            ['gemeente van inschrijving (09.10)', gemeenteVanInschrijving]
        ]),
        false
    );
});

Given(/^heeft een onbekende verblijfplaats$/, function () {
    const persoon = getPersoon(this.context, undefined);
    const verblijfplaats = persoon.verblijfplaats;

    if(verblijfplaats) {
        wijzigVerblijfplaats(
            getPersoon(this.context, undefined),
            undefined,
            false
        );
    } else {
        // Verblijfplaats is al onbekend
    }
});

Given(/^heeft een onbekende gemeente van inschrijving$/, function () {
    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['gemeente van inschrijving (09.10)', '']
        ]),
        false
    );
});

/**
 * Op dit moment wordt standaard landcode 6014 gebruikt.
 * Deze gegeven stap is voor testen waar het niet relevant naar welk land de persoon is geëmigreerd,
 * alleen dat de persoon is geëmigreerd.
 */
Given(/^is geëmigreerd naar het buitenland/, function () {
    const verblijfplaats = arrayOfArraysToDataTable([
        ['land vanwaar ingeschreven (14.10)', '6014'],
        ['datum aanvang adres buitenland (13.20)', '01012023'],
        ['datum vestiging in Nederland (14.20)', ''],
        ['gemeente van inschrijving (09.10)', '0518']
    ])
    wijzigVerblijfplaats(
        getPersoon(this.context, undefined),
        verblijfplaats
    );
});

/**
 * Op dit moment wordt standaard landcode 6003 gebruikt.
 * Deze gegeven stap is voor testen waar het niet relevant is uit welk land de persoon geadopteerd is,
 * alleen dat de persoon in het buitenland is geboren.
 */
Given(/^is geboren in het buitenland/, function () {
    const codeVanLand = '6003';

    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboorteland (03.30)', codeVanLand]
        ])
    );
});

Given(/^verblijft in Nederland/, function () {
    const verblijfplaats = arrayOfArraysToDataTable([
        ['datum vestiging in Nederland (14.20)', 'vandaag - 1 jaar'],
        ['gemeente van inschrijving (09.10)', '0518']
    ])
    createVerblijfplaats(
        getPersoon(this.context, undefined),
        verblijfplaats
    );
});

/**
 * Hier volgt de gegeven stappen voor erkenning
 */
const ErkenningsType = {
    ErkenningBijGeboorteaangifte: 'B',
    ErkenningNaGeboorteaangifte: 'C',
    ErkenningBijNotarieleAkte: 'J',
    GerechtelijkeVaststellingOuderschap: 'V'
}

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij geboorteaangifte$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, null);
    const kindData = { ...kind.persoon.at(-1) };

    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', kindData.geboorte_datum]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning na geboorteaangifte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningNaGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij notariële akte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijNotarieleAkte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met gerechtelijke vaststelling ouderschap op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.GerechtelijkeVaststellingOuderschap, ouderType, ouderData);
});

Given(/^is geboren op (\d*)-(\d*)-(\d*)$/, function (dag, maand, jaar) {
    aanvullenPersoon(
        getPersoon(this.context, undefined),
        arrayOfArraysToDataTable([
            ['geboortedatum (03.10)', toBRPDate(dag, maand, jaar)]
        ])
    );
});

function gegevenIsErkendDoorPersoonAlsOuder(context, aanduidingOuder, erkenningsType, ouderType, dataTable) {
    if(!erkenningsType) {
        erkenningsType = ErkenningsType.ErkenningBijGeboorteaangifte;
    }

    const kind = getPersoon(context, null);
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = `1A${erkenningsType}0100`

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
            ['aktenummer (81.20)', `1A${erkenningsType}0100`]
        ], dataTable)
    );

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
        ])
    )
}
