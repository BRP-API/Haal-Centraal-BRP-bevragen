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
let accessToken = undefined;

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
    ['datum einde onderzoek (83.30)', 'inOnderzoek.datumEindeOnderzoek'],

    // Gezagsverhouding
    ['indicatie gezag minderjarige (32.10)', 'indicatieGezagMinderjarige.code'],
    ['indicatie curateleregister (33.10)', 'indicatieCurateleRegister'],

    // Kiesrecht
    ['europees kiesrecht (31.10)', 'aanduiding.code'],
    ['uitgesloten van kiesrecht (38.10)', 'uitgeslotenVanKiesrecht'],
    ['einddatum uitsluiting europees kiesrecht (31.30)', 'einddatumUitsluiting'],
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
    ['datum ingang verblijfstitel (39.30)', 'datumIngang']
]);

const tableNameMap = new Map([
    ['inschrijving', 'lo3_pl'],
    ['persoon', 'lo3_pl_persoon' ],
    ['kind', 'lo3_pl_persoon' ],
    ['partner', 'lo3_pl_persoon' ],
    ['ouder', 'lo3_pl_persoon'],
    ['nationaliteit', 'lo3_pl_nationaliteit'],
    ['kiesrecht', 'lo3_pl'],
    ['verblijfstitel', 'lo3_pl_verblijfstitel'],
    ['verblijfplaats', 'lo3_pl_verblijfplaats'],
    ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
    ['overlijden', 'lo3_pl_overlijden'],
    ['adres', 'lo3_adres'],
    ['geboorte', 'lo3_pl_persoon'],
    ['immigratie', 'lo3_pl_verblijfplaats']
]);

const columnNameMap = new Map([

    ['anummer (01.10)', 'a_nr'],
    ['burgerservicenummer (01.20)', 'burger_service_nr' ],

    ['voornamen (02.10)', 'voor_naam' ],
    ['adellijke titel of predicaat (02.20)', 'titel_predikaat' ],
    ['voorvoegsel (02.30)', 'geslachts_naam_voorvoegsel' ],
    ['geslachtsnaam (02.40)', 'geslachts_naam' ],

    ['geboortedatum (03.10)', 'geboorte_datum'],
    ['geboorteplaats (03.20)', 'geboorte_plaats'],
    ['geboorteland (03.30)', 'geboorte_land_code'],

    ['geslachtsaanduiding (04.10)', 'geslachts_aand'],

    ['nationaliteit (05.10)', 'nationaliteit_code'],
    ['reden opname (63.10)', 'nl_nat_verkrijg_reden'],

    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'relatie_start_datum'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'relatie_start_plaats'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', 'relatie_start_land_code'],

    ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', 'relatie_eind_datum'],

    ['datum overlijden (08.10)', 'overlijden_datum'],
    ['plaats overlijden (08.20)', 'overlijden_plaats'],
    ['land overlijden (08.30)', 'overlijden_land_code'],

    ['gemeente van inschrijving (09.10)', 'inschrijving_gemeente_code'],
    ['datum inschrijving in de gemeente (09.20)', 'inschrijving_datum'],

    ['functieAdres.code (10.10)', 'adres_functie'],
    ['functie adres (10.10)', 'adres_functie'],
    ['datum aanvang adreshouding (10.30)', 'adreshouding_start_datum'],

    ['gemeente_code', 'gemeente_code'],
    ['straatnaam (11.10)', 'straat_naam'],
    ['naam openbare ruimte (11.15)', 'open_ruimte_naam'],
    ['huisnummer (11.20)', 'huis_nr'],
    ['huisletter (11.30)', 'huis_letter'],
    ['huisnummertoevoeging (11.40)', 'huis_nr_toevoeging'],
    ['aanduiding bij huisnummer (11.50)', 'huis_nr_aand'],
    ['postcode (11.60)', 'postcode'],
    ['woonplaats (11.70)', 'woon_plaats_naam'],
    ['identificatiecode verblijfplaats (11.80)', 'verblijf_plaats_ident_code'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummer_aand_ident_code'],
    ['land adres buitenland (13.10)', 'vertrek_land_code'],

    ['locatiebeschrijving (12.10)', 'locatie_beschrijving'],

    ['land (13.10)', 'vertrek_land_code'],
    ['land_adres_buitenland (13.10)', 'vertrek_land_code'],
    ['land adres buitenland (13.10)', 'vertrek_land_code'],
    ['datum aanvang adres buitenland (13.20)', 'vertrek_datum'],
    ['regel 1 adres buitenland (13.30)', 'vertrek_land_adres_1'],
    ['regel 2 adres buitenland (13.40)', 'vertrek_land_adres_2'],
    ['regel 3 adres buitenland (13.50)', 'vertrek_land_adres_3'],

    ['land vanwaar ingeschreven (14.10)', 'vestiging_land_code'],
    ['datum vestiging in Nederland (14.20)', 'vestiging_datum'],

    ['soort verbintenis (15.10)', 'verbintenis_soort'],

    ['Europees kiesrecht (31.10)', 'europees_kiesrecht_aand'],
    ['einddatum uitsluiting Europees kiesrecht (31.30)', 'europees_uitsluit_eind_datum'],

    ['indicatie gezag minderjarige (32.10)', 'minderjarig_gezag_ind'],
    ['indicatie curateleregister (33.10)', 'curatele_register_ind'],

    ['aanduiding uitgesloten kiesrecht (38.10)', 'kiesrecht_uitgesl_aand'],
    ['einddatum uitsluiting kiesrecht (38.20)', 'kiesrecht_uitgesl_eind_datum'],
    ['europees kiesrecht (31.10)', 'europees_kiesrecht_aand'],
    ['einddatum uitsluiting europees kiesrecht (31.30)', 'europees_uitsluit_eind_datum'],

    ['aanduiding verblijfstitel (39.10)', 'verblijfstitel_aand'],
    ['datum einde verblijfstitel (39.20)', 'verblijfstitel_eind_datum'],
    ['datum ingang verblijfstitel (39.30)', 'verblijfstitel_start_datum'],

    ['aanduiding naamgebruik (61.10)', 'naam_gebruik_aand'],

    ['datum ingang familierechtelijke betrekking (62.10)', 'familie_betrek_start_datum'],

    ['reden opnemen (63.10)', 'nl_nat_verkrijg_reden'],
    ['reden opname (63.10)', 'nl_nat_verkrijg_reden'],

    ['reden beëindigen (64.10)', 'nl_nat_verlies_reden'],
	
    ['bijzonder Nederlanderschap (65.10)', 'bijzonder_nl_aand' ],

    ['datum opschorting bijhouding (67.10)', 'bijhouding_opschort_datum' ],
    ['reden opschorting bijhouding (67.20)', 'bijhouding_opschort_reden'],

    ['datum eerste inschrijving GBA (68.10)', 'gba_eerste_inschrijving_datum'],

    ['indicatie geheim (70.10)', 'geheim_ind'],

    ['aktenummer (81.20)', 'akte_nr' ],
	
    ['gemeente document (82.10)', 'doc_gemeente_code' ],
    ['datum document (82.20)', 'doc_datum' ],
    ['beschrijving document (82.30)', 'doc_beschrijving' ],

    ['aanduiding in onderzoek (83.10)', 'onderzoek_gegevens_aand' ],
    ['datum ingang onderzoek (83.20)', 'onderzoek_start_datum' ],
    ['datum einde onderzoek (83.30)', 'onderzoek_eind_datum' ],

    ['indicatie onjuist (84.10)', 'onjuist_ind' ],
    ['onjuist (84.10)', 'onjuist_ind' ],

    ['datum ingang geldigheid (85.10)', 'geldigheid_start_datum'],
    ['ingangsdatum geldigheid (85.10)', 'geldigheid_start_datum' ],

    ['datum van opneming (86.10)', 'opneming_datum' ],

    ['rni-deelnemer (88.10)', 'rni_deelnemer'],
    ['omschrijving verdrag (88.20)', 'verdrag_oms'],

]);

Before(function() {
    if(this.context.sql.useDb) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if(pool !== undefined && this.context.sql.cleanup) {
        const client = await pool.connect();
        try {
            for(const [key] of tableNameMap){
                await client.query(createDeleteStatement(key, key === 'adres' ? this.context.adres_id : this.context.pl_id));
            }
        }
        catch(ex) {
            console.log(ex.stack);
        }
        finally {
            client.release();
        }
    }
});

function insertIntoAdresStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_adres(adres_id',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT MAX(adres_id)+1 FROM public.lo3_adres)';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

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
    let tableName = tableNameMap.get(tabelNaam);
    if(tableName === undefined) {
        tableName = tabelNaam;
    }
    let statement = {
        text: `INSERT INTO public.${tableName}(`,
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

function createDeleteStatement(tabelNaam, id) {
    const naamId = tabelNaam === 'adres'
        ? 'adres_id'
        : 'pl_id';

    const statement = {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE ${naamId}=$1`,
        values: [id]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function fromHash(hash) {
    let retval = [];

    Object.keys(hash).forEach(function(key) {
        retval.push([ columnNameMap.get(key), calculatePropertyValue(hash[key], false) ]);
    });

    return retval;
}

function createArrayFrom(dataTable) {
    let retval = [];

    if(dataTable.raw()[0][0] === "naam") {
        dataTable.hashes().forEach(function(row) {
            const propertyName = columnNameMap.get(row.naam);

            if(row.waarde !== undefined && row.waarde !== '') {
                retval.push([ propertyName, calculatePropertyValue(row.waarde, false) ]);
            }
        });
    }
    else {
        retval = fromHash(dataTable.hashes()[0]);
    }

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

function createCollectieDataFromArray(relatie, data, stapelNr=0) {
    let persoon_type;
    switch(relatie) {
        case 'persoon':
            persoon_type = 'P';
            break;
        case 'kind':
            persoon_type = 'K';
            break;
        case 'partner':
            persoon_type = 'R';
            break;
        case '1':
            persoon_type = '1';
            break;
        case '2':
            persoon_type = '2';
            break;
        default:
            break;
    }
    return persoon_type !== undefined
        ? [
            [ 'stapel_nr', stapelNr+''],
            [ 'volg_nr', '0'],
            [ 'persoon_type', persoon_type]
          ].concat(data)
        : [
            [ 'stapel_nr', stapelNr+''],
            [ 'volg_nr', '0']
          ].concat(data);
}

function createVoorkomenDataFromArray(data) {
    return [
        [ 'volg_nr', '0']
    ].concat(data);
}

function getNextStapelNr(sqlData, relatie) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(relatie)){
            stapelNr = Number(key.replace(`${relatie}-`, ""));
        }
    });

    return stapelNr;
}

Given(/^landelijke tabel "([\w\-]*)" heeft de volgende waarden$/, function (_tabelNaam, _dataTable) {
    // doe nog niets
});

Given(/^de statement '(.*)' heeft als resultaat '(\d*)'$/, function (statement, result) {
    if(statement.includes('lo3_pl')) {
        this.context.pl_id = Number(result);
    }
    else if(statement.includes('lo3_adres')) {
        this.context.adres_id = Number(result);
    }
});

Given(/^de response body is gelijk aan$/, function (docString) {
    this.context.response = {
        data: JSON.parse(docString)
    };
});

Given(/^(?:de|een) persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    this.context.sqlData = {};

    this.context.sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    this.context.sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ]).concat(createArrayFrom(dataTable))
    ];
});

Then(/^zijn de gegenereerde SQL statements$/, function(dataTable) {
    const sqlData = this.context.sqlData;
    const plId = this.context.pl_id;
    const adresId = this.context.adres_id;

    let expected = {};
    let lastKey;
    dataTable.hashes().forEach(function(hash) {
        if(hash.key !== '') {
            expected[hash.key] = [ hash ];
            lastKey = hash.key;
        }
        else {
            expected[lastKey].push(hash);
        }
    });

    for(const key of Object.keys(expected)) {
        const sqlDataItems = sqlData[key];
        should.exist(sqlDataItems, `geen data gevonden voor '${key}' om SQL statements te genereren`);

        expected[key].forEach(function(exp, index) {
            let actual = sqlDataItems[index];

            let statement;
            switch(key) {
                case 'inschrijving':
                    statement = insertIntoPersoonlijstStatement(actual);
                    break;
                case 'adres':
                    statement = insertIntoAdresStatement(actual);
                    break;
                case 'verblijfplaats':
                    statement = insertIntoStatement(key, [
                        ['pl_id', plId+''],
                        ['adres_id', adresId+'']
                    ].concat(actual));
                    break;
                default:
                    const name = key.replace(/-\d$/, "");
                    statement = insertIntoStatement(name, [
                        ['pl_id', plId+'']
                    ].concat(actual));
            }

            statement.text.should.equal(exp.text);
            statement.values.should.deep.equalInAnyOrder(exp.values.split(','));
        });
    }
});

function createStatementData(key, plId, adresId, rowData) {
    if(key === 'verblijfplaats') {
        if(adresId === undefined) {
            return [
                [ 'pl_id', plId ]
            ].concat(rowData);
        }
        return [
            [ 'pl_id', plId ],
            [ 'adres_id', adresId ]
        ].concat(rowData);
    }

    return [
        [ 'pl_id', plId ]
    ].concat(rowData);
}

async function executeSqlStatements(sqlData) {
    let plId = undefined;
    let adresId = undefined;

    if (sqlData !== undefined &&
        pool !== undefined) {
        const client = await pool.connect();
        try {
            if(sqlData['adres'] !== undefined) {
                const res = await client.query(insertIntoAdresStatement(sqlData['adres'][0]));
                adresId = res.rows[0]['adres_id'];
            }
            const res = await client.query(insertIntoPersoonlijstStatement(sqlData['inschrijving'][0]));
            plId = res.rows[0]['pl_id'];
    
            for(const key of Object.keys(sqlData)) {
                if(key === 'inschrijving' ||
                    key === 'adres') {
                    continue;
                }
    
                for(const rowData of sqlData[key]) {
                    const data = createStatementData(key, plId, adresId, rowData);
    
                    const name = key.replace(/-\d$/, "");
                    await client.query(insertIntoStatement(name, data));
                }
            }
        }
        catch(ex) {
            console.log(ex);
        }
        finally {
            client.release();
        }
    }

    return {
        'pl_id' : plId,
        'adres_id': adresId
    };
}

Given(/^de persoon heeft de volgende '(\w*)' gegevens$/, async function (gegevensgroep, dataTable) {
    this.context.sqlData[gegevensgroep] = [
        gegevensgroep === 'inschrijving'
            ? createArrayFrom(dataTable)
            : createVoorkomenDataFromArray(createArrayFrom(dataTable)) 

    ];

    setPersoonProperties(this.context.persoon, gegevensgroep, dataTable);

    this.context.attach(`${gegevensgroep}: ${JSON.stringify(this.context.persoon[gegevensgroep], null, '  ')}`);
});

function createPersoonMetGegevensgroep(burgerservicenummer, gegevensgroep, dataTable) {
    this.context.sqlData = {};

    this.context.sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    if(gegevensgroep !== 'inschrijving') {
        this.context.sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
        this.context.sqlData[gegevensgroep] = [
            [
                [ 'volg_nr', '0']
            ].concat(createArrayFrom(dataTable)) ];
    }
    else {
        this.context.sqlData[gegevensgroep] = [ createArrayFrom(dataTable) ];
    }
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' verkregen met de volgende gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, async function (burgerservicenummer, collectieGegevensgroep, dataTable) {
    this.context.sqlData = {};

    this.context.sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    this.context.sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    this.context.sqlData[`${collectieGegevensgroep}-1`] = [
        createCollectieDataFromArray(collectieGegevensgroep, createArrayFrom(dataTable))
    ];
});

async function createPersoonMetOuder(burgerservicenummer, ouderType, dataTable) {
    this.context.sqlData = {};

    this.context.sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    this.context.sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    this.context.sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable))
    ];
}

async function createOuder(ouderType, dataTable) {
    this.context.sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable))
    ];
}

async function corrigeerOuder(ouderType, dataTable) {
    this.context.sqlData[`ouder-${ouderType}`].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData[`ouder-${ouderType}`].push(createCollectieDataFromArray(ouderType, createArrayFrom(dataTable)));
}

function wijzigOuder(ouderType, dataTable) {
    this.context.sqlData[`ouder-${ouderType}`].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData[`ouder-${ouderType}`].push(createCollectieDataFromArray(ouderType, createArrayFrom(dataTable)));
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d{1})' met de volgende gegevens$/, createPersoonMetOuder);

Given(/^de persoon heeft een ouder '(\d{1})' met de volgende gegevens$/, createOuder);

Given(/^de ouder '(\d{1})' is gewijzigd naar de volgende gegevens$/, wijzigOuder);

Given(/^de ouder '(\d{1})' is gecorrigeerd naar de volgende gegevens$/, corrigeerOuder);

Given(/^de persoon is gecorrigeerd naar de volgende gegevens$/, function (dataTable) {
    this.context.sqlData['persoon'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData['persoon'].push(createCollectieDataFromArray('persoon', createArrayFrom(dataTable)));
});

Given(/^(?:de|het) '(.*)' is gecorrigeerd naar de volgende gegevens$/, async function (relatie, dataTable) {
    let foundRelatie;
    Object.keys(this.context.sqlData).forEach(function(key) {
        if(key.startsWith(relatie)) {
            foundRelatie = key;
        }
    });

    const stapelNr = this.context.sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');
    this.context.sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable), stapelNr[1]));
});

Given(/^de persoon is gewijzigd naar de volgende gegevens$/, function (dataTable) {
    this.context.sqlData['persoon'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData['persoon'].push(createCollectieDataFromArray('persoon', createArrayFrom(dataTable)));
});

Given(/^de persoon is gewijzigd naar de volgende '(\w*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.sqlData[gegevensgroep].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    this.context.sqlData[gegevensgroep].push(createVoorkomenDataFromArray(createArrayFrom(dataTable)));
});

function wijzigRelatie(relatie, dataTable) {
    let foundRelatie;
    Object.keys(this.context.sqlData).find(function(key) {
        if(key.startsWith(relatie)) {
            foundRelatie = key;
        }
    });

    const stapelNr = this.context.sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');
    this.context.sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });
    if(stapelNr !== undefined) {
        this.context.sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable), stapelNr[1]));
    }
    else {
        this.context.sqlData[foundRelatie].push(createVoorkomenDataFromArray(createArrayFrom(dataTable)));
    }
}

Given(/^(?:de|het) '(.*)' is gewijzigd naar de volgende gegevens$/, wijzigRelatie);

Given(/^de persoon heeft een '(\w*)' verkregen met de volgende gegevens$/, wijzigRelatie);

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?(\w*)' met ?(?:alleen)? de volgende gegevens$/, async function (relatie, dataTable) {
    const stapelNr = getNextStapelNr(this.context.sqlData, relatie);
    this.context.sqlData[`${relatie}-${stapelNr+1}`] = [
        createCollectieDataFromArray(relatie, createArrayFrom(dataTable), stapelNr)
    ];

    let relatieCollectie = toCollectionName(relatie);

    if(this.context.persoon[relatieCollectie] === undefined) {
        this.context.persoon[relatieCollectie] = [];
    }
    if(this.context[relatie] !== undefined) {
        this.context.persoon[relatieCollectie].push(this.context[relatie]);
    }
    this.context[relatie] = createObjectFrom(dataTable);
});

Given(/^(?:de|het) '?(?:ex-)?(\w*)' heeft ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    this.context.sqlData[`${gegevensgroep}`] = [
        createArrayFrom(dataTable)
    ];

    if(this.context[relatie] === undefined) {
        this.context[relatie] = {};
    }

    setPersoonProperties(this.context[relatie], gegevensgroep, dataTable);
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

After(async function() {
    if(this.context.response === undefined) {
        return;
    }

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
    if(this.context.response === undefined) {
        console.log('er is geen response');
        return;
    }

    const headers = this.context.response.headers;
    if(headers === undefined) {
        console.log('de response heeft geen headers');
        return;
    }

    const header = headers["api-version"];
    should.exist(header, "no header found with name 'api-version'");
    header.should.equal(this.context.expectedApiVersion,
                        `no 'api-version' header found with value: '${this.context.expectedApiVersion}'`);
});

After({tags: '@fout-case'}, async function() {
    const headers = this.context.response.headers;

    const header = headers["content-type"];
    should.exist(header, "no header found with name 'content-type'");
    header.should.contain("application/problem+json", "no 'content-type' header found with value: 'application/problem+json'");
});

After({tags: 'not @fout-case'}, async function() {
    if(this.context.response === undefined) {
        console.log('er is geen response');
        return;
    }

    const headers = this.context.response.headers;
    if(headers === undefined) {
        console.log('de response heeft geen headers');
        return;
    }

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
    ["partner", "ouder", "nationaliteit", "kind", "rni"]
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

function createHeaders(dataTable, extraHeaders) {
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
    extraHeaders.forEach(function(header){
        headers[header.naam] = header.waarde;
    });

    return headers;
}

async function getOAuthAccessToken(oAuthSettings) {
    const config = {
        method: 'post',
        url: oAuthSettings.accessTokenUrl,
        headers: { 'content-type': 'application/x-www-form-urlencoded'},
        data: new URLSearchParams({
            grant_type: 'client_credentials',
            client_id: oAuthSettings.clientId,
            client_secret: oAuthSettings.clientSecret,
            scope: oAuthSettings.scopes
        })
    };

    try {
        const response = await axios(config);
        return response.data.access_token
    }
    catch(e) {
        console.log(e);
    }
}

async function postBevragenRequestWithOAuth(baseUrl, access_token, dataTable) {
    const config = {
        method: 'post',
        url: '/personen',
        baseURL: baseUrl,
        data: createRequestBody(dataTable),
        headers: createHeaders(dataTable, [
            {
                naam: 'Authorization',
                waarde: 'Bearer ' + access_token
            }
        ])
    };

    try {
        return await axios(config);
    }
    catch(e) {
        e.code.should.not.equal('ECONNREFUSED', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        e.code.should.not.equal('ECONNRESET', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        return e.response;
    }
}

async function postBevragenRequestWithBasicAuth(baseUrl, extraHeaders, dataTable) {
    const config = {
        method: 'post',
        url: '/personen',
        baseURL: baseUrl,
        data: createRequestBody(dataTable),
        headers: createHeaders(dataTable, extraHeaders)
    };

    try {
        return await axios(config);
    }
    catch(e) {
        e.code.should.not.equal('ECONNREFUSED', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        e.code.should.not.equal('ECONNRESET', `${e.config.baseURL}${e.config.url} returns ${e.code}`);
        return e.response;
    }
}

When(/^personen wordt gezocht met de volgende parameters$/, async function (dataTable) {
    const result = await executeSqlStatements(this.context.sqlData);
    this.context.pl_id = result.pl_id;
    this.context.adres_id = result.adres_id;

    addPersoonToPersonen(this.context);

    const path = `${this.context.dataPath}/test-data.json`;
    fs.writeFile(path, JSON.stringify(this.context.zoekResponse.personen, null, "\t"), (err) => {
        if(err !== null) console.log(err);
    });

    if(this.context.oAuth.enable) {
        if(accessToken === undefined) {
            console.log("no access token. authenticate");
            accessToken = await getOAuthAccessToken(this.context.oAuth);
        }
        this.context.response = await postBevragenRequestWithOAuth(this.context.proxyUrl, accessToken, dataTable);
        if(this.context.response.status === 401) {
            console.log("access denied. access token expired");
            accessToken = await getOAuthAccessToken(this.context.oAuth);
            this.context.response = await postBevragenRequestWithOAuth(this.context.proxyUrl, accessToken, dataTable);
        }
    } else {
        this.context.response = await postBevragenRequestWithBasicAuth(this.context.proxyUrl, this.context.extraHeaders, dataTable);
    }
});

When(/^gba personen wordt gezocht met de volgende parameters$/, async function (dataTable) {
    const result = await executeSqlStatements(this.context.sqlData);
    this.context.pl_id = result.pl_id;
    this.context.adres_id = result.adres_id;

    addPersoonToPersonen(this.context);

    const path = `${this.context.dataPath}/test-data.json`;
    fs.writeFile(path, JSON.stringify(this.context.zoekResponse.personen, null, "\t"), (err) => {
        if(err !== null) console.log(err);
    });

    if(this.context.oAuth.enable) {
        if(accessToken === undefined) {
            console.log("no access token. authenticate");
            accessToken = await getOAuthAccessToken(this.context.oAuth);
        }
        this.context.response = await postBevragenRequestWithOAuth(this.context.gbaUrl, accessToken, dataTable);
        if(this.context.response.status === 401) {
            console.log("access denied. access token expired");
            accessToken = await getOAuthAccessToken(this.context.oAuth);
            this.context.response = await postBevragenRequestWithOAuth(this.context.gbaUrl, accessToken, dataTable);
        }
    } else {
        this.context.response = await postBevragenRequestWithBasicAuth(this.context.gbaUrl, this.context.extraHeaders, dataTable);
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

Then(/^heeft de persoon ?(?:alleen)? de volgende '(.*)'$/, function (gegevensgroep, dataTable) {
    let expected = [];
    dataTable.rows().forEach(function(row) {
        expected.push(row[0]);
    });

    const personen = this.context.expected;
    should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
    personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    let persoon = personen[personen.length-1];
    should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    persoon[gegevensgroep] = expected;
});

Then(/^heeft de response ?(?:nog)? een persoon met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(expected);
});

Then(/^heeft de response een persoon met ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    let expected = {};
    expected[gegevensgroep] = createObjectFrom(dataTable, true);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(expected);
});

Then(/^heeft de persoon ?(?:alleen)? de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable, true);

    if(Object.keys(expected).length === 0) return;

    const personen = this.context.expected;
    should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
    personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    let persoon = personen[personen.length-1];
    should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    persoon[gegevensgroep] = expected;
});


Then(/^heeft de persoon een leeg '(.*)' object$/, function(gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};

    const personen = this.context.expected;
    should.exist(personen, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');
    personen.length.should.not.equal(0, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    let persoon = personen[personen.length-1];
    should.exist(persoon, 'Geen persoon gevonden. Gebruik de \'Dan heeft de response een persoon met de volgende gegevens\' stap om een persoon aan te maken');

    persoon[gegevensgroep] = expected;
});

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function(relatie, dataTable) {
    const expected = createObjectFrom(dataTable);

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];
    if(expectedPersoon[relaties] === undefined) {
        expectedPersoon[relaties] = [];
    }
    expectedPersoon[relaties].push(expected);
});

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

Then(/^heeft de persoon een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, addRelatieToExpectedPersoon);

function addRelatieToExpectedPersoon(relatie, gegevensgroep, dataTable) {
    let expected = {};
    setPersoonProperties(expected, gegevensgroep, dataTable);

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];
    if(expectedPersoon[relaties] === undefined) {
        expectedPersoon[relaties] = [];
    }
    expectedPersoon[relaties].push(expected);
}

Then(/^heeft de persoon een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function (gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable);

    let groep = toCollectionName(gegevensgroep);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];
    if(expectedPersoon[groep] === undefined) {
        expectedPersoon[groep] = [];
    }
    expectedPersoon[groep].push(expected);
});

Then(/^heeft (?:de|het) '(.*)' ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.expected === undefined) {
        console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
        return 'pending';
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    const relaties = toCollectionName(relatie);
    let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
    expectedRelatie[gegevensgroep] = expected;
});

Then(/^heeft (?:de|het) '(.*)' een leeg '(.*)' object$/, function(relatie, gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    const expected = {};

    if(this.context.expected === undefined) {
        console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon een '${relatie}' met alleen de volgende gegevens"`);
        return 'pending';
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    const relaties = toCollectionName(relatie);
    let expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
    expectedRelatie[gegevensgroep] = expected;
});

Then(/^heeft de '(.*)' GEEN '(.*)' gegevens$/, function (_relatie, _gegevensgroep) {
    // do nothing
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    const expected = createObjectFrom(dataTable);

    if(this.context.expected === undefined) {
        this.context.expected = expected;
    }
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    const expected = dataTable.hashes();

    this.context.expected[gegevensgroep] = expected;
});

Then(/^heeft de response een persoon met een '([a-zA-Z]*)' met een '([a-zA-Z]*)' met een leeg '([a-zA-Z]*)' object$/, function (relatie, gegevensgroep, gegevensgroep2) {
    this.context.leaveEmptyObjects = true;
    let expected = {};
    expected[gegevensgroep] = {};
    expected[gegevensgroep][gegevensgroep2] = {};

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];
    if(expectedPersoon[relaties] === undefined) {
        expectedPersoon[relaties] = [];
    }
    expectedPersoon[relaties].push(expected);
});

Given(/^de persoon heeft geen (?:actuele partner|\(ex\)partner)$/, function () {
    // doe niets
});

Given('de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad', function () {
    // doe niets
});

function createEmptyPersoon() {
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }
}

Then(/^heeft de response een leeg persoon object$/, createEmptyPersoon);

Then(/^heeft de response een persoon zonder gegevens$/, createEmptyPersoon);

function createEmptyGegevensgroepInGegevensgroepCollectie(relatie, gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    let relaties = toCollectionName(relatie);

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersoon = this.context.expected[this.context.expected.length-1];

    if(relaties === undefined) {
        if(expectedPersoon[relatie] === undefined) {
            expectedPersoon[relatie] = {};
        }
        const expectedRelatie = expectedPersoon[relatie];
        expectedRelatie[gegevensgroep] = {};
    }
    else {
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [{}];
        }
    
        const expectedRelatie = expectedPersoon[relaties][expectedPersoon[relaties].length-1];
        expectedRelatie[gegevensgroep] = {};
        }
}

Then(/^heeft de response een persoon met een '(\w*)' met een leeg '(\w*)' object$/, createEmptyGegevensgroepInGegevensgroepCollectie);

Then(/^heeft de response een persoon met een '(\w*)' zonder '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

Then(/^heeft (?:de|het) '(\w*)' geen '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

Then(/^heeft de persoon een '(\w*)' zonder '(\w*)' gegevens$/, createEmptyGegevensgroepInGegevensgroepCollectie);

function createEmptyGegevensgroepOfEmptyGegevensgroepCollectie(relatie) {
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];

    const relaties = toCollectionName(relatie);
    if(relaties === undefined) {
        expectedPersoon[relatie] = {};
    }
    else {
        expectedPersoon[relaties] = [];
    }
}

Then(/^heeft de response een persoon zonder '(\w*)' gegevens$/, createEmptyGegevensgroepOfEmptyGegevensgroepCollectie);

Then(/^heeft de persoon (?:GEEN|geen) '(\w*)' gegevens$/, createEmptyGegevensgroepOfEmptyGegevensgroepCollectie);

function createEmptyObjectInGegevensgroepCollectie(gegevensgroep) {
    this.context.leaveEmptyObjects = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedPersonen = this.context.expected;
    const expectedPersoon = expectedPersonen[expectedPersonen.length-1];

    const relaties = toCollectionName(gegevensgroep);
    if(relaties === undefined) {
        expectedPersoon[gegevensgroep] = {};
    }
    else {
        if(expectedPersoon[relaties] === undefined) {
            expectedPersoon[relaties] = [];
        }
        expectedPersoon[relaties].push({});
    }
}

Then(/^heeft de response een persoon met een '(\w*)' zonder gegevens$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de persoon een '(\w*)' zonder gegevens$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de response een persoon met ?(?:een)? leeg '(.*)' object$/, createEmptyObjectInGegevensgroepCollectie);

Then(/^heeft de persoon GEEN '(\w*)'$/, function (_) {
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
        case 'rni':
            return 'rni';
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
