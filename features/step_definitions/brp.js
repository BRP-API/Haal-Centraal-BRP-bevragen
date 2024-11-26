const persoonTypeMap = new Map([

    ['kind', 'K'],
    ['ouder-1', '1'],
    ['ouder-2', '2'],
    ['partner', 'R'],
    ['persoon', 'P']    

]);

function toDbPersoonType(naam) {
    return persoonTypeMap.has(naam)
        ? persoonTypeMap.get(naam)
        : naam;
}

const collectionNameMap = new Map([
    ['bewoner', 'bewoners'],
    ['bewoning', 'bewoningen'],
    ['derde', 'derden'],
    ['gezagsrelatie', 'gezagsrelaties'],
    ['kind', 'kinderen'],
    ['mogelijkeBewoner', 'mogelijkeBewoners'],
    ['nationaliteit', 'nationaliteiten'],
    ['ouder', 'ouders'],
    ['partner', 'partners'],
    ['persoon', 'personen'],
    ['reisdocument', 'reisdocumenten'],
    ['verblijfplaats', 'verblijfplaatsen'],
    ['verblijfplaats voorkomen', 'verblijfplaatsen']
]);

function toCollectieNaam(naamColObj) {
    return collectionNameMap.has(naamColObj)
        ? collectionNameMap.get(naamColObj)
        : naamColObj;
}

const tableNameMap = new Map([

    ['adres', 'lo3_adres'],
    ['autorisatie', 'lo3_autorisatie'],
    ['geboorte', 'lo3_pl_persoon'],
    ['gemeente', 'lo3_gemeente'],
    ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
    ['immigratie', 'lo3_pl_verblijfplaats'],
    ['inschrijving', 'lo3_pl'],
    ['kiesrecht', 'lo3_pl'],
    ['kind', 'lo3_pl_persoon'],
    ['nationaliteit', 'lo3_pl_nationaliteit'],
    ['ouder', 'lo3_pl_persoon'],
    ['overlijden', 'lo3_pl_overlijden'],
    ['partner', 'lo3_pl_persoon'],
    ['persoon', 'lo3_pl_persoon' ],
    ['protocollering', 'haalcentraal_vraag'],
    ['reisdocument', 'lo3_pl_reis_doc' ],
    ['verblijfplaats', 'lo3_pl_verblijfplaats'],
    ['verblijfstitel', 'lo3_pl_verblijfstitel'],

]);

function toDbTableName(naam) {
    return tableNameMap.has(naam)
        ? tableNameMap.get(naam)
        : naam;
}

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

    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'relatie_start_datum'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'relatie_start_plaats'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', 'relatie_start_land_code'],

    ['datum ontbinding huwelijk/geregistreerd partnerschap (07.10)', 'relatie_eind_datum'],
    ['plaats ontbinding huwelijk/geregistreerd partnerschap (07.20)', 'relatie_eind_plaats'],
    ['land ontbinding huwelijk/geregistreerd partnerschap (07.30)', 'relatie_eind_land_code'],
    ['reden ontbinding huwelijk/geregistreerd partnerschap (07.40)', 'relatie_eind_reden'],

    ['datum overlijden (08.10)', 'overlijden_datum'],
    ['plaats overlijden (08.20)', 'overlijden_plaats'],
    ['land overlijden (08.30)', 'overlijden_land_code'],

    ['gemeente van inschrijving (09.10)', 'inschrijving_gemeente_code'],
    ['datum inschrijving in de gemeente (09.20)', 'inschrijving_datum'],

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
    ['woonplaats (diakrieten)', 'diak_woon_plaats_naam'],
    ['identificatiecode verblijfplaats (11.80)', 'verblijf_plaats_ident_code'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummer_aand_ident_code'],

    ['locatiebeschrijving (12.10)', 'locatie_beschrijving'],
    ['locatiebeschrijving (diakrieten)', 'diak_locatie_beschrijving'],

    ['land (13.10)', 'vertrek_land_code'],
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

    ['soort reisdocument (35.10)', 'nl_reis_doc_soort'],
    ['nummer reisdocument (35.20)', 'nl_reis_doc_nr'],
    ['datum uitgifte Nederlands reisdocument (35.30)', 'nl_reis_doc_uitgifte_datum'],
    ['datum einde geldigheid reisdocument (35.50)', 'nl_reis_doc_geldig_eind_datum'],
    ['datum inhouding dan wel vermissing Nederlands reisdocument (35.60)', 'nl_reis_doc_weg_datum'],
    ['aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70)', 'nl_reis_doc_weg_ind'],

    ['signalering met betrekking tot het verstrekken van een Nederlands reisdocument (36.10)', 'nl_reis_doc_signalering'],

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

    ['aangifte adreshouding (72.10)', 'aangifte_adreshouding_oms' ],

    ['aktenummer (81.20)', 'akte_nr' ],
	
    ['gemeente document (82.10)', 'doc_gemeente_code' ],
    ['datum document (82.20)', 'doc_datum' ],
    ['beschrijving document (82.30)', 'doc_beschrijving' ],

    ['aanduiding in onderzoek (83.10)', 'onderzoek_gegevens_aand' ],
    ['datum ingang onderzoek (83.20)', 'onderzoek_start_datum' ],
    ['datum einde onderzoek (83.30)', 'onderzoek_eind_datum' ],

    ['indicatie onjuist (84.10)', 'onjuist_ind' ],

    ['datum ingang geldigheid (85.10)', 'geldigheid_start_datum'],
    ['ingangsdatum geldigheid (85.10)', 'geldigheid_start_datum' ],

    ['datum van opneming (86.10)', 'opneming_datum' ],

    ['rni-deelnemer (88.10)', 'rni_deelnemer'],
    ['omschrijving verdrag (88.20)', 'verdrag_oms'],

    ['registratie betrekking (89.10)', 'registratie_betrekking'],

    ['gemeentecode (92.10)', 'gemeente_code'],
    ['gemeentenaam (92.11)', 'gemeente_naam'],
    ['nieuwe gemeentecode (92.12)', 'nieuwe_gemeente_code'],
    ['datum beëindiging (99.99)', 'tabel_regel_eind_datum'],

    ['Rubrieknummer ad hoc (35.95.60)', 'ad_hoc_rubrieken'],
    ['Medium ad hoc (35.95.67)', 'ad_hoc_medium'],
    ['Datum ingang (35.99.98)', 'tabel_regel_start_datum'],
    ['Datum beëindiging tabelregel (35.99.99)', 'tabel_regel_eind_datum'],

]);

function toDbColumnName(naam) {
    return columnNameMap.has(naam)
        ? columnNameMap.get(naam)
        : naam;
}

module.exports = {
    columnNameMap,
    persoonTypeMap,
    tableNameMap,
    toCollectieNaam,
    toDbPersoonType,
    toDbTableName,
    toDbColumnName
};
