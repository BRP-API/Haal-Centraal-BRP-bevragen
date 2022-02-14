const { World } = require('./world');
const { Given, When, Then, setWorldConstructor } = require('@cucumber/cucumber');
const axios = require('axios').default;
const fs = require('fs');
const should = require('chai').should();

setWorldConstructor(World);

const propertyNameMap = new Map([
    ['aanduiding bij huisnummer (11.50)', 'aanduidingBijHuisnummer.code'],
    ['adellijke titel of predikaat (02.20)', 'adellijkeTitelPredikaat.code'],
    ['geslachtsnaam (02.40)', 'geslachtsnaam'],
    ['huisletter (11.30)', 'huisletter'],
    ['huisnummer (11.20)', 'huisnummer'],
    ['huisnummertoevoeging (11.40)', 'huisnummertoevoeging'],
    ['locatiebeschrijving (12.10)', 'locatiebeschrijving'],
    ['postcode (11.60)', 'postcode'],
    ['regel 1 adres buitenland (13.30)', 'adresregel1'],
    ['regel 2 adres buitenland (13.40)', 'adresregel2'],
    ['regel 3 adres buitenland (13.50)', 'adresregel3'],
    ['gemeente van inschrijving (09.10)', 'gemeenteVanInschrijving'],
    ['land adres buitenland (13.10)', 'land.code'],
    ['naam openbare ruimte (11.15)', 'naamOpenbareRuimte'],
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

    if(row.waarde !== undefined && row.waarde !== '') {
        if(propertyName.includes('.')) {
            let propertyNames = propertyName.split('.');
            let property = obj;

            propertyNames.forEach(function(propertyName, index) {
                if(index === propertyNames.length-1) {
                    property[propertyName] = String(row.waarde); 
                }
                else {
                    if(property[propertyName] === undefined) {
                        property[propertyName] = {};
                    }
                    property = property[propertyName];
                }
            });
        }
        else {
            obj[propertyName] = String(row.waarde);
        }
    }
}

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

Given('de persoon heeft de volgende geboorte gegevens', function (dataTable) {
    if(this.context.persoon.geboorte === undefined) {
        this.context.persoon.geboorte = {};
    }
    let geboorte = this.context.persoon.geboorte;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(geboorte, row);
    });
});

Given('de persoon heeft de volgende naam gegevens', function (dataTable) {
    if(this.context.persoon.naam === undefined) {
        this.context.persoon.naam = {};
    }
    let naam = this.context.persoon.naam;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(naam, row);
    });
});

Given('de persoon heeft de volgende verblijfplaats gegevens', function (dataTable) {
    if(this.context.persoon.verblijfplaats === undefined) {
        this.context.persoon.verblijfplaats = {
            type: 'GbaVerblijfplaats'
        };
    }
    let verblijfplaats = this.context.persoon.verblijfplaats;

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(verblijfplaats, row);
    });
});

Given('de waardetabel {string} heeft de volgende waarden', function (string, dataTable) {
    // Write code here that turns the phrase above into concrete actions
    return 'pending';
});

function determineDataPath(baseDataPath, config) {
    switch(config.data.type) {
        case "RaadpleegMetBurgerservicenummer":
            return config.data.burgerservicenummer !== undefined
                ? `${baseDataPath}/bsn-${config.data.burgerservicenummer.join("-")}.json`
                : `${baseDataPath}/bsn.json`;
        case "ZoekMetGeslachtsnaamEnGeboortedatum":
            return config.data.geslachtsnaam !== undefined &&
                   config.data.geboortedatum !== undefined
                 ? `${baseDataPath}/geslachtsnaam-geboortedatum-${config.data.geslachtsnaam}-${config.data.geboortedatum}.json`
                 : `${baseDataPath}/geslachtsnaam-geboortedatum.json`;
        case "ZoekMetGeslachtsnaamEnGemeenteVanInschrijving":
            return config.data.geslachtsnaam !== undefined &&
                   config.data.gemeenteVanInschrijving !== undefined
                 ? `${baseDataPath}/geslachtsnaam-gemeente-${config.data.geslachtsnaam}-${config.data.gemeenteVanInschrijving}.json`
                 : `${baseDataPath}/geslachtsnaam-gemeente.json`;
        case "ZoekMetPostcodeEnHuisnummer":
            return config.data.postcode !== undefined &&
                   config.data.huisnummer !== undefined
                 ? `${baseDataPath}/postcode-huisnummer-${config.data.postcode}-${config.data.huisnummer}.json`
                 : `${baseDataPath}/postcode-huisnummer.json`;
        default:
            console.log(`Onbekend zoek type: ${config.data.type}`);
            return '';
    }
}

When('personen wordt gezocht met de volgende parameters', async function (dataTable) {
    let requestBody = {};
    dataTable.hashes().forEach(function(param) {
        if(param.naam === "burgerservicenummer") {
            requestBody[param.naam] = param.waarde.split(',');
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

    this.context.zoekResponse.personen.push(this.context.persoon);
    this.context.zoekResponse.type = config.data.type;

    let path = determineDataPath(this.context.dataPath, config);
    fs.writeFileSync(path, JSON.stringify(this.context.zoekResponse, null, "\t"));

    try {
        this.context.response = await axios(config);
    }
    catch(e) {
        this.context.response = e.response;
    }
});

When('personen wordt geraadpleegd met de volgende parameters', async function (dataTable) {
    const persoonIdentificatie = dataTable.hashes()[0].waarde;
    const fields = dataTable.hashes()[1].waarde;

    const config = {
        method: 'get',
        url: `/personen/${persoonIdentificatie}?fields=${fields}`,
        baseURL: this.context.serverUrl
    };

    let path = `${this.context.dataPath}/${persoonIdentificatie}.json`;
    fs.writeFileSync(path, JSON.stringify(this.context.persoon, null, "\t"));

    try {
        this.context.response = await axios(config);
    }
    catch(e) {
        this.context.response = e.response;
    }
});

Then('bevat de response alleen personen met de volgende gegevens', function (dataTable) {
    const personen = this.context.response.data.personen;

    personen.length.should.equal(dataTable.hashes().length, `aantal personen in response ${personen.length} is ongelijk aan aantal expected ${dataTable.hashes().length}`);

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

Then('bevat de response de volgende gegevens', function (dataTable) {
    const data = this.context.response.data;

    dataTable.hashes().forEach(function(value){
        let expected = value.waarde;
        let actual = String(data[value.naam]);

        actual.should.equal(expected, JSON.stringify(data, null, "\t"));
    });
});

Then('bevat de response een invalidParams met de volgende gegevens', function (dataTable) {  
    const invalidParams = this.context.response.data.invalidParams;
    
    dataTable.hashes().forEach(function(expected) {
        const actual = invalidParams.find(function(invalidParam) {
            return invalidParam.name === expected.name &&
                   invalidParam.code === expected.code &&
                   invalidParam.reason === expected.reason;
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
