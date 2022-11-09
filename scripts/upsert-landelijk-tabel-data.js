const fs = require('fs');
const { parse } = require('csv-parse');
const { Pool } = require('pg');

const pool = new Pool({
  user: "root",
  host: "localhost",
  database: "rvig_haalcentraal_testdata",
  password: "root",
  port: 5432,
  max: 150
});

// De lijst met tabelwaarden bestandsnamen zonder extensie met bijbehorende database tabel naam 
const tableNameMap = new Map([

  ['Tabel32 Nationaliteitentabel (gesorteerd op code)', 'lo3_nationaliteit'],
  ['Tabel33 Gemeententabel (gesorteerd op code)', 'lo3_gemeente'],
  ['Tabel34 Landentabel (gesorteerd op code)', 'lo3_land'],
  ['Tabel37 Reden opnemen beëindigen nationaliteit', 'lo3_nl_nat_verkrijg_verlies_reden'],
  ['Tabel38 Adellijke titel predicaat','lo3_titel_predikaat'],
  ['Tabel60 RNI-deelnemerstabel (gesorteerd op code)', 'lo3_rni_deelnemer' ],
  ['Tabel61 Gezagsverhoudingtabel (gesorteerd op code)', 'lo3_gezagsverhouding'],

]);

// De lijst met kolom namen uit de tabelwaarden bestanden met bijbehorende kolom naam in de database tabel
const columnNameMap = new Map([

  ['02.21 Adellijke titel/predicaat', 'titel_predikaat'],
  ['02.02 Omschrijving', 'titel_predikaat_oms'],
  ['02.23 Soort', 'titel_predikaat_soort'],

  ['05.11 Nationaliteitscode', 'nationaliteit_code'],
  ['05.12 Omschrijving', 'nationaliteit_oms'],

  ['32.11 Gezagsverhouding', 'gezagsverhouding_code'],
  ['32.12 Omschrijving', 'gezagsverhouding_oms'],

  ['88.11 Code RNI-deelnemer', 'deelnemer_code'],
  ['88.12 Omschrijving', 'deelnemer_oms'],

  ['92.10 Gemeentecode', 'gemeente_code'],
  ['92.11 Omschrijving', 'gemeente_naam'],
  ['92.12 Nieuwe code', 'nieuwe_gemeente_code'],

  ['94.10 Landcode', 'land_code'],
  ['94.11 Omschrijving', 'land_naam'],

  ['96.10 Reden opnemen/beëindigen nationaliteit', 'nl_nat_verkrijg_verlies_reden'],
  ['96.20 Omschrijving', 'nl_nat_reden_oms'],
  ['96.30 Soort', 'nl_nat_reden_soort'],

  ['99.98 Datum ingang', 'tabel_regel_start_datum'],
  ['99.99 Datum einde', 'tabel_regel_eind_datum'],

]);

function main() {
  upsertLandelijkTabel('Tabel32 Nationaliteitentabel (gesorteerd op code)');
  upsertLandelijkTabel('Tabel33 Gemeententabel (gesorteerd op code)');
  upsertLandelijkTabel('Tabel34 Landentabel (gesorteerd op code)');
  upsertLandelijkTabel('Tabel37 Reden opnemen beëindigen nationaliteit');
  upsertLandelijkTabel('Tabel38 Adellijke titel predicaat');
  upsertLandelijkTabel('Tabel60 RNI-deelnemerstabel (gesorteerd op code)');
  upsertLandelijkTabel('Tabel61 Gezagsverhoudingtabel (gesorteerd op code)');
}

function createUpsertStatement(tabelNaam, row) {
  const tableName = tableNameMap.get(tabelNaam);

  let statement = {
    text: `INSERT INTO public.${tableName}(`,
    values: []
  };

  let columnNames = [];
  Object.keys(row).forEach(function(key, index) {
    const columnName = columnNameMap.get(key);
    const columnValue = row[key];

    if(columnName !== undefined &&
       (columnValue !== '' || columnName === 'nl_nat_reden_soort')) {
      columnNames.push(columnName);

      statement.text += index === 0
        ? `${columnName}`
        : `,${columnName}`;
      statement.values.push(columnValue);
    }
  });

  statement.text += ') VALUES (';
  statement.values.forEach(function(_value, index) {
    statement.text += index === 0
        ? `$${index+1}`
        : `,$${index+1}`;
  });
  statement.text += ')';

  statement.text += ` ON CONFLICT(${columnNames[0]}) DO UPDATE SET `;
  
  columnNames.slice(1).forEach(function(value, index) {
    statement.text += index === 0
      ? `${value}=EXCLUDED.${value}`
      : `,${value}=EXCLUDED.${value}`;
  });

  return statement;
}

async function upsertLandelijkTabel(filename) {
  const statements = [];

  fs.createReadStream(`scripts/${filename}.csv`)
  .pipe(parse({ delimiter: ',', columns: true, bom: true}))
  .on('data', function(row) {
    const statement = createUpsertStatement(filename, row);
    statements.push(statement);
  });

  const client = await pool.connect();
  try {
    for(const statement of statements) {
      await client.query(statement);
    }
    console.log(`tabelwaarden uit '${filename}' geïmporteerd`);
  }
  catch(ex) {
      console.log(ex.stack);
  }
  finally {
      client.release();
  }
}

main();
