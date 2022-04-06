import {
    AbstractDatum,
    Client,
    JaarDatum,
    JaarMaandDatum,
    OnbekendDatum,
    Persoon,
    RaadpleegMetBurgerservicenummer,
    RaadpleegMetBurgerservicenummerResponse,
    VolledigeDatum
} from './generated'

let request = new RaadpleegMetBurgerservicenummer();
request.burgerservicenummer = [
    "999999321",
    "999999322",
    "999999323",
    "999999324",
    "999999325"];
request.fields = "burgerservicenummer,geboorte.datum";
const client = new Client("http://localhost:5000/haalcentraal/api/brp");
client.getPersonen(request).then(response => {
    let payload = response as RaadpleegMetBurgerservicenummerResponse;
    if(payload){
        payload.personen.forEach((persoon: Persoon) => {
            const datum = persoon.geboorte.datum;

            if(isVolledigeDatum(datum)) {
                console.log(datum.datum.toLocaleDateString());
            }
            else if(isJaarMaandDatum(datum)) {
                console.log(`${datum.jaar}-${datum.maand}`);
            }
            else if(isJaarDatum(datum)) {
                console.log(`${datum.jaar}`);
            }
            else if(isOnbekendDatum(datum)) {
                console.log(`onbekend: ${datum.onbekend}`);
            }
            else {
                console.log(datum.toJSON()["type"]);
            }
        });
    }
});

function isVolledigeDatum(datum: AbstractDatum): datum is VolledigeDatum {
    return datum.toJSON()["type"] === "Datum";
    // const d = datum as VolledigeDatum;
    // return d.datum !== undefined;
}

function isJaarMaandDatum(datum: AbstractDatum): datum is JaarMaandDatum {
    return datum.toJSON()["type"] === "JaarMaandDatum";
    // const d = datum as JaarMaandDatum;
    // return d.jaar !== undefined && d.maand !== undefined;
}

function isJaarDatum(datum: AbstractDatum): datum is JaarDatum {
    return datum.toJSON()["type"] === "JaarDatum";
    // const d = datum as JaarDatum;
    // return d.jaar !== undefined;
}

function isOnbekendDatum(datum: AbstractDatum): datum is OnbekendDatum {
    return datum.toJSON()["type"] === "OnbekendDatum";
}
