function toDay(dayText) {
    switch(dayText) {
        case "gisteren":
            return -1;
        case "morgen":
            return 1;
        default:
            return 0;
    }
}

function toMonth(monthText) {
    switch(monthText) {
        case "vorige maand":
            return -1;
        case "volgende maand":
            return 1;
        default:
            return 0;
    }
}

function toYear(yearText) {
    switch(yearText) {
        case "vorig jaar":
            return -1;
        case "volgend jaar":
            return 1;
        default:
            return 0;
    }
}

const dagRegex = /^(?<dag>gisteren|vandaag|morgen)( - (?<jaarOffset>\d+) jaar)?$/;
const maandRegex = /^(?<maand>vorige maand|deze maand|volgende maand)( - (?<jaarOffset>\d+) jaar)?$/;
const jaarRegex = /^(?<jaar>vorig jaar|dit jaar|volgend jaar)( - (?<jaarOffset>\d+) jaar)?$/;

function parseDagNotatie(dateInText) {
    const matches = dateInText.match(dagRegex);
    if(!matches) {
        return null;
    }

    return {
        dag: toDay(matches.groups["dag"]),
        maand: 0,
        jaar: matches.groups["jaarOffset"]
            ? -Number(matches.groups["jaarOffset"])
            : 0
    };
}

function parseMaandNotatie(dateInText) {
    const matches = dateInText.match(maandRegex);
    if(!matches) {
        return null;
    }

    return {
        dag: 0,
        maand: toMonth(matches.groups["maand"]),
        jaar: matches.groups["jaarOffset"]
            ? -Number(matches.groups["jaarOffset"])
            : 0
    }
}

function parseJaarNotatie(dateInText) {
    const matches = dateInText.match(jaarRegex);
    if(!matches) {
        return null;
    }

    return {
        dag: 0,
        maand: 0,
        jaar: matches.groups['jaarOffset'] 
            ? toYear(matches.groups["jaar"]) - Number(matches.groups["jaarOffset"])
            : toYear(matches.groups["jaar"])
    }
}

function createVolledigeDatum(result, dateAsDate) {
    const date = new Date();

    date.setFullYear(date.getFullYear() + result.jaar);
    date.setMonth(date.getMonth() + result.maand);
    date.setDate(date.getDate() + result.dag);

    const jaar = date.getFullYear();
    const maand = date.getMonth() + 1;
    const dag = date.getDate();

    return dateAsDate
        ? `${jaar}-${String(maand).padStart(2, '0')}-${String(dag).padStart(2, '0')}`
        : `${jaar}${String(maand).padStart(2, '0')}${String(dag).padStart(2, '0')}`;
}

function createJaarMaandDatum(result, dateAsDate) {
    const date = new Date();

    date.setFullYear(date.getFullYear() + result.jaar);
    date.setMonth(date.getMonth() + result.maand);

    const jaar = date.getFullYear();
    const maand = date.getMonth() + 1;
    const dag = 0;

    return dateAsDate
        ? String(maand)
        : `${jaar}${String(maand).padStart(2, '0')}${String(dag).padStart(2, '0')}`;
}

function createJaarDatum(result, dateAsDate) {
    const date = new Date();

    const jaar = date.getFullYear() + result.jaar;
    const maand = 0;
    const dag = 0;

    return dateAsDate
        ? String(jaar)
        : `${jaar}${String(maand).padStart(2, '0')}${String(dag).padStart(2, '0')}`;
}

/**
 * toDateOrString converteert de woorden
 * - vandaag, gisteren, morgen naar een BRP datum (YYYYMMDD) of een ISO datum (YYYY-MM-DD):
 * - deze maand, vorige maand, volgende maand naar een BRP datum (YYYYMM00) of een maand (MM)
 * - dit jaar, vorig jaar, volgend jaar naar een BRP datum (YYYY0000) of een jaar (YYYY)
 * Aan deze woorden kan '- [aantal] jaar' worden toegevoegd om een BRP/ISO datum te krijgen dat [aantal] jaar in het verleden ligt
 * Andere woorden of toevoegingen die niet overeenkomen met de '- [aantal] jaar' patroon worden as-is geretourneerd
 * @param {string} value: string dat moet worden geconverteerd naar een BRP/ISO datum
 * @param {boolean} dateAsDate: true converteert naar ISO datum, false converteert naar BRP datum 
 * @returns een datum string in BRP (YYYYMMDD) of ISO (YYYY-MM-DD) formaat
 */
function toDateOrString(value, dateAsDate) {
    let result = parseDagNotatie(value);
    if(result !== null) {
        return createVolledigeDatum(result, dateAsDate);
    }
    result = parseMaandNotatie(value);
    if(result !== null) {
        return createJaarMaandDatum(result, dateAsDate);
    }
    result = parseJaarNotatie(value);
    if(result !== null) {
        return createJaarDatum(result, dateAsDate);
    }

    return String(value);
}

module.exports = { toDateOrString }
