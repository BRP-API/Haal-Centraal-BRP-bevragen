function getAdres(context, aanduiding) {
    return !aanduiding
        ? context.data.adressen.at(-1)
        : context.data.adressen.find(a => a.id === `adres-${aanduiding}`);
}

function getAdresIndex(context, aanduiding) {
    return context.data.adressen.findIndex(a => a.id === `adres-${aanduiding}`);
}

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data?.personen?.at(-1)
        : context.data?.personen?.find(p => p.id === `persoon-${aanduiding}`);
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function getGeslachtsnaam(persoon) {
    return persoon.persoon.at(-1).geslachts_naam;
}

function getVoornamen(persoon) {
    return persoon.persoon.at(-1).voor_naam;
}

function getGeboortedatum(persoon) {
    return persoon.persoon.at(-1).geboorte_datum;
}

module.exports = {
    getAdres,
    getAdresIndex,
    getBsn,
    getVoornamen,
    getGeslachtsnaam,
    getGeboortedatum,
    getPersoon
};
