# INSERT/UPDATE landelijk tabel waarden in de GBA-V (test) database

## Prerequisite
- Node.js

## Uitvoeren script

- eenmalig de statement `npm install` uitvoeren om de benodigde npm package te installeren
- voer de statement `npm run db:update-waarde-tabellen` uit om de landelijk tabel waarden te updaten

## Landelijke tabellen die nu worden ge-update

- Tabel37 Reden opnemen beëindigen nationaliteit
- Tabel38 Adellijke titel predicaat
- Tabel60 RNI-deelnemers
- Tabel61 Gezagsverhouding

## Opnemen van nieuwe/gewijzigde tabel waarden in de update script

- Download de gewenste [landelijke tabel in csv-formaat](https://publicaties.rvig.nl/Landelijke_tabellen/Landelijke_tabellen_32_t_m_61_excl_tabel_35/Landelijke_Tabellen_32_t_m_61_in_csv_formaat) en bewaar het in de `scripts` map
- Controleer in het `upsert-landelijk-tabel-data.js` bestand in de `scripts` map of er voor het gedownloade landelijk tabel bestand het volgende is opgenomen
  - een _'bestand naam' naar 'tabel naam'_ mapping in de **tableNameMap**
  - voor elke kolom in het bestand een _bestand kolom naam naar tabel kolom naam_ mapping in de **columnNameMap**
  - een _upsertLandelijkTabel('\<naam tabel waarden bestand\>');_ statement in de **main()** functie
