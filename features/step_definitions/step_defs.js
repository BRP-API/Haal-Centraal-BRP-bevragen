const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const axios = require('axios').default;
const fs = require('fs');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

setWorldConstructor(World);

const propertyNameMap = new Map([
    ['aanduiding bij huisnummer (11.50)', 'aanduidingBijHuisnummer.code'],
    ['aanduiding naamgebruik (61.10)', 'aanduidingNaamgebruik.code'],
    ['aanduiding verblijfstitel (39.10)', 'aanduiding.code'],
    ['adellijke titel of predicaat (02.20)', 'adellijkeTitelPredicaat.code'],
    ['adresregel1 (13.30)', 'adresregel1'],
    ['adresregel2 (13.40)', 'adresregel2'],
    ['adresregel3 (13.50)', 'adresregel3'],
    ['anummer (01.10)', 'aNummer'],
    ['datum (03.10)', 'datum'],
    ['datum aangaan (06.10)', 'datum'],
    ['datumAanvangAdreshouding (10.30)', 'datumAanvangAdreshouding'],
    ['datumAanvangAdresBuitenland (13.20)', 'datumAanvangAdresBuitenland'],
    ['datum eerste inschrijving GBA (68.10)', 'datumEersteInschrijvingGBA'],
    ['datum einde verblijfstitel (39.20)', 'datumEinde'],
    ['datum ingang verblijfstitel (39.30)', 'datumIngang'],
    ['datumInschrijvingInGemeente (09.20)', 'datumInschrijvingInGemeente'],
    ['datum opschorting bijhouding (67.10)', 'datum'],
    ['datum overlijden (08.10)', 'datum'],
    ['functieAdres (10.10)', 'functieAdres.code'],
    ['geboorteland (03.30)', 'land.code'],
    ['geboorteplaats (03.20)', 'plaats.code'],
    ['gemeente van inschrijving (09.10)', 'gemeenteVanInschrijving.code'],
    ['gemeenteVanInschrijving (09.10)', 'gemeenteVanInschrijving.code'],
    ['geslachtsaanduiding (04.10)', 'geslachtsaanduiding.code'],
    ['geslachtsnaam (02.40)', 'geslachtsnaam'],
    ['huisletter (11.30)', 'huisletter'],
    ['huisnummer (11.20)', 'huisnummer'],
    ['huisnummertoevoeging (11.40)', 'huisnummertoevoeging'],
    ['land (13.10)', 'land.code'],
    ['locatiebeschrijving (12.10)', 'locatiebeschrijving'],
    ['plaats overlijden (08.20)', 'plaats.code'],
    ['land overlijden (08.30)', 'land.code'],
    ['postcode (11.60)', 'postcode'],
    ['regel 1 adres buitenland (13.30)', 'adresregel1'],
    ['regel 2 adres buitenland (13.40)', 'adresregel2'],
    ['regel 3 adres buitenland (13.50)', 'adresregel3'],
    ['gemeente van inschrijving (09.10)', 'gemeenteVanInschrijving.code'],
    ['land adres buitenland (13.10)', 'land.code'],
    ['naam openbare ruimte (11.15)', 'naamOpenbareRuimte'],
    ['soort verbintenis (15.10)', 'soortVerbintenis.code'],
    ['straatnaam (11.10)', 'straat'],
    ['voornamen (02.10)', 'voornamen'],
    ['voorvoegsel (02.30)', 'voorvoegsel'],
    ['woonplaatsnaam (11.70)', 'woonplaats']
]);

function mapRowToProperty(obj, row) {
    let propertyName = propertyNameMap.get(row.naam);
    if(propertyName === undefined) {
        propertyName = row.naam;
    }

    setProperty(obj, propertyName, row.waarde);
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

function setProperty(obj, propertyName, propertyValue) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        let propertyNames = propertyName.split('.');
        let property = obj;

        propertyNames.forEach(function(propName, index) {
            if(index === propertyNames.length-1) {
                property[propName] = String(propertyValue); 
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
        obj[propertyName] = String(propertyValue);
    }
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
    
    let expected = deleteEmptyProperties(this.context.expected);
    if(expected === undefined) {
        expected = [];
    }
    
    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, "\t")}`);
});

Given('het systeem heeft een persoon met de volgende gegevens', function (dataTable) {
    if(this.context.persoon.burgerservicenummer !== undefined) {
        this.context.zoekResponse.personen.push(this.context.persoon);
        this.context.persoon = {};
    }
    let persoon = this.context.persoon;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(persoon, row);
    });
});

Given('het systeem heeft personen met de volgende gegevens', function (dataTable) {
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

Given('de persoon heeft de volgende gegevens', function (dataTable) {
    let persoon = this.context.persoon;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(persoon, row);
    });
});

Given('de persoon heeft de volgende {string} gegevens', function (gegevensgroep, dataTable) {
    setPersoonProperties(this.context.persoon, gegevensgroep, dataTable);
});

Given('het systeem heeft personen met de volgende {string} gegevens', function (gegevensgroep, dataTable) {
    setPersonenProperties(this.context.zoekResponse.personen, gegevensgroep, dataTable);
});

Given('de persoon heeft nooit een actueel of ontbonden huwelijk of partnerschap gehad', function () {
});

Given('de persoon heeft geen partner', function () {
});

Given('de persoon heeft geen actuele partner', function () {
});

Given('de persoon heeft een actuele partner met adellijke titel', function () {
});

Given('de persoon heeft een ontbonden partner met adellijke titel', function () {
});

Given('de persoon heeft een actuele partner met predikaat', function () {
});

Given('de persoon heeft een ontbonden partner met predikaat', function () {
});

Given('de persoon heeft een partner met de volgende gegevens', function (dataTable) {
    if(this.context.persoon.partners === undefined) {
        this.context.persoon.partners = [];
    }
    if(this.context.partner !== undefined) {
        this.context.persoon.partners.push(this.context.partner);
    }
    this.context.partner = {};
    let partner = this.context.partner;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(partner, row);
    });
});

Given(/^de persoon heeft een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function (gegevensgroep, dataTable) {
    let groepCollectie = toCollectionName(gegevensgroep);

    if(this.context.persoon[groepCollectie] === undefined) {
        this.context.persoon[groepCollectie] = [];
    }
    if(this.context[gegevensgroep] !== undefined) {
        this.context.persoon[groepCollectie].push(this.context[gegevensgroep]);
    }
    this.context[gegevensgroep] = {};
    let relatie = this.context[gegevensgroep];

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(relatie, row);
    });
});

Given(/^(?:de|het) '(.*)' heeft ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    if(this.context[relatie] === undefined) {
        this.context[relatie] = {};
    }

    setPersoonProperties(this.context[relatie], gegevensgroep, dataTable);
});

Given('de partner heeft de volgende {string} gegevens', function (gegevensgroep, dataTable) {
    setPersoonProperties(this.context.partner, gegevensgroep, dataTable);
});

Given('de partner heeft de volgende aangaanHuwelijkPartnerschap gegevens', function (dataTable) {
    if(this.context.partner.aangaanHuwelijkPartnerschap === undefined) {
        this.context.partner.aangaanHuwelijkPartnerschap = {};
    }
    if(this.context.partner !== undefined) {
        this.context.persoon.partners.push(this.context.partner);
    }
    this.context.partner = {};
    let partner = this.context.partner;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(partner, row);
    });
});

Given('de partner heeft de volgende naam gegevens', function (dataTable) {
    if(this.context.partner.naam === undefined) {
        this.context.partner.naam = {};
    }
    let naam = this.context.partner.naam;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(naam, row);
    });
});

function determineDataPath(baseDataPath, config) {
    switch(config.data.type) {
        case "RaadpleegMetBurgerservicenummer":
            return `${baseDataPath}/bsn.json`;
        case "ZoekMetGeslachtsnaamEnGeboortedatum":
            return `${baseDataPath}/geslachtsnaam-geboortedatum.json`;
        case "ZoekMetNaamEnGemeenteVanInschrijving":
            return `${baseDataPath}/naam-gemeentevaninschrijving.json`;
        case "ZoekMetPostcodeEnHuisnummer":
            return `${baseDataPath}/postcode-huisnummer.json`;
        default:
            console.log(`Onbekend zoek type: ${config.data.type}`);
            return '';
    }
}

function addToCollection(collection, toAdd) {
    if(collection !== undefined && toAdd !== undefined) {
        collection.push(toAdd);
    }
}

When('personen wordt gezocht met de volgende parameters', async function (dataTable) {
    let requestBody = {};
    dataTable.hashes().forEach(function(param) {
        if(param.naam === "burgerservicenummer") {
            requestBody[param.naam] = param.waarde.split(',').filter(element => element);
        }
        else {
            requestBody[param.naam] = param.waarde;
        }
    });

    const config = {
        method: 'post',
        url: '/personen',
        baseURL: this.context.serverUrl,
        data: requestBody
    };

    ["partner", "ouder", "nationaliteit", "kind"]
        .forEach((relatie) => addToCollection(this.context.persoon[toCollectionName(relatie)], this.context[relatie]));

    this.context.zoekResponse.personen.push(this.context.persoon);
    this.context.zoekResponse.type = config.data.type;

    const path = determineDataPath(this.context.dataPath, config);
    fs.writeFileSync(path, JSON.stringify(this.context.zoekResponse, null, "\t"));

    try {
        this.context.response = await axios(config);
    }
    catch(e) {
        this.context.response = e.response;
    }
});

Then('bevat de response alleen personen met de volgende gegevens', function (dataTable) {
    const personen = this.context.response.data.personen;

    console.log(personen);
    personen.length.should.equal(dataTable.hashes().length, `aantal personen in response ${personen.length} is ongelijk aan aantal expected ${dataTable.hashes().length}\npersonen: ${JSON.stringify(personen, null, "\t")}`);

    dataTable.hashes().forEach(function(value) {
        const persoon = personen.find(function(p){
            return p.burgerservicenummer === value.burgerservicenummer;
        });
        should.exist(persoon, `geen persoon gevonden met bsn: ${value.burgerservicenummer}\npersonen: ${JSON.stringify(personen, null, "\t")}`)

        for(const [key, expected] of Object.entries(value)) {
            let actual = String(persoon[key]);

            actual.should.equal(expected, `geen persoon gevonden met ${key}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        }
    });
});

Then('bevat de response een persoon met de volgende gegevens', function (dataTable) {
    const persoon = this.context.response.data;

    should.exist(persoon, `geen persoon gevonden\nresponse payload: ${JSON.stringify(persoon, null, "\t")}`)

    dataTable.hashes().forEach(function(row) {
        const actual = String(persoon[row.naam]);
        const expected = row.waarde;

        actual.should.equal(expected, `geen persoon gevonden met ${row.naam}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
    });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende geboorte datum', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(value) {
        for(const [key, expected] of Object.entries(value)) {
            let actual = String(persoon.geboorte.datum[key]);

            actual.should.equal(expected, `geen geboortedatum gevonden met ${key}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        }
   });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende naam gegevens', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(row) {
        let actual = String(persoon.naam[row.naam]);
        const expected = row.waarde;

        actual.should.equal(expected, `geen persoon gevonden met ${row.naam}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
    });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende geboorte gegevens', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(row) {
        let obj = persoon.geboorte;

        let propertyNames = row.naam.split('.');
        propertyNames.forEach(function(propertyName, index) {
            obj = obj[propertyName];
        });
        let actual = String(obj);
        const expected = row.waarde;

        actual.should.equal(expected, `geen persoon gevonden met ${row.naam}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
   });
});

Then('heeft de response de volgende gegevens', function (dataTable) {
    const data = this.context.response.data;

    dataTable.hashes().forEach(function(value){
        let expected = value.waarde;
        let actual = String(data[value.naam]);

        actual.should.equal(expected, JSON.stringify(data, null, "\t"));
    });
});

Then('heeft de response een invalidParams met de volgende gegevens', function (dataTable) {  
    const invalidParams = this.context.response.data.invalidParams;
    
    dataTable.hashes().forEach(function(expected) {
        const actual = invalidParams.find(function(invalidParam) {
            return invalidParam.name === expected.name &&
                   invalidParam.code === expected.code &&
                   invalidParam.reason.replace(/\/\//g, "/") === expected.reason;
        });
        should.exist(actual, `geen invalidParam gevonden met name '${expected.name}', code '${expected.code}', reason '${expected.reason}'\n${JSON.stringify(invalidParams, null, "\t")}`);
    });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende verblijfplaats gegevens', function (burgerservicenummer, dataTable) {
    let persoon;
    if(this.context.response.data._embedded !== undefined) {
        const personen = this.context.response.data._embedded.personen;
        persoon = personen.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
    }
    else {
        persoon = this.context.response.data;
    }

    dataTable.hashes().forEach(function(row) {
        let actual = String(persoon.verblijfplaats[row.naam]);

        actual.should.equal(row.waarde, `geen verblijf gegeven '${row.naam}' gevonden met waarde '${row.waarde}'\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
    });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende verblijfplaats gegevens NIET', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(row) {
        let actual = persoon.verblijfplaats[row.naam];

        should.not.exist(actual, `verblijf gegeven '${row.naam}' gevonden\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
    });
});

Then('bevat de response geen personen', function () {
    const personen = this.context.response.data.personen;

    personen.length.should.equal(0);
});


Then('heeft de persoon met burgerservicenummer {string} de volgende {string} gegevens NIET', function (burgerservicenummer, gegevensgroep, dataTable) {
    const personen = this.context.response.data.personen;
    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });
    const obj = persoon[gegevensgroep];
    should.exist(obj, `geen gegevensgroep '${gegevensgroep}' gevonden.\npersoon: ${JSON.stringify(persoon, null, "\t")}`)

    dataTable.hashes().forEach(function(row) {
        let actual = obj[row.naam];

        should.not.exist(actual, `${gegevensgroep} gegeven '${row.naam}' gevonden.'\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
    });
});

Then('heeft de partner met burgerservicenummer {string} de volgende {string} gegevens NIET', function (burgerservicenummer, gegevensgroep, dataTable) {
    const personen = this.context.response.data.personen;
    const persoon = personen.find(function(person) {
        return person.partners.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
    });
    should.exist(persoon, `geen persoon met partner met bsn '${burgerservicenummer}' gevonden.\npersonen: ${JSON.stringify(personen, null, "\t")}`);
    const partner = persoon.partners.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });
    const obj = gegevensgroep !== undefined && gegevensgroep !== ''
        ? partner[gegevensgroep]
        : partner;
    should.exist(obj, `geen gegevensgroep '${gegevensgroep}' gevonden.\npartner: ${JSON.stringify(partner, null, "\t")}`)

    dataTable.hashes().forEach(function(row) {
        let actual = obj[row.naam];

        should.not.exist(actual, `${gegevensgroep} gegeven '${row.naam}' gevonden.'\npartner: ${JSON.stringify(partner, null, "\t")}`);
    });
});

Then('heeft de persoon met burgerservicenummer {string} geen {string} gegevens', function (burgerservicenummer, gegevensgroep) {  
    const personen = this.context.response.data.personen;
    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });
    const obj = persoon[gegevensgroep];
    should.not.exist(obj, `gegevensgroep '${gegevensgroep}' gevonden.\npersoon: ${JSON.stringify(persoon, null, "\t")}`)
});

Then('heeft de persoon met burgerservicenummer {string} alleen {string} met de volgende gegevens', function (burgerservicenummer, gegevensgroep, dataTable) {
    const personen = this.context.response.data.personen;
    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });
    const collectie = persoon[gegevensgroep];

    collectie.length.should.equal(dataTable.hashes().length, `aantal ${gegevensgroep} in response ${collectie.length} is ongelijk aan aantal expected ${dataTable.hashes().length}\npersonen: ${JSON.stringify(personen, null, "\t")}`);

    dataTable.hashes().forEach(function(value) {
        const obj = collectie.find(function(o){
            return o.burgerservicenummer === value.burgerservicenummer;
        });
        should.exist(obj, `geen ${gegevensgroep} gevonden met bsn: ${value.burgerservicenummer}\npersonen: ${JSON.stringify(personen, null, "\t")}`)
    
        for(const [key, expected] of Object.entries(value)) {
            let actual = String(obj[key]);

            actual.should.equal(expected, `geen ${gegevensgroep} gevonden met ${key}: ${expected}\n${gegevensgroep}: ${JSON.stringify(obj, null, "\t")}`);
        }
    });
});

Then('heeft de persoon met burgerservicenummer {string} GEEN {string}', function (burgerservicenummer, gegevensgroep) {
    const personen = this.context.response.data.personen;
    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });
    const collectie = persoon[gegevensgroep];

    should.not.exist(collectie, `${gegevensgroep} gevonden\npersonen: ${JSON.stringify(personen, null, "\t")}`);
});

Then('zoekt de proxy de persoon bij RvIG met de volgende parameters', function (dataTable) {
    const path = `${this.context.dataPath}/requestBody.json`;
    const requestBody = JSON.parse(fs.readFileSync(path));
    const expected = dataTable.hashes().find(function(kvp) {
        return kvp.naam === "fields"
    }).waarde; 
    const expectedFields = expected.split(',');
    const actual = requestBody.fields.split(',');
    actual.length.should.equal(expectedFields.length, `fields in RvIG aanroep '${requestBody.fields}' ongelijk aan ${expected}`);

    actual.should.have.all.members(expectedFields);
});

Then('heeft de response alleen een persoon met een partner met de volgende gegevens', function (dataTable) {        
    const personen = this.context.response.data.personen;
    personen.length.should.equal(1);

    const actual = personen[0];
    console.log(JSON.stringify(actual));

    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });
    console.log(expected);
});

Then(/^heeft de response (\d*) (persoon|personen)$/, function (aantal, dummy) {
    const personen = this.context.response.data.personen;

    personen.length.should.equal(Number(aantal), `aantal personen in response is ongelijk aan ${aantal}\nPersonen:${JSON.stringify(personen, null, "\t")}`);
});

Then('heeft de response een persoon met de volgende gegevens', function (dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [];
        }
        this.context.expected.push(expected); 
    }
});

Then('heeft de persoon de volgende {string} gegevens', function (gegevensgroep, dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
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

Then(/^heeft de persoon met burgerservicenummer '(.*)' ?(?:alleen)? de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [];
        }
        this.context.expected.push(expected); 
    }
    else {
        const personen = this.context.response.data.personen;
        const persoon = personen.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
    
        persoon.should.deep.equalInAnyOrder(expected);
    }
});

Then(/^heeft de persoon met burgerservicenummer '(.*)' ?(?:alleen)? de volgende '(.*)' gegevens$/, function (burgerservicenummer, gegevensgroep, dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ { burgerservicenummer: burgerservicenummer } ];
        }

        const expectedPersonen = this.context.expected;
        const expectedPersoon = expectedPersonen.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
        expectedPersoon[gegevensgroep] = expected;
    }
    else {
        const personen = this.context.response.data.personen;
        const persoon = personen.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
        should.exist(persoon, `geen persoon met '${burgerservicenummer}' gevonden.\npersonen: ${JSON.stringify(personen, null, "\t")}`);

        const obj = persoon[gegevensgroep];
        should.exist(obj, `geen gegevensgroep '${gegevensgroep}' gevonden.\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        Object.keys(obj).length.should.equal(dataTable.hashes().length, `aantal ${gegevensgroep} properties (${Object.keys(obj).length}) is ongelijk aan aantal verwachte properties ${dataTable.hashes().length}\npersonen: ${JSON.stringify(personen, null, "\t")}`);

        dataTable.hashes().forEach(function(row) {
            const actual = String(getProperty(obj, row.naam));

            actual.should.equal(row.waarde, `geen ${gegevensgroep} gegeven '${row.naam}' gevonden met waarde '${row.waarde}'\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        });
    }
});

Then(/^heeft de persoon met burgerservicenummer '(.*)' een '(.*)' met ?(?:alleen)? de volgende gegevens$/, function (burgerservicenummer, gegevensgroep, dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

    let groep = toCollectionName(gegevensgroep);

    if(this.context.postAssert === true) {
        if(this.context.expected === undefined) {
            this.context.expected = [ { burgerservicenummer: burgerservicenummer } ];
        }

        const expectedPersonen = this.context.expected;
        const expectedPersoon = expectedPersonen.find(function(p) {
            return p.burgerservicenummer === burgerservicenummer;
        });
        if(expectedPersoon[groep] === undefined) {
            expectedPersoon[groep] = [];
        }
        expectedPersoon[groep].push(expected);
    }
});

Then(/^heeft (?:de|het) '(.*)' ?(?:alleen)? de volgende '(.*)' gegevens$/, function (relatie, gegevensgroep, dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

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

Then('heeft de response een object met de volgende gegevens', function (dataTable) {
    let expected = {};
    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(expected, row);
    });

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

Then('heeft het object de volgende {string} gegevens', function (gegevensgroep, dataTable) {
    let expected = dataTable.hashes();

    if(this.context.postAssert === true) {
        this.context.expected[gegevensgroep] = expected;
    }
    else {
        const actual = this.context.response.data[gegevensgroep];

        actual.should.deep.equalInAnyOrder(expected);
    }
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
