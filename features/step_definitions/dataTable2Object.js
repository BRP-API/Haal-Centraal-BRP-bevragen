const { toDateOrString } = require("./brpDatum");

function setPropertyValue(obj, propertyName, propertyValue, dateAsDate) {
    if(propertyName === 'periode') {
        const match = propertyValue.match(/^(?<datumVan>[\d-]*) tot (?<datumTot>[\d-]*)$/);
        if(match) {
            obj[propertyName] = match.groups;
        }
        else {
            obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
        }
    }
    else {
        obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
    }
}

function setNestedPropertyValue(obj, propertyName, propertyValue, dateAsDate) {
    const propertyNames = propertyName.split('.');

    if(propertyNames.length == 1) {
        setPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
    else {
        const propName = propertyNames[0];
        if(obj[propName] === undefined) {
            obj[propName] = {};
        }
        setNestedPropertyValue(obj[propName], propertyNames.splice(1).join('.'), propertyValue, dateAsDate);
    }
}

function setProperty(obj, propertyName, propertyValue, dateAsDate) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        setNestedPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
    else {
        setPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
}

function createObjectFrom(dataTable, dateAsDate = false) {
    let obj = {};

    setObjectPropertiesFrom(obj, dataTable, dateAsDate);

    return obj;
}

function createObjectArrayFrom(dataTable, dateAsDate = false) {
    let retval = [];

    dataTable.hashes().forEach(function(row) {
        let obj = {};

        Object.keys(row).forEach(function(propertyName) {
            setProperty(obj, propertyName, row[propertyName], dateAsDate);
        });

        retval.push(obj);
    });

    return retval;
}

function mapRowToProperty(obj, row, dateAsDate = false) {
    setProperty(obj, row.naam, row.waarde, dateAsDate);
}

function setObjectPropertiesFrom(obj, dataTable, dateAsDate = false) {
    if(dataTable.raw()[0][0] === 'naam') {
        dataTable.hashes().forEach(function(row) {
            mapRowToProperty(obj, row, dateAsDate);
        });
    }
    else {
        dataTable.hashes().forEach(function(row) {
            Object.keys(row).forEach(function(propertyName) {
                setProperty(obj, propertyName, row[propertyName]);
            })
        });
    }
}

module.exports = {
    createObjectFrom,
    createObjectArrayFrom,
    setObjectPropertiesFrom
};
