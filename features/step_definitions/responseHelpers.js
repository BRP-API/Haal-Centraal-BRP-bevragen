const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { stringifyValues } = require('./stringify');
const { toCollectieNaam } = require('./brp');

function verifyResponse(context) {
    return context.verifyAantal !== undefined ||
           (context.verifyResponse !== undefined && context.verifyResponse);
}

function verifyAantal(context) {
    if(context.verifyAantal == undefined) {
        return;
    }

    context.verifyAantal.forEach((va) => {
        const { naamColObj, naamSubColObj, aantal } = va;

        const actual = context?.response?.data[toCollectieNaam(naamColObj)];
        should.exist(actual, `geen ${naamColObj} property gevonden`);

        if(naamSubColObj === undefined) {
    
            actual.length.should.equal(Number(aantal), `aantal ${naamColObj} is ongelijk aan ${aantal}\nactual: ${JSON.stringify(context.response.data, undefined, '\t')}`);
        }
        else {
            const colObj = actual.at(-1);

            const actualSubCollectie = colObj[toCollectieNaam(naamSubColObj)];
            should.exist(actualSubCollectie, `geen ${naamSubColObj} property gevonden`);

            actualSubCollectie.length.should.equal(Number(aantal), `aantal ${naamSubColObj} is ongelijk aan ${aantal}\nactual: ${JSON.stringify(context.response.data, undefined, '\t')}`);
        }
    });
}

function vergelijkActualMetExpected(context) {
    const actual = stringifyValues(context.response.data);

    const expected = context.expected !== undefined
        ? context.expected
        : {};

    if(actual.type !== undefined) {
        expected.type = actual.type;
    }

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, undefined, '\t')}\nexpected: ${JSON.stringify(expected, undefined, '\t')}`);
}

function valideer200Response(context) {
    if (!verifyResponse(context)) {
        return;
    }

    context.response.status?.should.equal(200, `response body: ${JSON.stringify(context.response.data, undefined, '\t')}`);

    should.exist(context.response?.data, 'geen response body');

    verifyAantal(context);

    if (context.verifyResponse === undefined ||
        !context.verifyResponse) {
        return;
    }

    vergelijkActualMetExpected(context);
}

function valideerProblemDetailsResponse(context) {
    context.response.status.should.not.equal(200, `response body: ${JSON.stringify(context.response.data, undefined, '\t')}`);

    const headers = context.response?.headers;
    should.exist(headers, 'no response headers found');

    const header = headers["content-type"];
    should.exist(header, `no header found with name 'content-type'. Response headers: ${headers}`);
    header.should.contain('application/problem+json', "no 'content-type' header found with value: 'application/problem+json'");

    vergelijkActualMetExpected(context);
}

module.exports = {
    valideer200Response,
    valideerProblemDetailsResponse
};
