const { toDateOrString } = require("./calcDate");

function createObjectFrom(dataTable, dateAsDate = false) {
    let obj = {};

    dataTable.hashes().forEach(function(row) {
        mapRowToProperty(obj, row, dateAsDate);
    });

    return obj;
}

function mapRowToProperty(obj, row, dateAsDate = false) {
    setProperty(obj, row.naam, row.waarde, dateAsDate);
}

function setProperty(obj, propertyName, propertyValue, dateAsDate) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        let propertyNames = propertyName.split('.');
        let property = obj;

        propertyNames.forEach(function(propName, index) {
            if(index === propertyNames.length-1) {
                property[propName] = toDateOrString(propertyValue, dateAsDate);
            }
            else {
                if(property[propName] === undefined) {
                    property[propName] = {};
                }
                property = property[propName];
            }
        });
    }
    else {
        obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
    }
}

module.exports = { createObjectFrom, mapRowToProperty }
