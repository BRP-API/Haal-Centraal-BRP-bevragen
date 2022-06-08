const { World } = require('./world');
const { dagRegex, maandRegex, jaarRegex, toGbaDate, toHcDate } = require('./calcDate');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const axios = require('axios').default;
const fs = require('fs');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

setWorldConstructor(World);

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

function getColumns(dataTable) {
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
    const columns = getColumns(dataTable);

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
    if(context.persoon.burgerservicenummer !== undefined) {
        ["partner", "ouder", "nationaliteit", "kind"]
        .forEach((relatie) => addToCollection(context.persoon[toCollectionName(relatie)], context[relatie]));

        context.zoekResponse.personen.push(context.persoon);
        context.persoon = {};
    }
}

Given(/^het systeem heeft een persoon met de volgende gegevens$/, function (dataTable) {
    addPersoonToPersonen(this.context);

    this.context.persoon = createObjectFrom(dataTable);
});

Given(/^het systeem heeft personen met de volgende gegevens$/, function (dataTable) {
    addPersoonToPersonen(this.context);

    const columns = getColumns(dataTable);
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

Given(/^de persoon heeft de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    setPersoonProperties(this.context.persoon, gegevensgroep, dataTable);

    this.context.attach(`${gegevensgroep}: ${JSON.stringify(this.context.persoon[gegevensgroep], null, '  ')}`);
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

Given(/^de persoon heeft een '?(?:ex-)?(.*)' met ?(?:alleen)? de volgende gegevens$/, function (relatie, dataTable) {
    let relatieCollectie = toCollectionName(relatie);

    if(this.context.persoon[relatieCollectie] === undefined) {
        this.context.persoon[relatieCollectie] = [];
    }
    if(this.context[relatie] !== undefined) {
        this.context.persoon[relatieCollectie].push(this.context[relatie]);
    }
    this.context[relatie] = createObjectFrom(dataTable);

    this.context.attach(`${relatie}: ${JSON.stringify(this.context[relatie], null, '  ')}`);
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

Given(/^(?:de|het) '?(?:ex-)?(.*)' heeft ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
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
                    requestBody[param.naam] = param.waarde;
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

Then(/^heeft de response een persoon met een '(.*)' met ?(?:alleen)? de volgende '(.*)' gegevens$/, function(relatie, gegevensgroep, dataTable) {
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
});

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
            console.log(`creeer eerst een '${relatie}' met "Dan heeft de persoon met burgerservicenummer '' een '${relatie}' met alleen de volgende gegevens"`);
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
            return gegevensgroep;
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
