const should = require('chai').should();

const {
    columnNameMap,
    persoonTypeMap,
    tableNameMap,
    collectionNameMap,
    toCollectieNaam,
    toDbPersoonType,
    toDbTableName,
    toDbColumnName
} = require('../../features/step_definitions/brp.js');

describe('brp.js mapping', () => {
    const testMapFunctie = (map, functie, functieNaam) => {
        describe(`${functieNaam}`, () => {
            test('mapping van key naar value', () => {
                for (const [key, value] of map.entries()) {
                    functie(key).should.equal(value);
                }
            });

            test('onbekende key', () => {
                const onbekendeKey = 'ONBEKENDE_KEY';
                functie(onbekendeKey).should.equal(onbekendeKey);
            });
        });
    };

    testMapFunctie(persoonTypeMap, toDbPersoonType, 'toDbPersoonType');
    testMapFunctie(collectionNameMap, toCollectieNaam, 'toCollectieNaam');
    testMapFunctie(tableNameMap, toDbTableName, 'toDbTableName');
    testMapFunctie(columnNameMap, toDbColumnName, 'toDbColumnName');
});