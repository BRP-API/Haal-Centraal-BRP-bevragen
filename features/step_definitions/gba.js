const { toDateOrString } = require('./calcDate');

const tableNameMap = new Map([
    ['adres', 'lo3_adres'],
    ['autorisatie', 'lo3_autorisatie'],
    ['geboorte', 'lo3_pl_persoon'],
    ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
    ['immigratie', 'lo3_pl_verblijfplaats'],
    ['inschrijving', 'lo3_pl'],
    ['kiesrecht', 'lo3_pl'],
    ['kind', 'lo3_pl_persoon' ],
    ['nationaliteit', 'lo3_pl_nationaliteit'],
    ['ouder', 'lo3_pl_persoon'],
    ['overlijden', 'lo3_pl_overlijden'],
    ['partner', 'lo3_pl_persoon' ],
    ['persoon', 'lo3_pl_persoon' ],
    ['protocollering', 'haalcentraal_vraag'],
    ['verblijfplaats', 'lo3_pl_verblijfplaats'],
    ['verblijfstitel', 'lo3_pl_verblijfstitel'],
]);

const columnNameMap = new Map([

    ['anummer (01.10)', 'a_nr'],
    ['burgerservicenummer (01.20)', 'burger_service_nr' ],

    ['voornamen (02.10)', 'voor_naam' ],
    ['voornamen (diakrieten)', 'diak_voor_naam' ],
    ['adellijke titel of predicaat (02.20)', 'titel_predicaat' ],
    ['voorvoegsel (02.30)', 'geslachts_naam_voorvoegsel' ],
    ['geslachtsnaam (02.40)', 'geslachts_naam' ],
    ['geslachtsnaam (diakrieten)', 'diak_geslachts_naam'],

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
    ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', 'relatie_eind_reden'],

    ['datum overlijden (08.10)', 'overlijden_datum'],
    ['plaats overlijden (08.20)', 'overlijden_plaats'],
    ['land overlijden (08.30)', 'overlijden_land_code'],

    ['gemeente van inschrijving (09.10)', 'inschrijving_gemeente_code'],
    ['datum inschrijving in de gemeente (09.20)', 'inschrijving_datum'],

    ['functieAdres.code (10.10)', 'adres_functie'],
    ['functie adres (10.10)', 'adres_functie'],
    ['datum aanvang adreshouding (10.30)', 'adreshouding_start_datum'],

    ['straatnaam (11.10)', 'straat_naam'],
    ['straatnaam (diakrieten)', 'diak_straat_naam'],
    ['naam openbare ruimte (11.15)', 'open_ruimte_naam'],
    ['naam openbare ruimte (diakrieten)', 'diak_open_ruimte_naam'],
    ['huisnummer (11.20)', 'huis_nr'],
    ['huisletter (11.30)', 'huis_letter'],
    ['huisnummertoevoeging (11.40)', 'huis_nr_toevoeging'],
    ['aanduiding bij huisnummer (11.50)', 'huis_nr_aand'],
    ['postcode (11.60)', 'postcode'],
    ['woonplaats (11.70)', 'woon_plaats_naam'],
    ['identificatiecode verblijfplaats (11.80)', 'verblijf_plaats_ident_code'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummer_aand_ident_code'],

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
	
    ['bijzonder nederlanderschap (65.10)', 'bijzonder_nl_aand'],
    ['bijzonder Nederlanderschap (65.10)', 'bijzonder_nl_aand' ],

    ['Datum ingang blokkering (66.20)', 'pl_blokkering_start_datum'],

    ['datum opschorting bijhouding (67.10)', 'bijhouding_opschort_datum' ],
    ['reden opschorting bijhouding (67.20)', 'bijhouding_opschort_reden'],

    ['datum eerste inschrijving GBA (68.10)', 'gba_eerste_inschrijving_datum'],

    ['indicatie geheim (70.10)', 'geheim_ind'],

    ['datum verificatie (71.10)', 'verificatie_datum'],
    ['omschrijving verificatie (71.20)', 'verificatie_oms'],

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

    ['registratie betrekking (89.10)', 'registratie_betrekking'],
	
    ['gemeentecode (92.10)', 'gemeente_code'],
    ['gemeente_code', 'gemeente_code'],

    ['Rubrieknummer ad hoc (35.95.60)', 'ad_hoc_rubrieken'],
    ['Medium ad hoc (35.95.67)', 'ad_hoc_medium'],
    ['Datum ingang (35.99.98)', 'tabel_regel_start_datum'],
    ['Datum beëindiging tabelregel (35.99.99)', 'tabel_regel_eind_datum'],

]);

function createAutorisatieSettingsFor(afnemerId) {
    return [
        [
            ['afnemer_code', afnemerId ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0],
            ['afnemer_naam', 'Haal Centraal'],
            ['adres_vraag_bevoegdheid', 1],
            ['ad_hoc_medium', 'N'],
            ['tabel_regel_start_datum', 20220101],
            ['ad_hoc_rubrieken', '10110 10120 10210 10220 10230 10240 10310 10320 10330 10410 123510 123520 123530 123550 123560 123570 16110 18110 18120 18210 18220 18230 18510 18610 20110 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 28110 28120 28210 28220 28230 28510 28610 30110 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 38110 38120 38210 38220 38230 38510 38610 40510 46310 46410 46510 48210 48220 48230 48510 48610 50110 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 50720 50730 50740 51510 58110 58120 58210 58220 58230 58510 58610 60810 60820 60830 68110 68120 68210 68220 68230 68510 68610 76710 76720 76810 76910 77010 78710 80910 80920 81010 81020 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 81410 81420 87210 87510 88510 88610 90110 90120 90210 90220 90230 90240 90310 90320 90330 98110 98120 98210 98220 98230 98510 98610 98910 103910 103920 103930 108510 108610 113210 113310 118210 118220 118230 118510 118610 123510 123520 123530 123540 123550 123560 123570 123610 128210 128220 128230 128510 128610 133110 133120 133130 133810 133820 138210 138220 138230 540510 546310 546410 546510 548210 548220 548230 548510 548610 550110 550120 550210 550220 550230 550240 550310 550320 550330 550410 550610 550620 550630 550710 550720 550730 550740 551510 558110 558120 558210 558220 558230 558510 558610 580910 580920 581010 581020 581030 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581320 581330 581340 581350 581410 581420 587210 587510 588510 588610 603910 603920 603930 608510 608610']
        ]
    ];
}

function createAdresseringBinnenlandAutorisatieSettingsFor(afnemerId) {
    return [
        [
            ['afnemer_code', afnemerId ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0],
            ['afnemer_naam', 'Haal Centraal'],
            ['adres_vraag_bevoegdheid', 1],
            ['ad_hoc_medium', 'N'],
            ['tabel_regel_start_datum', 20201128],
            ['ad_hoc_rubrieken', '10120 10240 10310 80910 81110 81120 81130 81140 81150 81160 81170 81210']
        ]
    ];
}

function createVerblijfplaatsBinnenlandAutorisatieSettingsFor(afnemerId) {
    return [
        [
            ['afnemer_code', afnemerId ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0],
            ['afnemer_naam', 'Haal Centraal'],
            ['adres_vraag_bevoegdheid', 1],
            ['ad_hoc_medium', 'N'],
            ['tabel_regel_start_datum', 20201128],
            ['ad_hoc_rubrieken', '10120 81010 81030 80910 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510']
        ]
    ];
}

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
                    requestBody[param.naam] = toDateOrString(param.waarde, true);
                }
            });

    return requestBody;
}

function createBasicAuthorizationHeader(afnemerId, gemeenteCode) {
    return [
        { "naam": "Authorization", "waarde": "Basic " + Buffer.from(`${afnemerId}|${gemeenteCode}:tempsolution!`).toString('base64') }
    ]
}

module.exports = {
    tableNameMap,
    columnNameMap,
    createAutorisatieSettingsFor,
    createRequestBody,
    createBasicAuthorizationHeader,
    createAdresseringBinnenlandAutorisatieSettingsFor,
    createVerblijfplaatsBinnenlandAutorisatieSettingsFor
}
