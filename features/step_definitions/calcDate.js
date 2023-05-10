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

function toDate(dateInText) {
    let jaar = 0,
        maand = 0,
        dag = 0;

    let matches = dateInText.match(dagRegex)
    if(matches){
        dag = toDay(matches.groups["dag"]);

        if(matches.groups['jaarOffset']) {
            jaar -= Number(matches.groups["jaarOffset"])
        }
    }
    matches = dateInText.match(maandRegex)
    if(matches){
        maand = toMonth(matches.groups["maand"]);

        if(matches.groups['jaarOffset']) {
            jaar -= Number(matches.groups["jaarOffset"])
        }
    }
    matches = dateInText.match(jaarRegex)
    if(matches){
        jaar = toYear(matches.groups["jaar"]);

        if(matches.groups['jaarOffset']) {
            jaar -= Number(matches.groups["jaarOffset"])
        }
    }

    let date = new Date();
    date.setDate(dag !== 0 ? date.getDate() + dag : 1);
    date.setMonth(date.getMonth() + maand);
    date.setYear(date.getFullYear() + jaar);

    return date;
}

function toGbaDate(dateInText) {
    const date = toDate(dateInText);

    if(dateInText.match(maandRegex)) {
        return `${date.getFullYear()}${String(date.getMonth()+1).padStart(2, '0')}00`;
    }
    if(dateInText.match(jaarRegex)) {
        return `${date.getFullYear()}0000`;
    }
    return `${date.getFullYear()}${String(date.getMonth()+1).padStart(2, '0')}${String(date.getDate()).padStart(2, '0')}`;
}

function toHcDate(dateInText) {
    const date = toDate(dateInText);

    if(dateInText.match(maandRegex)) {
        return String(date.getMonth()+1);
    }
    if(dateInText.match(jaarRegex)) {
        return String(date.getFullYear());
    }
    return `${date.getFullYear()}-${String(date.getMonth()+1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
}

// converteer een datum representatie naar een GBA datum (8 cijfers representatie) of een ISO datum of een jaar of een maand
// of de waarde als deze geen datum representatie is 
function toDateOrString(value, dateAsDate) {
    if (value.match(dagRegex) ||
        value.match(maandRegex) ||
        value.match(jaarRegex)) {
        return dateAsDate
            ? toHcDate(value)
            : toGbaDate(value);
    }

    return String(value);
}

// let dateText = [
//     "vandaag",
//     "gisteren",
//     "morgen",
//     "vandaag - 1 jaar",
//     "gisteren - 2 jaar",
//     "morgen - 3 jaar",
//     "deze maand",
//     "vorige maand",
//     "volgende maand",
//     "deze maand - 4 jaar",
//     "vorige maand - 5 jaar",
//     "volgende maand - 6 jaar",
//     "dit jaar",
//     "vorig jaar",
//     "volgend jaar",
//     "dit jaar - 7 jaar",
//     "vorig jaar - 8 jaar",
//     "volgend jaar - 9 jaar"
// ].forEach(d => console.log(`${d}: ${toGbaDate(d)} ${toHcDate(d)}`));

module.exports = {dagRegex, maandRegex, jaarRegex, toGbaDate, toHcDate, toDateOrString }
