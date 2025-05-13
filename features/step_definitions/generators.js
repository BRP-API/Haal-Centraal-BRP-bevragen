const AkteTypes = {
    Geboorte: 'A',
    ErkenningBijGeboorteaangifte: 'B',
    ErkenningNaGeboorteaangifte: 'C',
    NotarieleAkteVanErkenning: 'J',
    Adoptie: 'Q',
    GerechtelijkeVaststellingOuderschap: 'V',
}

function genereerAktenummer(aktetype) {
    const first = 1;
    const second = String.fromCharCode(65 + Math.floor(Math.random() * 26)); // random letter tussen A (65) en Z (90)
    const numbers = String(Math.floor(Math.random() * 10000)).padStart(4, '0'); // random getal tussen 0000 en 9999

    return `${first}${second}${aktetype}${numbers}`;
}

function genereerBurgerservicenummer(context) {
    const count = context.data?.personen?.length || 0;

    return (12 * (count+1)).toString().padStart(9, '0');
}

module.exports = {
    AkteTypes,
    genereerAktenummer,
    genereerBurgerservicenummer
}
