import requests
api_url = "http://localhost:5000/haalcentraal/api/brp/personen"
requestBody = {
     "type": "RaadpleegMetBurgerservicenummer",
     "burgerservicenummer": [
          "999999321",
          "999999322",
          "999999323",
          "999999324",
          "999999325"],
     "fields": "burgerservicenummer,geboorte.datum"
}

response = requests.post(api_url, json=requestBody)

payload = response.json()

for persoon in payload["personen"]:
     print(persoon["burgerservicenummer"])
     datum = persoon["geboorte"]["datum"]
     if datum["type"] == "Datum":
          print(datum["datum"])
     if datum["type"] == "JaarMaandDatum":
          print("{}-{}".format(datum["jaar"], datum["maand"]))
     if datum["type"] == "JaarDatum":
          print(datum["jaar"])
     if datum["type"] == "OnbekendDatum":
          print("onbekend-{}".format(datum["onbekend"]))
