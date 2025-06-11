const { Given } = require('@cucumber/cucumber');
const { createObjectFrom } = require('./dataTable2Object');
const { getBsn, getPersoonMetAanduiding } = require('./contextHelpers');
const { createGezag } = require('./gezagsrelatie');

Given(/^voor de persoon met burgerservicenummer '(\d*)' gelden de volgende gezagsrelaties$/, function (burgerservicenummer, dataTable) {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    this.context.gezag.push({
        burgerservicenummer: burgerservicenummer,
        gezagsrelaties: dataTable.hashes()
    });
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft geen gezagsrelaties$/, function (_) {
});

function getBsnFromCurrentPersoon(sqlData) {
    return sqlData.at(-1).persoon[0].find(p => p[0] === 'burger_service_nr')[1];
}

Given(/^voor de persoon geldt ?(?:ook)? het volgende gezag$/, function (dataTable) {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    const bsnCurrentPersoon = getBsnFromCurrentPersoon(this.context.sqlData);
    this.context.gezag.push({
        burgerservicenummer: bsnCurrentPersoon,
        gezag: [ createObjectFrom(dataTable) ]
    });
});

Given(/^voor de persoon geldt geen gezag$/, function () {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }

    const bsnCurrentPersoon = getBsnFromCurrentPersoon(this.context.sqlData);
    this.context.gezag.push({
        burgerservicenummer: bsnCurrentPersoon,
        gezag: []
    });
});

Given(/^het gezag heeft de volgende ouders$/, function(dataTable) {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.ouders = dataTable.hashes();
});

Given(/^het gezag heeft de volgende derden$/, function(dataTable) {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.derden = dataTable.hashes();
});

Given(/^het gezag heeft geen derden$/, function() {
    let persoon = this.context.gezag.at(-1);

    let gezag = persoon.gezag.at(-1);
    gezag.derden = [];
});

function gegevenDePersoonHeeftGezagsrelaties(aanduiding) {
    if(this.context.gezag === undefined) {
        this.context.gezag = [];
    }
    this.context.bsnCurrentGezagPersoon = getBsn(getPersoonMetAanduiding(this.context, aanduiding));

    if(!this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon)) {
        this.context.gezag.push({
            burgerservicenummer: this.context.bsnCurrentGezagPersoon,
            gezag: []
        });
    }
}

function deleteNietDeprecatedGezagsrelatieProperties(context, gezag) {
    if(context.isDeprecatedScenario) {
        delete gezag.minderjarige.geboorte;
        delete gezag.minderjarige.naam;
        if(gezag.ouder) {
            delete gezag.ouder.naam;
        }
        if(gezag.ouders) {
            gezag.ouders.forEach(o => delete o.naam);
        }
        if(gezag.derde) {
            delete gezag.derde.naam;
        }
        if(gezag.derden) {
            gezag.derden.forEach(d => delete d.naam);
        }
    }
}

Given('{aanduiding} heeft de volgende gezagsrelaties', gegevenDePersoonHeeftGezagsrelaties);
Given('{aanduiding} heeft geen gezaghouder', gegevenDePersoonHeeftGezagsrelaties);

Given('eenhoofdig ouderlijk gezag over {aanduiding} met ouder {aanduiding}', function (minderjarige, ouder) {
    let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'eenhoofdig ouderlijk gezag', minderjarige, ouder);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

    persoon.gezag.push(gezag);
});

Given('gezamenlijk ouderlijk gezag over {aanduiding} met ouder {aanduiding} en ouder {aanduiding}', function (minderjarige, ouder1, ouder2) {
    let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'gezamenlijk ouderlijk gezag', minderjarige, ouder1, ouder2);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

    persoon.gezag.push(gezag);
});

Given('gezamenlijk gezag over {aanduiding} met ouder {aanduiding} en derde {aanduiding}', function (minderjarige, ouder1, ouder2) {
    let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'gezamenlijk gezag', minderjarige, ouder1, ouder2);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

    persoon.gezag.push(gezag);
});

Given('gezamenlijk gezag over {aanduiding} met ouder {aanduiding} en een onbekende derde', function (minderjarige, ouder1) {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'gezamenlijk gezag', minderjarige, ouder1);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

   persoon.gezag.push(gezag);
});

Given('voogdij over {aanduiding}', function (minderjarige) {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'voogdij', minderjarige);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

   persoon.gezag.push(gezag);
});

Given('voogdij over {aanduiding} met derde {aanduiding}', function (minderjarige, ouder1) {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'voogdij', minderjarige, ouder1);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

   persoon.gezag.push(gezag);
});

Given('tijdelijk geen gezag over {aanduiding} met de toelichting {toelichting}', function (minderjarige, toelichting) {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'tijdelijk geen gezag', minderjarige, undefined, undefined, toelichting);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

   persoon.gezag.push(gezag);
});

Given('gezag over {aanduiding} is niet te bepalen met de toelichting {toelichting}', function (minderjarige, toelichting) {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);

    let gezag = createGezag(this.context, 'niet te bepalen', minderjarige, undefined, undefined, toelichting);
    deleteNietDeprecatedGezagsrelatieProperties(this.context, gezag);

   persoon.gezag.push(gezag);
});

Given('het gezag is in onderzoek', function () {
   let persoon = this.context.gezag.find(g => g.burgerservicenummer === this.context.bsnCurrentGezagPersoon);
   let gezag = persoon.gezag.at(-1);
    gezag.inOnderzoek = true;
});
