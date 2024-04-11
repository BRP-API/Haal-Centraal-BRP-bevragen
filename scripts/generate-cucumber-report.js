const reporter = require('cucumber-html-reporter');
const apiName = 'Haal Centraal BRP Bevragen API';
const gbaVersion = `GBA ${process.argv[2]}`
const proxyVersion = `Proxy ${process.argv[3]}`

const features = new Map([
    ['zoeken-en-raadplegen', 'zoeken & raadplegen'],
    ['persoon-beperkt', 'persoon beperkt'],
    ['persoon', 'persoon'],
    ['persoon-adressering', 'persoon adressering'],
    ['persoon-europees-kiesrecht', 'persoon europees kiesrecht'],
    ['persoon-geboorte', 'persoon geboorte'],
    ['persoon-geheimhouding', 'persoon geheimhouding'],
    ['persoon-gezagsverhouding', 'persoon gezagsverhouding'],
    ['persoon-immigratie', 'persoon immigratie'],
    ['persoon-kind', 'persoon kind'],
    ['persoon-leeftijd', 'persoon leeftijd'],
    ['persoon-naam', 'persoon naam'],
    ['persoon-nationaliteit', 'persoon nationaliteit'],
    ['persoon-opschorting-bijhouding', 'persoon opschorting bijhouding'],
    ['persoon-ouder', 'persoon ouder'],
    ['persoon-overlijden', 'persoon overlijden'],
    ['persoon-partner', 'persoon partner'],
    ['persoon-rni', 'persoon rni'],
    ['persoon-uitsluiting-kiesrecht', 'persoon uitsluiting kiesrecht'],
    ['persoon-verblijfplaats', 'persoon verblijfplaats'],
    ['persoon-verblijfstitel', 'persoon verblijfstitel'],
    ['persoon-verificatie', 'persoon verificatie']
]);

features.forEach((value, key) => {
    reporter.generate({
        theme: 'bootstrap',
        jsonFile: `docs/features/test-result-${key}-gba.json`,
        output: `docs/features/test-report-${key}-gba.html`,
        noInlineScreenshots: true,
        reportSuiteAsScenarios: true,
        scenarioTimestamp: true,
        launchReport: false,
        name:`${value} features`,
        brandTitle: `${apiName} - ${gbaVersion}`
    });
    reporter.generate({
        theme: 'bootstrap',
        jsonFile: `docs/features/test-result-${key}.json`,
        output: `docs/features/test-report-${key}.html`,
        noInlineScreenshots: true,
        reportSuiteAsScenarios: true,
        scenarioTimestamp: true,
        launchReport: false,
        name: `${value} features`,
        brandTitle: `${apiName} - ${proxyVersion}`
    });
});
