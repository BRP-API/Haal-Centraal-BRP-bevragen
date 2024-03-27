const should = require('chai').should();
const { toDateOrString } = require('../../features/step_definitions/brpDatum');

function toISODate(date) {
    return date.toISOString().slice(0, 10);
}

function toBRPDate(date) {
    return toISODate(date).replace(/-/g, '');
}

function toJaarMaandDatum(date) {
    return toBRPDate(date).slice(0, -2) + '00';
}

function toJaarDatum(date) {
    return toBRPDate(date).slice(0, -4) + '0000';
}

describe('toDateOrString', () => {

    test("vandaag (ISO formaat)", () => {
        const expected = new Date();
    
        toDateOrString('vandaag', true).should.equal(toISODate(expected));
    });
    
    test("vandaag (BRP formaat)", () => {
        const expected = new Date();
    
        toDateOrString('vandaag', false).should.equal(toBRPDate(expected));
    });
    
    test("gisteren (ISO formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() - 1);
    
        toDateOrString('gisteren', true).should.equal(toISODate(expected));
    });
    
    test("gisteren (BRP formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() - 1);
    
        toDateOrString('gisteren', false).should.equal(toBRPDate(expected));
    });
    
    test("morgen (ISO formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() + 1);
    
        toDateOrString('morgen', true).should.equal(toISODate(expected));
    });
    
    test("morgen (BRP formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() + 1);
    
        toDateOrString('morgen', false).should.equal(toBRPDate(expected));
    });
    
    test("vandaag - 1 jaar (ISO formaat)", () => {
        const expected = new Date();
        expected.setFullYear(expected.getFullYear() - 1);
    
        toDateOrString('vandaag - 1 jaar', true).should.equal(toISODate(expected));
    });
    
    test("vandaag - 1 jaar (BRP formaat)", () => {
        const expected = new Date();
        expected.setFullYear(expected.getFullYear() - 1);
    
        toDateOrString('vandaag - 1 jaar', false).should.equal(toBRPDate(expected));
    });
    
    test("gisteren - 2 jaar (ISO formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() - 1);
        expected.setFullYear(expected.getFullYear() - 2);
    
        toDateOrString('gisteren - 2 jaar', true).should.equal(toISODate(expected));
    });
    
    test("gisteren - 2 jaar (BRP formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() - 1);
        expected.setFullYear(expected.getFullYear() - 2);
    
        toDateOrString('gisteren - 2 jaar', false).should.equal(toBRPDate(expected));
    });
    
    test("morgen - 3 jaar (ISO formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() + 1);
        expected.setFullYear(expected.getFullYear() - 3);
    
        toDateOrString('morgen - 3 jaar', true).should.equal(toISODate(expected));
    });
    
    test("morgen - 3 jaar (BRP formaat)", () => {
        const expected = new Date();
        expected.setDate(expected.getDate() + 1);
        expected.setFullYear(expected.getFullYear() - 3);
    
        toDateOrString('morgen - 3 jaar', false).should.equal(toBRPDate(expected));
    });
    
    test("deze maand", () => {
        let expected = new Date();
        expected = expected.getMonth() + 1; // maand is 0-based in javascript, 0=januari,1=februari,...
    
        toDateOrString('deze maand', true).should.equal(expected+'');
    });
    
    test("deze maand (BRP formaat)", () => {
        let expected = new Date();
    
        toDateOrString('deze maand', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("vorige maand", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() - 1);
        expected = expected.getMonth() + 1; // maand is 0-based in javascript, 0=januari,1=februari,...
    
        toDateOrString('vorige maand', true).should.equal(expected+'');
    });
    
    test("vorige maand (BRP formaat)", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() - 1);
    
        toDateOrString('vorige maand', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("volgende maand", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() + 1);
        expected = expected.getMonth() + 1; // maand is 0-based in javascript, 0=januari,1=februari,...
    
        toDateOrString('volgende maand', true).should.equal(expected+'');
    });
    
    test("volgende maand (BRP formaat)", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() + 1);
    
        toDateOrString('volgende maand', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("deze maand - 4 jaar (brp formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() - 4);
    
        toDateOrString('deze maand - 4 jaar', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("vorige maand - 5 jaar (brp formaat)", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() - 1);
        expected.setFullYear(expected.getFullYear() - 5);
    
        toDateOrString('vorige maand - 5 jaar', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("volgende maand - 6 jaar (brp formaat)", () => {
        let expected = new Date();
        expected.setMonth(expected.getMonth() + 1);
        expected.setFullYear(expected.getFullYear() - 6);
    
        toDateOrString('volgende maand - 6 jaar', false).should.equal(toJaarMaandDatum(expected));
    });
    
    test("dit jaar", () => {
        let expected = new Date().getFullYear();
    
        toDateOrString('dit jaar', true).should.equal(expected+'');
    });
    
    test("dit jaar (BRP formaat)", () => {
        let expected = new Date();
    
        toDateOrString('dit jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("vorig jaar", () => {
        let expected = new Date().getFullYear()-1;
    
        toDateOrString('vorig jaar', true).should.equal(expected+'');
    });
    
    test("vorig jaar (BRP formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() - 1);
    
        toDateOrString('vorig jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("volgend jaar", () => {
        let expected = new Date().getFullYear() + 1;
    
        toDateOrString('volgend jaar', true).should.equal(expected+'');
    });
    
    test("volgend jaar (BRP formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() + 1);
    
        toDateOrString('volgend jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("dit jaar - 7 jaar", () => {
        let expected = new Date().getFullYear() - 7;
    
        toDateOrString('dit jaar - 7 jaar', true).should.equal(expected+'');
    });
    
    test("dit jaar - 7 jaar (BRP formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() - 7);
    
        toDateOrString('dit jaar - 7 jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("vorig jaar - 8 jaar", () => {
        let expected = new Date().getFullYear() - 1;
        expected = expected - 8;
    
        toDateOrString('vorig jaar - 8 jaar', true).should.equal(expected+'');
    });
    
    test("vorig jaar - 8 jaar (BRP formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() - 1);
        expected.setFullYear(expected.getFullYear() - 8);
    
        toDateOrString('vorig jaar - 8 jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("volgend jaar - 9 jaar", () => {
        let expected = new Date().getFullYear() + 1;
        expected = expected - 9;
    
        toDateOrString('volgend jaar - 9 jaar', true).should.equal(expected+'');
    });
    
    test("volgend jaar - 9 jaar (BRP formaat)", () => {
        let expected = new Date();
        expected.setFullYear(expected.getFullYear() + 1);
        expected.setFullYear(expected.getFullYear() - 9);
    
        toDateOrString('volgend jaar - 9 jaar', false).should.equal(toJaarDatum(expected));
    });
    
    test("een willekeurig (mogelijk ongeldig) BRP datum", (() => {
    
        toDateOrString('20000101', true).should.equal('20000101');
    }));
    
    test("een willekeurig (mogelijk ongeldig) ISO datum", (() => {
    
        toDateOrString('2000-01-01', false).should.equal('2000-01-01');
    }));
    
});
