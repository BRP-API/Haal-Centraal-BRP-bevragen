const { World } = require('./world');
const { dagRegex, maandRegex, jaarRegex, toGbaDate, toHcDate } = require('./calcDate');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const axios = require('axios').default;
const fs = require('fs');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { Pool } = require('pg');

setWorldConstructor(World);

let pool = undefined;
let logSqlStatements = false;

const propertyNameMap = new Map([
    ['anummer (01.10)', 'aNummer'],
    ['geslachtsaanduiding (04.10)', 'geslacht.code'],
    ['indicatie geheim (70.10)', 'geheimhoudingPersoonsgegevens'],
    ['datum eerste inschrijving GBA (68.10)', 'datumEersteInschrijvingGBA'],

    // Geboorte
    ['geboortedatum (03.10)', 'datum'],
    ['geboorteplaats (03.20)', 'plaats.code'],
    ['geboorteland (03.30)', 'land.code'],

    // In onderzoek/Procedure
    ['aanduiding gegevens in onderzoek (01.83.10)', 'persoonInOnderzoek.aanduidingGegevensInOnderzoek'],
    ['datum ingang onderzoek (01.83.20)', 'persoonInOnderzoek.datumIngangOnderzoek'],
    ['aanduiding gegevens in onderzoek (11.83.10)', 'gezagInOnderzoek.aanduidingGegevensInOnderzoek'],
    ['datum ingang onderzoek (11.83.20)', 'gezagInOnderzoek.datumIngangOnderzoek'],
    ['aanduiding gegevens in onderzoek (83.10)', 'inOnderzoek.aanduidingGegevensInOnderzoek'],
    ['datum ingang onderzoek (83.20)', 'inOnderzoek.datumIngangOnderzoek'],

    // Gezagsverhouding
    ['indicatie gezag minderjarige (32.10)', 'indicatieGezagMinderjarige.code'],
    ['indicatie curateleregister (33.10)', 'indicatieCurateleRegister'],

    // Kiesrecht
    ['Europees kiesrecht (31.10)', 'aanduiding.code'],
    ['uitgesloten van kiesrecht (38.10)', 'uitgeslotenVanKiesrecht'],
    ['einddatum uitsluiting Europees kiesrecht (31.30)', 'einddatumUitsluiting'],
    ['einddatum uitsluiting kiesrecht (38.20)', 'einddatum'],

    // Naam
    ['voornamen (02.10)', 'voornamen'],
    ['adellijke titel of predicaat (02.20)', 'adellijkeTitelPredicaat.code'],
    ['voorvoegsel (02.30)', 'voorvoegsel'],
    ['geslachtsnaam (02.40)', 'geslachtsnaam'],
    ['aanduiding naamgebruik (61.10)', 'aanduidingNaamgebruik.code'],

    ['nationaliteit (05.10)', 'nationaliteit.code'],
    ['reden opname (63.10)', 'redenOpname.code'],
    ['datum ingang geldigheid (85.10)', 'datumIngangGeldigheid'],
    ['bijzonder Nederlanderschap (65.10)', 'aanduidingBijzonderNederlanderschap'],

    // Opschorting bijhouding
    ['datum opschorting bijhouding (67.10)', 'datum' ],
    ['reden opschorting bijhouding (67.20)', 'reden.code'],

    // Ouder
    ['datum ingang familierechtelijke betrekking (62.10)', 'datumIngangFamilierechtelijkeBetrekking'],

    // Overlijden
    ['datum overlijden (08.10)', 'datum'],
    ['plaats overlijden (08.20)', 'plaats.code'],
    ['land overlijden (08.30)', 'land.code'],

    // Partner
    ['soort verbintenis (15.10)', 'soortVerbintenis.code'],
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'datum'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', 'land.code'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'plaats.code'],
    ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', 'datum'],

    // Verblijfplaats
    ['gemeente van inschrijving (09.10)', 'gemeenteVanInschrijving.code'],
    ['datum inschrijving in de gemeente (09.20)', 'datumInschrijvingInGemeente'],
    ['functie adres (10.10)', 'functieAdres.code'],
    ['datum aanvang adreshouding (10.30)', 'datumAanvangAdreshouding'],
    ['straatnaam (11.10)', 'straat'],
    ['naam openbare ruimte (11.15)', 'naamOpenbareRuimte'],
    ['huisnummer (11.20)', 'huisnummer'],
    ['huisletter (11.30)', 'huisletter'],
    ['huisnummertoevoeging (11.40)', 'huisnummertoevoeging'],
    ['aanduiding bij huisnummer (11.50)', 'aanduidingBijHuisnummer.code'],
    ['postcode (11.60)', 'postcode'],
    ['woonplaatsnaam (11.70)', 'woonplaats'],
    ['identificatiecode verblijfplaats (11.80)', 'adresseerbaarObjectIdentificatie'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummeraanduidingIdentificatie' ],
    ['locatiebeschrijving (12.10)', 'locatiebeschrijving'],
    ['land adres buitenland (13.10)', 'land.code'],
    ['datum aanvang adres buitenland (13.20)', 'datumAanvangAdresBuitenland'],
    ['regel 1 adres buitenland (13.30)', 'regel1'],
    ['regel 2 adres buitenland (13.40)', 'regel2'],
    ['regel 3 adres buitenland (13.50)', 'regel3'],
    ['land van waar ingeschreven (14.10)', 'landVanwaarIngeschreven.code'],
    ['datum vestiging in nederland (14.20)', 'datumVestigingInNederland'],

    // Verblijfstitel
    ['aanduiding verblijfstitel (39.10)', 'aanduiding.code'],
    ['datum einde verblijfstitel (39.20)', 'datumEinde'],
    ['datum ingang verblijfstitel (39.30)', 'datumIngang'],
]);

const tableNameMap = new Map([
    ['persoonlijst', 'lo3_pl'],
    ['persoon', 'lo3_pl_persoon' ],
    ['nationaliteit', 'lo3_pl_nationaliteit'],
    ['kiesrecht', 'lo3_pl'],
    ['verblijfstitel', 'lo3_pl_verblijfstitel']
]);

const columnNameMap = new Map([

    ['nationaliteit (05.10)', 'nationaliteit_code'],
    ['reden opnemen (63.10)', 'nl_nat_verkrijg_reden'],
    ['reden beëindigen (64.10)', 'nl_nat_verlies_reden'],
    ['datum ingang geldigheid (85.10)', 'geldigheid_start_datum'],

    [ 'burgerservicenummer (01.20)', 'burger_service_nr' ],

    [ 'voornamen (02.10)', 'voor_naam' ],
    ['adellijke titel of predicaat (02.20)', 'titel_predikaat' ],
    [ 'voorvoegsel (02.30)', 'geslachts_naam_voorvoegsel' ],
    [ 'geslachtsnaam (02.40)', 'geslachts_naam' ],

    ['geboortedatum (03.10)', 'geboorte_datum'],
    ['geboorteplaats (03.20)', 'geboorte_plaats'],
    ['geboorteland (03.30)', 'geboorte_land_code'],

    ['geslachtsaanduiding (04.10)', 'geslachts_aand'],

    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'relatie_start_datum'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'relatie_start_plaats'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', 'relatie_start_land_code'],
    ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', 'relatie_eind_datum'],
    ['soort verbintenis (15.10)', 'verbintenis_soort'],

    ['aanduiding uitgesloten kiesrecht (38.10)', 'kiesrecht_uitgesl_aand'],
    ['einddatum uitsluiting kiesrecht (38.20)', 'kiesrecht_uitgesl_eind_datum'],

    ['aanduiding verblijfstitel (39.10)', 'verblijfstitel_aand'],
    ['datum einde verblijfstitel (39.20)', 'verblijfstitel_eind_datum'],
    ['datum ingang verblijfstitel (39.30)', 'geldigheid_start_datum'],
	
    ['gemeente document (82.10)', 'doc_gemeente_code' ],
    ['datum document (82.20)', 'doc_datum' ],
    ['beschrijving document (82.30)', 'doc_beschrijving' ],
	
    ['ingangsdatum geldigheid (85.10)', 'geldigheid_start_datum' ],
	
    ['datum van opneming (86.10)', 'opneming_datum' ]

]);

Before(function() {
    if(this.context.sql.useDb) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            await client.query(createDeleteStatement('persoonlijst', this.context.pl_id));
            await client.query(createDeleteStatement('persoon', this.context.pl_id));
            await client.query(createDeleteStatement('nationaliteit', this.context.pl_id));
            await client.query(createDeleteStatement('verblijfstitel', this.context.pl_id));
        }
        finally {
            client.release();
        }
    }
});


function insertIntoPersoonlijstStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_pl(pl_id,mutatie_dt',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT MAX(pl_id)+1 FROM public.lo3_pl),current_timestamp';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function insertIntoStatement(tabelNaam, data) {
    let statement = {
        text: `INSERT INTO public.${tableNameMap.get(tabelNaam)}(`,
        values: []
    };

    data.forEach(function(row, index) {
        statement.text += index === 0
            ? `${row[0]}`
            : `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES(';
    statement.values.forEach(function(_value, index) {
        statement.text += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });
    statement.text += ')';

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function setPersoonOnjuistStatement(plId, persoonType, stapelNr) {
    const statement = {
        text: 'UPDATE public.lo3_pl_persoon SET onjuist_ind=$1 WHERE pl_id=$2 AND persoon_type=$3 AND stapel_nr=$4 AND volg_nr=$5',
        values: [ 'O', plId, persoonType, stapelNr, 0]
    }

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function selectPersoonMaxVolgnrStatement(plId, persoonType, stapelNr) {
    const statement = {
        text: 'SELECT MAX(volg_nr) as max_volg_nr FROM public.lo3_pl_persoon WHERE pl_id=$1 AND persoon_type=$2 AND stapel_nr=$3',
        values: [ plId, persoonType, stapelNr ]
    }

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function incrementPersoonVolgnrStatement(plId, persoonType, stapelNr, volgNr) {
    const statement = {
        text: 'UPDATE public.lo3_pl_persoon SET volg_nr=volg_nr+1 WHERE pl_id=$1 AND persoon_type=$2 AND stapel_nr=$3 AND volg_nr=$4',
        values: [ plId, persoonType, stapelNr, volgNr ]
    }

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function selectNationaliteitMaxVolgnrStatement(plId, stapelNr) {
    const statement = {
        text: 'SELECT MAX(volg_nr) as max_volg_nr FROM public.lo3_pl_nationaliteit WHERE pl_id=$1 AND stapel_nr=$2',
        values: [ plId, stapelNr ]
    }

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function incrementNationaliteitVolgnrStatement(plId, stapelNr, volgNr) {
    const statement = {
        text: 'UPDATE public.lo3_pl_nationaliteit SET volg_nr=volg_nr+1 WHERE pl_id=$1 AND stapel_nr=$2 AND volg_nr=$3',
        values: [ plId, stapelNr, volgNr ]
    }

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function createDeleteStatement(tabelNaam, plId) {
    let statement = {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE pl_id=$1`,
        values: [plId]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function fromHash(hash) {
    let retval = [];

    Object.keys(hash).forEach(function(key) {
        retval.push([ columnNameMap.get(key), hash[key] ]);
    });

    return retval;
}

function createPersoonlijstData(gegevensgroep, dataTable, geheim=0) {
    let data = [
        [ 'geheim_ind', geheim ]
    ];

    if(gegevensgroep === 'kiesrecht') {
        data = data.concat(fromHash(dataTable.hashes()[0]));
    }

    return data;
}

function createPersoonData(plId, bsn) {
    return [
        [ 'pl_id', plId ],
        [ 'persoon_type', 'P'],
        [ 'stapel_nr', 0 ],
        [ 'volg_nr', 0],
        [ 'burger_service_nr', bsn ]
    ];
}

function createKindData(plId, dataTable, stapelNr=0) {
    return [
        [ 'pl_id', plId ],
        [ 'persoon_type', 'K'],
        [ 'stapel_nr', stapelNr ],
        [ 'volg_nr', 0]
    ].concat(fromHash(dataTable.hashes()[0]));
}

function createOuderData(plId, ouderType, dataTable) {
    return [
        [ 'pl_id', plId ],
        [ 'persoon_type', ouderType],
        [ 'stapel_nr', 0 ],
        [ 'volg_nr', 0]
    ].concat(fromHash(dataTable.hashes()[0]));
}

function createPartnerData(plId, dataTable, stapelNr=0) {
    return [
        [ 'pl_id', plId ],
        [ 'persoon_type', 'R'],
        [ 'stapel_nr', stapelNr ],
        [ 'volg_nr', 0]
    ].concat(fromHash(dataTable.hashes()[0]));
}

function createCollectieGegevensgroepData(plId, dataTable) {
    return [
        [ 'pl_id', plId ],
        [ 'stapel_nr', 0 ],
        [ 'volg_nr', 0]
    ].concat(fromHash(dataTable.hashes()[0]));
}

function createGegevensgroepData(plId, dataTable) {
    return [
        [ 'pl_id', plId ],
        [ 'volg_nr', 0]
    ].concat(fromHash(dataTable.hashes()[0]));
}

Given(/^een persoon heeft de volgende '(\w*)' gegevens$/, async function (gegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let data;
            let res;
            if(gegevensgroep === 'inschrijving') {
                data = fromHash(dataTable.hashes()[0]);
                res = await client.query(insertIntoPersoonlijstStatement(data));
                this.context.pl_id = res.rows[0]["pl_id"];
            }
            if(gegevensgroep === 'persoon') {
                data = createPersoonlijstData(gegevensgroep, dataTable);
                res = await client.query(insertIntoPersoonlijstStatement(data));
                this.context.pl_id = res.rows[0]["pl_id"];

                data = [
                    [ 'pl_id', this.context.pl_id ],
                    [ 'persoon_type', 'P'],
                    [ 'stapel_nr', 0 ],
                    [ 'volg_nr', 0]
                ].concat(fromHash(dataTable.hashes()[0]));
                await client.query(insertIntoStatement(gegevensgroep, data));
            }
        }
        finally {
            client.release();
        }
    }
});

Given(/^de persoon heeft de volgende '(\w*)' gegevens$/, async function (gegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let data;
            if(gegevensgroep === 'persoon') {
                data = [
                    [ 'pl_id', this.context.pl_id ],
                    [ 'persoon_type', 'P'],
                    [ 'stapel_nr', 0 ],
                    [ 'volg_nr', 0]
                ].concat(fromHash(dataTable.hashes()[0]));
            }
            else {
                data = createGegevensgroepData(this.context.pl_id, dataTable);
            }
            await client.query(insertIntoStatement(gegevensgroep, data));
        }
        finally {
            client.release();
        }
    }
    else {
        setPersoonProperties(this.context.persoon, gegevensgroep, dataTable);

        this.context.attach(`${gegevensgroep}: ${JSON.stringify(this.context.persoon[gegevensgroep], null, '  ')}`);
    }
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, async function(burgerservicenummer, gegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let data = createPersoonlijstData(gegevensgroep, dataTable);
            let res = await client.query(insertIntoPersoonlijstStatement(data));
            this.context.pl_id = res.rows[0]["pl_id"];

            data = createPersoonData(this.context.pl_id, burgerservicenummer);
            await client.query(insertIntoStatement('persoon', data));

            if(gegevensgroep !== 'kiesrecht') {
                data = createGegevensgroepData(this.context.pl_id, dataTable);
                await client.query(insertIntoStatement(gegevensgroep, data));
            }
        }
        finally {
            client.release();
        }
    }
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, async function (burgerservicenummer, collectieGegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let data = createPersoonlijstData(undefined, dataTable);
            let res = await client.query(insertIntoPersoonlijstStatement(data));
            this.context.pl_id = res.rows[0]["pl_id"];

            data = createPersoonData(this.context.pl_id, burgerservicenummer);
            await client.query(insertIntoStatement('persoon', data));

            this.context[`${collectieGegevensgroep}-stapelnr`] = 0;

            if(collectieGegevensgroep === 'kind') {
                data = createKindData(this.context.pl_id, dataTable);
                await client.query(insertIntoStatement('persoon', data));
            }
            else if(collectieGegevensgroep === 'partner') {
                data = createPartnerData(this.context.pl_id, dataTable);
                await client.query(insertIntoStatement('persoon', data));
            }
            else {
                data = createCollectieGegevensgroepData(this.context.pl_id, dataTable);
                await client.query(insertIntoStatement(collectieGegevensgroep, data));
            }
        }
        finally {
            client.release();
        }
    }
});

async function createPersoonMetOuder(burgerservicenummer, ouderType, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let data = createPersoonlijstData(undefined, dataTable);
            let res = await client.query(insertIntoPersoonlijstStatement(data));
            this.context.pl_id = res.rows[0]["pl_id"];

            data = createPersoonData(this.context.pl_id, burgerservicenummer);
            await client.query(insertIntoStatement('persoon', data));

            data = createOuderData(this.context.pl_id, ouderType, dataTable);
            await client.query(insertIntoStatement('persoon', data));
        }
        finally {
            client.release();
        }
    }
}

async function createOuder(ouderType, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            const data = createOuderData(this.context.pl_id, ouderType, dataTable);
            await client.query(insertIntoStatement('persoon', data));
        }
        finally {
            client.release();
        }
    }
}

async function corrigeerOuder(ouderType, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            await client.query(setPersoonOnjuistStatement(this.context.pl_id, ouderType, 0));
         
            let res = await client.query(selectPersoonMaxVolgnrStatement(this.context.pl_id, ouderType, 0));
            const maxVolgnr = res.rows[0]['max_volg_nr'];
            for(let volgnr = maxVolgnr; volgnr>=0; volgnr--) {
                await client.query(incrementPersoonVolgnrStatement(this.context.pl_id, ouderType, 0, volgnr));
            }

            let data = createOuderData(this.context.pl_id, ouderType, dataTable);
            await client.query(insertIntoStatement('persoon', data));
        }
        finally {
            client.release();
        }
    }
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d{1})' met de volgende gegevens$/, createPersoonMetOuder);

Given(/^de persoon heeft een ouder '(\d{1})' met de volgende gegevens$/, createOuder);

Given(/^de ouder '(\d{1})' is gecorrigeerd naar de volgende gegevens$/, corrigeerOuder);

Given(/^het '(.*)' is gecorrigeerd naar de volgende gegevens$/, async function (relatie, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            const persoonType = relatie === 'kind' ? 'K' : 'P';

            await client.query(setPersoonOnjuistStatement(this.context.pl_id, persoonType, this.context[`${relatie}-stapelnr`]));

            let res = await client.query(selectPersoonMaxVolgnrStatement(this.context.pl_id, persoonType, this.context[`${relatie}-stapelnr`]));
            const maxVolgnr = res.rows[0]['max_volg_nr'];
            for(let volgnr = maxVolgnr; volgnr>=0; volgnr--) {
                await client.query(incrementPersoonVolgnrStatement(this.context.pl_id, persoonType, this.context[`${relatie}-stapelnr`], volgnr));
            }

            let data;
            if(relatie === 'kind') {
                data = createKindData(this.context.pl_id, dataTable, this.context[`${relatie}-stapelnr`]);
            }
            else if(relatie === 'partner') {
                data = createPartnerData(this.context.pl_id, dataTable, this.context[`${relatie}-stapelnr`]);
            }
            await client.query(insertIntoStatement('persoon', data));
        }
        finally {
            client.release();
        }
    }
});

Given(/^(?:de|het) '(.*)' is gewijzigd naar de volgende gegevens$/, async function (relatie, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            if(relatie === 'nationaliteit') {
                let res = await client.query(selectNationaliteitMaxVolgnrStatement(this.context.pl_id, this.context[`${relatie}-stapelnr`]));
                const maxVolgnr = res.rows[0]['max_volg_nr'];
                for(let volgnr = maxVolgnr; volgnr>=0; volgnr--) {
                    await client.query(incrementNationaliteitVolgnrStatement(this.context.pl_id, this.context[`${relatie}-stapelnr`], volgnr));
                }

                const data = createCollectieGegevensgroepData(this.context.pl_id, dataTable);
                await client.query(insertIntoStatement(relatie, data));
            }
            else {
                const persoonType = relatie === 'kind' ? 'K' : 'P';

                let res = await client.query(selectPersoonMaxVolgnrStatement(this.context.pl_id, persoonType, this.context[`${relatie}-stapelnr`]));
                const maxVolgnr = res.rows[0]['max_volg_nr'];
                for(let volgnr = maxVolgnr; volgnr>=0; volgnr--) {
                    await client.query(incrementPersoonVolgnrStatement(this.context.pl_id, persoonType, this.context[`${relatie}-stapelnr`], volgnr));
                }

                let data;
                if(relatie === 'kind') {
                    data = createKindData(this.context.pl_id, dataTable);
                }
                else if(relatie === 'partner') {
                    data = createPartnerData(this.context.pl_id, dataTable);
                }
                await client.query(insertIntoStatement('persoon', data));
            }
        }
        finally {
            client.release();
        }
    }
});

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?(\w*)' met ?(?:alleen)? de volgende gegevens$/, async function (relatie, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            this.context[`${relatie}-stapelnr`] += 1;

            if(relatie === 'kind') {
                const data = createKindData(this.context.pl_id, dataTable, this.context[`${relatie}-stapelnr`]);
                await client.query(insertIntoStatement('persoon', data));
            }
        }
        finally {
            client.release();
        }
    }
    else {
        let relatieCollectie = toCollectionName(relatie);

        if(this.context.persoon[relatieCollectie] === undefined) {
            this.context.persoon[relatieCollectie] = [];
        }
        if(this.context[relatie] !== undefined) {
            this.context.persoon[relatieCollectie].push(this.context[relatie]);
        }
        this.context[relatie] = createObjectFrom(dataTable);
    
        this.context.attach(`${relatie}: ${JSON.stringify(this.context[relatie], null, '  ')}`);
    }
});

function createObjectFrom(dataTable, dateAsDate = false) {
    let obj = {};

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(obj, row, dateAsDate);
    });

    return obj;
}

function mapRowToProperty(obj, row, dateAsDate = false) {
    let propertyName = propertyNameMap.get(row.naam);
    if(propertyName === undefined) {
        propertyName = row.naam;
    }

    setProperty(obj, propertyName, row.waarde, dateAsDate);
}

function getProperty(obj, propertyName) {
    if(!propertyName.includes('.')) {
        return obj[propertyName];
    }

    let propertyNames = propertyName.split('.');
    let property = obj;
    for(const propName of propertyNames) {
        property = property[propName];
    }
    return property;
}

function setProperty(obj, propertyName, propertyValue, dateAsDate) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        let propertyNames = propertyName.split('.');
        let property = obj;

        propertyNames.forEach(function(propName, index) {
            if(index === propertyNames.length-1) {
                property[propName] = calculatePropertyValue(propertyValue, dateAsDate);
            }
            else {
                if(property[propName] === undefined) {
                    property[propName] = {};
                }
                property = property[propName];
            }
        });
    }
    else {
        obj[propertyName] = calculatePropertyValue(propertyValue, dateAsDate);
    }
}

function calculatePropertyValue(propertyValue, dateAsDate) {
    if (propertyValue.match(dagRegex) ||
        propertyValue.match(maandRegex) ||
        propertyValue.match(jaarRegex)) {
        return dateAsDate
            ? toHcDate(propertyValue)
            : toGbaDate(propertyValue);
    }

    return String(propertyValue);
}

function getPropertyNames(dataTable) {
    let columns = dataTable.raw()[0];
    columns.forEach(function(column, index) {
        let propertyName = propertyNameMap.get(column);
        if(propertyName !== undefined) {
            columns[index] = propertyName;
        }
    });
    return columns;
}

function setProperties(obj, propertyGroupName, propertyNames, propertyValues)
{
    if(obj[propertyGroupName] === undefined) {
        obj[propertyGroupName] = {};
    }

    propertyNames.forEach(function(propName, index) {
        let propertyName = propertyNameMap.get(propName);
        if(propertyName === undefined) {
            propertyName = propName;
        }
        let propertyValue = propertyValues[index];

        setProperty(obj[propertyGroupName], propertyName, propertyValue);
    });
}

function setPersonenProperties(personen, propertyGroupName, dataTable) {
    const columns = getPropertyNames(dataTable);

    dataTable.raw().slice(1).forEach(function(row) {
        let persoon = personen.find(function(p) {
            return p.burgerservicenummer === row[0];
        });
        if(persoon === undefined) {
            persoon = {
                burgerservicenummer: row[0]
            };
            personen.push(persoon);
        }

        setProperties(persoon, propertyGroupName, columns.slice(1), row.slice(1));
    });
}

function setPersoonProperties(persoon, propertyGroupName, dataTable) {
    if(persoon[propertyGroupName] === undefined) {
        persoon[propertyGroupName] = {};
    }

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(persoon[propertyGroupName], row);
    });
}

Before({tags: '@post-assert'}, async function() {
    this.context.postAssert = true;
});

After({tags: '@post-assert'}, async function() {
    const actual = this.context.response.data.personen !== undefined
        ? stringifyValues(this.context.response.data.personen)
        : stringifyValues(this.context.response.data);

    let expected = this.context.expected;
    if(this.context.leaveEmptyObjects === undefined) {
        expected = deleteEmptyProperties(expected);
        expected = deleteEmptyObjects(expected);
        if(expected === undefined) {
            expected = [];
        }
    }
    this.context.attach(JSON.stringify(expected, null, '  '));

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, "\t")}`);
});

After(async function() {
    const headers = this.context.response.headers;

    const header = headers["api-version"];
    should.exist(header, "no header found with name 'api-version'");
    header.should.equal("2.0.0", "no 'api-version' header found with value: '2.0.0'");
});

After({tags: '@fout-case'}, async function() {
    const headers = this.context.response.headers;

    const header = headers["content-type"];
    should.exist(header, "no header found with name 'content-type'");
    header.should.contain("application/problem+json", "no 'content-type' header found with value: 'application/problem+json'");
});

After({tags: 'not @fout-case'}, async function() {
    const headers = this.context.response.headers;

    const header = headers["content-type"];
    should.exist(header, "no header found with name 'content-type'");
    header.should.contain("application/json", "no 'content-type' header found with value: 'application/json'");
});

function addToCollection(collection, toAdd) {
    if(collection !== undefined && toAdd !== undefined) {
        collection.push(toAdd);
    }
}

function addPersoonToPersonen(context) {
    ["partner", "ouder", "nationaliteit", "kind"]
    .forEach((relatie) => {
        addToCollection(context.persoon[toCollectionName(relatie)], context[relatie]);
        context[relatie] = undefined;
    });

    context.zoekResponse.personen.push(context.persoon);
    context.persoon = {};
}

Given(/^het systeem heeft een persoon met de volgende gegevens$/, function (dataTable) {
    addPersoonToPersonen(this.context);

    this.context.persoon = createObjectFrom(dataTable);
});

Given(/^het systeem heeft een persoon met de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    addPersoonToPersonen(this.context);

    this.context.persoon = {};

    setPersoonProperties(this.context.persoon, gegevensgroep, dataTable);
});

Given(/^het systeem heeft personen met de volgende gegevens$/, function (dataTable) {
    addPersoonToPersonen(this.context);

    const columns = getPropertyNames(dataTable);
    let personen = this.context.zoekResponse.personen;

    dataTable.raw().slice(1).forEach(function(row) {
        let persoon = {};
        columns.forEach(function(column, index) {
            let propertyName = propertyNameMap.get(column);
            if(propertyName === undefined) {
                propertyName = column;
            }
            let propertyValue = row[index];

            setProperty(persoon, propertyName, propertyValue);
        });
        personen.push(persoon);
    });
});

Given(/^de persoon heeft de volgende '(.*)'$/, function (gegevensgroep, dataTable) {
    this.context.persoon[gegevensgroep] = [];
    let groep = this.context.persoon[gegevensgroep];

    dataTable.rows().forEach(function(row){
        groep.push(row[0]);
    });
});

Given(/^het systeem heeft personen met de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    setPersonenProperties(this.context.zoekResponse.personen, gegevensgroep, dataTable);
});

Given(/^de persoon heeft een '?(?:ex-)?(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    const relatieCollectie = toCollectionName(relatie);

    if(this.context.persoon[relatieCollectie] === undefined) {
        this.context.persoon[relatieCollectie] = [];
    }
    if(this.context[relatie] !== undefined) {
        this.context.persoon[relatieCollectie].push(this.context[relatie]);
    }
    this.context[relatie] = {};

    setPersoonProperties(this.context[relatie], gegevensgroep, dataTable);
});

Given(/^(?:de|het) '?(?:ex-)?(\w*)' heeft ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    if(this.context[relatie] === undefined) {
        this.context[relatie] = {};
    }

    setPersoonProperties(this.context[relatie], gegevensgroep, dataTable);
});

Given(/^de persoon heeft (?:GEEN|geen) '(.*)' gegevens$/, function (_) {
    // doe niets
});

Given(/^(?:de|het) '(.*)' heeft GEEN '(.*)' gegevens$/, function (_relatie, _gegevensgroep) {
    // doe niets
});

function createRequestBody(dataTable) {
    let requestBody = {};
    dataTable.hashes()
            .filter(function(param) {
                return !param.naam.startsWith("header:");
            })
            .forEach(function(param) {
                if(["burgerservicenummer",
                    "burgerservicenummer (als string)",
                    "fields",
                    "fields (als string)"].includes(param.naam)) {
                    if(param.naam === 'fields (als string)') {
                        requestBody['fields'] = param.waarde;
                    }
                    else if(param.naam === 'burgerservicenummer (als string)') {
                        requestBody['burgerservicenummer'] = param.waarde;
                    }
                    else if(param.waarde === '') {
                        requestBody[param.naam] = [];
                    }
                    else if(param.waarde === '(131 maal aNummer)') {
                        requestBody[param.naam] = [];
                        for(let count=0; count<=131; count++) {
                            requestBody[param.naam].push('aNummer');
                        }
                    }
                    else {
                        requestBody[param.naam] = param.waarde.split(',');
                    }
                }
                else {
                    requestBody[param.naam] = calculatePropertyValue(param.waarde, true);
                }
            });

    return requestBody;
}

function createHeaders(dataTable) {
    let headers = {};

    dataTable.hashes()
        .filter(function(param) {
            return param.naam.startsWith("header:");
        })
        .forEach(function(param) {
            headers[param.naam.slice(8)] = param.waarde;
        });

    if(headers.Accept === undefined) {
        headers.Accept = "application/json";
    }
    return headers;
}

When(/^personen wordt gezocht met de volgende parameters$/, async function (dataTable) {
    const config = {
        method: 'post',
        url: '/personen',
        baseURL: this.context.serverUrl,
        data: createRequestBody(dataTable),
        headers: createHeaders(dataTable)
    };

    addPersoonToPersonen(this.context);

    const path = `${this.context.dataPath}/test-data.json`;
    fs.writeFile(path, JSON.stringify(this.context.zoekResponse.personen, null, "\t"), (err) => {
        if(err !== null) console.log(err);
    });

    try {
        this.context.response = await axios(config);
    }
    catch(e) {
        this.context.response = e.response;
    }
});

Then(/^heeft de response de volgende header gegevens$/, function (dataTable) {
    const headers = this.context.response.headers;

    dataTable.hashes().forEach(function(row) {
        const header = headers[row.naam];
        should.exist(header, `no header found with name '${row.naam}'`);
        header.should.equal(row.waarde, `no '${header}' found with value: '${row.waarde}'`);
    });
});

Then(/^heeft de response (\d*) (?:persoon|personen)$/, function (aantal) {
    const personen = this.context.response.data.personen;

    personen.length.should.equal(Number(aantal), `aantal personen in response is ongelijk aan ${aantal}\nPersonen:${JSON.stringify(personen, null, "\t")}`);
});

Then(/^heeft de response een persoon met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [];
        }
        this.context.expected.push(expected);
    }
});

Then(/^heeft de response een persoon met ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    let expected = {};
    expected[gegevensgroep] = createObjectFrom(dataTable, true);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [];
        }
        this.context.expected.push(expected);
    }
});

Then(/^heeft de persoon ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable, true);

    if(this.context.postAssert === true) {
        if(Object.keys(expected).length === 0) return;

        const personen = this.context.expected;
        should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
        personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        let persoon = personen[personen.length-1];
        should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        persoon[gegevensgroep] = expected;
    }
});

Then(/^heeft de persoon ?(?:alleen)? de volgende '(.*)'$/, function (gegevensgroep, dataTable) {
    let expected = [];
    dataTable.rows().forEach(function(row) {
        expected.push(row[0]);
    });

    if(this.context.postAssert === true) {
        const personen = this.context.expected;
        should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
        personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        let persoon = personen[personen.length-1];
        should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        persoon[gegevensgroep] = expected;
    }
});

Then(/^heeft de persoon een leeg '(.*)' object$/, function(gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};
    if(this.context.postAssert === true) {
        const personen = this.context.expected;
        should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
        personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        let persoon = personen[personen.length-1];
        should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

        persoon[gegevensgroep] = expected;
    }
});

Then(/^heeft de persoon GEEN '(.*)' gegevens$/, function (_) {
    // doe niets
});

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function(relatie, dataTable) {
    const expected = createObjectFrom(dataTable);

    let relaties = toCollectionName(relatie);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push(expected);
    }
});

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

Then(/^heeft de persoon een '(.*)' met de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

function addRelatieToExpectedPersoon(relatie, gegevensgroep, dataTable) {
    let expected = {};
    setPersoonProperties(expected, gegevensgroep, dataTable);

    let relaties = toCollectionName(relatie);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push(expected);
    }
}

Then(/^heeft de persoon een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable);

    let groep = toCollectionName(gegevensgroep);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersonen = this.context.expected;
        const expectedPersoon = expectedPersonen[expectedPersonen.length-1];
        if(expectedPersoon[groep] === undefined) {
            expectedPersoon[groep] = [];
        }
        expectedPersoon[groep].push(expected);
    }
});

Then(/^heeft (?:de|het) '(.*)' ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
            return 'pending';
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];

        const relaties = toCollectionName(relatie);
        let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
        expectedRelatie[gegevensgroep] = expected;
    }
});

Then(/^heeft (?:de|het) '(.*)' een leeg '(.*)' object$/, function(relatie, gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};
    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
            return 'pending';
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];

        const relaties = toCollectionName(relatie);
        let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
        expectedRelatie[gegevensgroep] = expected;
    }
});

Then(/^heeft de '(.*)' GEEN '(.*)' gegevens$/, function (_relatie, _gegevensgroep) {
    // do nothing
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = expected;
        }
    }
    else {
        const actual = this.context.response.data;

        actual.should.deep.equalInAnyOrder(expected);
    }
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = dataTable.hashes();

    if(this.context.postAssert === true) {
        this.context.expected[gegevensgroep] = expected;
    }
    else {
        const actual = this.context.response.data[gegevensgroep];

        actual.should.deep.equalInAnyOrder(expected);
    }
});

Then('heeft de response een leeg persoon object', function () {
    this.context.leaveEmptyObjects = true;

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }
    }
});

function createEmptyCollectieGegevensgroep(gegevensgroep) {
    this.context.leaveEmptyObjects = true;
    let expected = {};

    const relaties = toCollectionName(gegevensgroep);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];
        if(relaties === undefined) {
            expectedPersoon[gegevensgroep] = expected;
        }
        else {
            if(expectedPersoon[relaties] === undefined) {
                expectedPersoon[relaties] = [];
            }
            expectedPersoon[relaties].push(expected);
        }
    }
}

Then(/^heeft de response een persoon met een '(\w*)' zonder gegevens$/, createEmptyCollectieGegevensgroep);

Then(/^heeft de response een persoon met ?(?:een)? leeg '(.*)' object$/, createEmptyCollectieGegevensgroep);

Then(/^heeft de response een persoon met een '([a-zA-Z]*)' met een leeg '([a-zA-Z]*)' object$/, function (relatie, gegevensgroep) {
    this.context.leaveEmptyObjects = true;
    let expected = {};
    expected[gegevensgroep] = {};

    let relaties = toCollectionName(relatie);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push(expected);
    }
});

Then(/^heeft de response een persoon met een '([a-zA-Z]*)' met een '([a-zA-Z]*)' met een leeg '([a-zA-Z]*)' object$/, function (relatie, gegevensgroep, gegevensgroep2) {
    this.context.leaveEmptyObjects = true;
    let expected = {};
    expected[gegevensgroep] = {};
    expected[gegevensgroep][gegevensgroep2] = {};

    let relaties = toCollectionName(relatie);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ {} ];
        }

        const expectedPersoon = this.context.expected[this.context.expected.length-1];
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push(expected);
    }
});

Given(/^de persoon heeft geen (?:actuele partner|\(ex\)partner)$/, function () {
    // doe niets
});

Given('de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad', function () {
    // doe niets
});

function toCollectionName(gegevensgroep) {
    switch(gegevensgroep) {
        case 'partner':
            return 'partners';
        case 'ouder':
            return 'ouders';
        case 'kind':
            return 'kinderen';
        case 'nationaliteit':
            return 'nationaliteiten';
        default:
            return undefined;
    }
}

function deleteEmptyObjects(o) {
    if(o === undefined) return o;

    Object.keys(o).forEach(k => {
        if (typeof o[k] === 'object') {
            deleteEmptyObjects(o[k]);

            if(Object.keys(o[k]).length === 0) {
                delete o[k];
            }
        }
    });

    return o;
}

function deleteEmptyProperties(o) {
    if(o === undefined) return o;

    Object.keys(o).forEach(k => {
      if (typeof o[k] === 'object') {
        return deleteEmptyProperties(o[k]);
      }

      if(o[k] === '') {
        delete o[k];
      }
    });

    return o;
}

function stringifyValues(o) {
    if(o === undefined) return o;

    Object.keys(o).forEach(k => {
        if (typeof o[k] === 'object') {
        return stringifyValues(o[k]);
        }

        o[k] = '' + o[k];
    });

    return o;
}
