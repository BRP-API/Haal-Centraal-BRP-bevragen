const { World } = require('./world');
const { Given, When, Then, setWorldConstructor } = require('@cucumber/cucumber');
const axios = require('axios').default;
const fs = require('fs');
const should = require('chai').should();

setWorldConstructor(World);

Given('het systeem heeft een persoon met de volgende gegevens', function (dataTable) {
    if(this.context.persoon.burgerservicenummer !== undefined) {
        this.context.zoekResponse._embedded.personen.push(this.context.persoon);
        this.context.persoon = {};
    }
    let persoon = this.context.persoon;

    dataTable.hashes().forEach(function(value) {
        for(const [key, val] of Object.entries(value)) {
            persoon[key] = val;
        }
    });
});

Given('de persoon heeft de volgende geboorte gegevens', function (dataTable) {
    if(this.context.persoon.geboorte === undefined) {
        this.context.persoon.geboorte = {};
    }
    let geboorte = this.context.persoon.geboorte;

    dataTable.hashes().forEach(function(value) {
        for(const [key, val] of Object.entries(value)) {
            if(key === "datum") {
                geboorte.datum = {
                    type: "GbaDatum",
                    gbaDatum: val
                };
            }
            else {
                geboorte[key] = val;
            }
        }
    });
});

Given('de persoon heeft de volgende naam gegevens', function (dataTable) {
    if(this.context.persoon.naam === undefined) {
        this.context.persoon.naam = {};
    }
    let naam = this.context.persoon.naam;

    dataTable.hashes().forEach(function(value) {
        for(let [key, val] of Object.entries(value)) {
            if(val !== undefined && val !== '')
            {
                key = key.replace(/ (\(.*\))/, "");
                if(key === 'adellijke titel of predikaat') {
                    key='adellijkeTitelPredikaat';
                    naam[key] = { code: val };
                }
                else {
                    naam[key] = val;
                }
            }
        }
    });
});

Given('de persoon heeft de volgende verblijfplaats gegevens', function (dataTable) {
    if(this.context.persoon.verblijfplaats === undefined) {
        this.context.persoon.verblijfplaats = {};
    }
    let verblijfplaats = this.context.persoon.verblijfplaats;

    dataTable.hashes().forEach(function(value) {
        for(const [key, val] of Object.entries(value)) {
            verblijfplaats[key] = val;
        }
    });
});

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

    this.context.zoekResponse._embedded.personen.push(this.context.persoon);

    let path = '';
    switch(config.data.type) {
        case "ZoekMetBurgerservicenummer":
            path = config.data.burgerservicenummer !== undefined
                ? `${this.context.dataPath}/bsn-${config.data.burgerservicenummer.join("-")}.json`
                : `${this.context.dataPath}/bsn.json`
            break;
        case "ZoekMetGeslachtsnaamEnGeboortedatum":
            path = config.data.geslachtsnaam !== undefined &&
            config.data.geboortedatum !== undefined
                 ? `${this.context.dataPath}/geslachtsnaam-geboortedatum-${config.data.geslachtsnaam}-${config.data.geboortedatum}.json`
                 : '${this.context.dataPath}/geslachtsnaam-geboortedatum.json';
             break;
        case "ZoekMetGeslachtsnaamEnGemeenteVanInschrijving":
            path = config.data.geslachtsnaam !== undefined &&
            config.data.gemeenteVanInschrijving !== undefined
                 ? `${this.context.dataPath}/geslachtsnaam-gemeente-${config.data.geslachtsnaam}-${config.data.gemeenteVanInschrijving}.json`
                 : '${this.context.dataPath}/geslachtsnaam-gemeente.json';
             break;
        case "ZoekMetPostcodeEnHuisnummer":
            path = config.data.postcode !== undefined &&
            config.data.huisnummer !== undefined
                 ? `${this.context.dataPath}/postcode-huisnummer-${config.data.postcode}-${config.data.huisnummer}.json`
                 : '${this.context.dataPath}/postcode-huisnummer.json';
             break;
        default:
            console.log(`Onbekend zoek type: ${config.data.type}`);
            break;
    }
    fs.writeFileSync(path, JSON.stringify(this.context.zoekResponse, null, "\t"));

    try {
        this.context.response = await axios(config);
    }
    catch(e) {
        this.context.response = e.response;
    }
});

Then('bevat de response alleen personen met de volgende gegevens', function (dataTable) {
    const personen = this.context.response.data._embedded.personen;

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

Then('bevat de persoon met burgerservicenummer {string} de volgende geboorte datum', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data._embedded.personen;

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
    const personen = this.context.response.data._embedded.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(value) {
        for(const [key, expected] of Object.entries(value)) {
            let actual = String(persoon.naam[key]);

            actual.should.equal(expected, `geen persoon gevonden met ${key}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        }
   });
});

Then('bevat de persoon met burgerservicenummer {string} de volgende geboorte gegevens', function (burgerservicenummer, dataTable) {
    const personen = this.context.response.data._embedded.personen;

    const persoon = personen.find(function(p) {
        return p.burgerservicenummer === burgerservicenummer;
    });

    dataTable.hashes().forEach(function(value) {
        for(const [key, expected] of Object.entries(value)) {
            let actual = String(persoon.geboorte[key]);

            actual.should.equal(expected, `geen persoon gevonden met ${key}: ${expected}\npersoon: ${JSON.stringify(persoon, null, "\t")}`);
        }
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
