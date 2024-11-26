const { createArrayFrom } = require('./dataTable2Array');
const { columnNameMap } = require('./brp');

function createAutorisatie(context, afnemerCode, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [];
    }
    context.sqlData.push({});

    let sqlData = context.sqlData.at(-1);

    sqlData['autorisatie'] = [
        [
            ['afnemer_code', afnemerCode ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0]
        ].concat(createArrayFrom(dataTable, columnNameMap))];
}

function createGegevensgroepAutorisatie(context, afnemerCode, gegevensgroep) {
    if(context.sqlData === undefined) {
        context.sqlData = [];
    }
    context.sqlData.push({});

    let sqlData = context.sqlData.at(-1);

    let data = [
        ['afnemer_code', afnemerCode ],
        ['geheimhouding_ind', 0],
        ['verstrekkings_beperking', 0],
        ['afnemer_naam', 'Haal Centraal'],
        ['adres_vraag_bevoegdheid', 1],
        ['ad_hoc_medium', 'N'],
        ['tabel_regel_start_datum', 20201128]
    ]
    switch(gegevensgroep) {
        case 'adressering binnenland':
            data.push(['ad_hoc_rubrieken',
                       '10120 10240 10310 80910 81110 81120 81130 81140 81180 81190 PANM03 PANM04 PANM05 PANM06 PAVP03 PAVP04']);
            break;
        case 'verblijfplaats binnenland':
            data.push(['ad_hoc_rubrieken',
                       '10120 81010 80910 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 88510 PAVP01']);
            break;
        default:
            data.push(['ad_hoc_rubrieken',
                       '10110 10120 10210 10220 10230 10240 10310 10320 10330 10410 123510 123520 123530 123550 123560 123570 16110 18110 18120 18210 18220 18230 18510 18610 20110 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 28110 28120 28210 28220 28230 28510 28610 30110 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 38110 38120 38210 38220 38230 38510 38610 40510 46310 46410 46510 48210 48220 48230 48510 48610 50110 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 50720 50730 50740 51510 58110 58120 58210 58220 58230 58510 58610 60810 60820 60830 68110 68120 68210 68220 68230 68510 68610 76710 76720 76810 76910 77010 78710 80910 80920 81010 81020 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 81410 81420 87210 87510 88510 88610 90110 90120 90210 90220 90230 90240 90310 90320 90330 98110 98120 98210 98220 98230 98510 98610 98910 103910 103920 103930 108510 108610 113210 113310 118210 118220 118230 118510 118610 123510 123520 123530 123540 123550 123560 123570 123610 128210 128220 128230 128510 128610 133110 133120 133130 133810 133820 138210 138220 138230 540510 546310 546410 546510 548210 548220 548230 548510 548610 550110 550120 550210 550220 550230 550240 550310 550320 550330 550410 550610 550620 550630 550710 550720 550730 550740 551510 558110 558120 558210 558220 558230 558510 558610 580910 580920 581010 581020 581030 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581320 581330 581340 581350 581410 581420 587210 587510 588510 588610 603910 603920 603930 608510 608610 PAGL01 PAGZ01 PAHP01 PAKD01 PANM01 PANM02 PANM03 PANM04 PANM05 PANM06 PANT01 PAOU01 PAVP01 PAVP03 PAVP04 PAVP05 PAVP06']);
            break;
    }

    sqlData['autorisatie'] = [ data ];
}

module.exports = {
    createAutorisatie,
    createGegevensgroepAutorisatie
}