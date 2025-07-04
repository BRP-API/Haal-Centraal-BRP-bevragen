const fs = require('fs');
const axios = require('axios');

function extractBurgerservicenummers(filePath) {
  try {
    const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));

    const bsnArray = data
      .filter(person => person.burgerservicenummer)
      .map(person => person.burgerservicenummer);

    return bsnArray;
  } catch (error) {
    console.error('Error processing file:', error);
    return [];
  }
}

function createRequestBody(bsn) {
    return {
        type: 'RaadpleegMetBurgerservicenummer',
        fields: ["aNummer",
             "adressering",
             "burgerservicenummer",
             "datumEersteInschrijvingGBA",
             "datumInschrijvingInGemeente",
             "europeesKiesrecht",
             "geboorte",
             "gemeenteVanInschrijving",
             "geslacht",
             "immigratie",
             "indicatieCurateleRegister",
             "indicatieGezagMinderjarige",
             "gezag",
             "kinderen",
             "leeftijd",
             "naam",
             "nationaliteiten",
             "ouders",
             "overlijden",
             "partners",
             "uitsluitingKiesrecht",
             "verblijfplaats",
             "verblijfstitel"],
        burgerservicenummer: [bsn]
    }
}

async function verifyBurgerservicenummer(bsn, baseUrlPersonenApi) {
  try {
    const config = {
        method: 'post',
        url: '/personen',
        baseURL: baseUrlPersonenApi,
        data: createRequestBody(bsn),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    };
    const response = await axios(config);
    
    return {
      bsn,
      status: response.status,
      success: response.status === 200
    };
  } catch (error) {
    return {
      bsn,
      status: error.response?.status || 'Network Error',
      success: false,
      error: error.response?.data ? JSON.stringify(error.response.data, null, '') : error.message
    };
  }
}

async function main(pathTestDataFile, baseUrlPersonenApi) {
    const bsns = extractBurgerservicenummers(pathTestDataFile);

    const results = {
        total: bsns.length,
        success: 0,
        failed: 0,
        failures: []
    };

    for (const bsn of bsns) {
        const result = await verifyBurgerservicenummer(bsn, baseUrlPersonenApi);
        
        if (result.success) {
            results.success++;
        } else {
            results.failed++;
            results.failures.push(result);
        }
    }

    console.log(results);
}

main('./test-data/personen-mock/test-data.json', 'http://localhost:5010/haalcentraal/api/brp');