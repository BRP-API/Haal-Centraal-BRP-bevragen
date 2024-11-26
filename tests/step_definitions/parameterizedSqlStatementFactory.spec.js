const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { deleteStatement,
        insertIntoAdresStatement,
        insertIntoAutorisatieStatement,
        insertIntoGemeenteStatement,
        insertIntoPersoonlijstStatement, 
        insertIntoStatement,
        queryRowCountStatement,
        queryLastRowStatement} = require('../../features/step_definitions/parameterizedSqlStatementFactory');

function validate(actual, expected) {
    actual.text.should.equal(expected.text);
    actual.values.should.deep.equalInAnyOrder(expected.values);
}

describe('deleteStatement', () => {

    test.each(
        [
            ['adres', 'lo3_adres'],
            ['autorisatie', 'lo3_autorisatie'],
            ['gemeente', 'lo3_gemeente'],
            ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
            ['inschrijving', 'lo3_pl'],
            ['nationaliteit', 'lo3_pl_nationaliteit'],
            ['overlijden', 'lo3_pl_overlijden'],
            ['persoon', 'lo3_pl_persoon'],
            ['protocollering', 'haalcentraal_vraag'],
            ['reisdocument', 'lo3_pl_reis_doc'],
            ['verblijfplaats', 'lo3_pl_verblijfplaats'],
            ['verblijfstitel', 'lo3_pl_verblijfstitel']
        ])("voor alle rijen in tabel", (naam, tabelNaam) => {
        const expected = {
            text: `DELETE FROM public.${tabelNaam}`,
            values: []
        };
    
        validate(deleteStatement(naam), expected);
    });

    test.each(
        [
            ['adres', 'lo3_adres', 'adres_id'],
            ['autorisatie', 'lo3_autorisatie', 'afnemer_code'],
            ['gemeente', 'lo3_gemeente', 'gemeente_code'],
            ['gezagsverhouding', 'lo3_pl_gezagsverhouding', 'pl_id'],
            ['inschrijving', 'lo3_pl', 'pl_id'],
            ['nationaliteit', 'lo3_pl_nationaliteit', 'pl_id'],
            ['overlijden', 'lo3_pl_overlijden', 'pl_id'],
            ['persoon', 'lo3_pl_persoon', 'pl_id'],
            ['reisdocument', 'lo3_pl_reis_doc', 'pl_id'],
            ['verblijfplaats', 'lo3_pl_verblijfplaats', 'pl_id'],
            ['verblijfstitel', 'lo3_pl_verblijfstitel', 'pl_id']
        ])("voor specifieke rij in tabel", (naam, tabelNaam, kolomNaam) => {
        const expected = {
            text: `DELETE FROM public.${tabelNaam} WHERE ${kolomNaam}=$1`,
            values: [1]
        };
    
        validate(deleteStatement(naam, 1), expected);
    });
});

describe('insertIntoAdresStatement', () => {

    test("", () => {
        const input = [
            ["straat_naam", "Spui"]
        ];
        const expected = {
            text: 'INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *',
            values: ['Spui']
        };
    
        validate(insertIntoAdresStatement(input), expected);
    });
});

describe('insertIntoAutorisatieStatement', () => {

    test("", () => {
        const input = [
            ['geheimhouding_ind', 0]
        ];
        const expected = {
            text: 'INSERT INTO public.lo3_autorisatie(autorisatie_id,geheimhouding_ind) VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie),$1) RETURNING *',
            values: [0]
        };
    
        validate(insertIntoAutorisatieStatement(input), expected);
    });
});

describe('insertIntoGemeenteStatement', () => {

    test("", () => {
        const input = [
                        ["gemeente_code", "9999"]
                    ];
        const expected = {
            text: 'INSERT INTO public.lo3_gemeente(gemeente_code) VALUES($1)',
            values: ['9999']
        };
    
        validate(insertIntoGemeenteStatement(input), expected);
    });
});

describe('insertIntoPersoonlijstStatement', () => {

    test("", () => {
        const input = [
                        ["geheim_ind", "0"]
                    ];
        const expected = {
            text: 'INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *',
            values: ['0']
        }
    
        validate(insertIntoPersoonlijstStatement(input), expected);
    });
});

describe('insertIntoStatement', () => {

    test.each(
        [
            ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
            ['nationaliteit', 'lo3_pl_nationaliteit'],
            ['gezag', 'gezag'] // niet bestaand tabel
        ]
    )("",  (naam, tabelNaam) => {
        const input = [
            ["pl_id", 1]
        ];
        const expected = {
            text: `INSERT INTO public.${tabelNaam}(pl_id) VALUES($1)`,
            values: [1]
        };

        validate(insertIntoStatement(naam, input), expected);
    });

    test('met meerdere input parameters', () => {
        const input = [
            ["pl_id", 1],
            ["geslachts_naam", "Jansen"]
        ];
        const expected = {
            text: `INSERT INTO public.lo3_pl_persoon(pl_id,geslachts_naam) VALUES($1,$2)`,
            values: [1, 'Jansen']
        };

        validate(insertIntoStatement('persoon', input), expected);
    });
});

describe('queryRowCountStatement', () => {

    test('zonder where filter', () => {
        const expected = {
            text: "SELECT COUNT(*) FROM public.lo3_pl",
            values: []
        };

        validate(queryRowCountStatement("inschrijving"), expected);
    });

    test('met where filter', () => {
        const whereFilter = {
            pl_id: 1
        };
        const expected = {
            text: "SELECT COUNT(*) FROM public.haalcentraal_vraag WHERE pl_id=$1",
            values: [1]
        };

        validate(queryRowCountStatement("protocollering", whereFilter), expected);
    });

    test('met meerdere where filter clauses', () => {
        const whereFilter = {
            pl_id: 1,
            verwerkt: true
        };
        const expected = {
            text: "SELECT COUNT(*) FROM public.haalcentraal_vraag WHERE pl_id=$1 AND verwerkt=$2",
            values: [1, true]
        };

        validate(queryRowCountStatement("protocollering", whereFilter), expected);
    });
});

describe('queryLastRowStatement', () => {

    test('zonder where filter', () => {
        const expected = {
            text: "SELECT * FROM public.haalcentraal_vraag ORDER BY request_datum DESC LIMIT 1",
            values: []
        };

        validate(queryLastRowStatement("protocollering", 'request_datum'), expected);
    });

    test('met where filter', () => {
        const whereFilter = {
            pl_id: 1
        };
        const expected = {
            text: "SELECT * FROM public.haalcentraal_vraag WHERE pl_id=$1 ORDER BY request_datum DESC LIMIT 1",
            values: [1]
        };

        validate(queryLastRowStatement("protocollering", 'request_datum', whereFilter), expected);
    });
});
