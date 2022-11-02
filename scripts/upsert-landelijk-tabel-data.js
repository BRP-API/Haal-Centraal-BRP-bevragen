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

const tableNameMap = new Map([

  ['Tabel38 Adellijke titel predicaat','lo3_titel_predikaat'],
  ['Tabel60 RNI-deelnemerstabel', 'lo3_rni_deelnemer' ],
  ['Tabel61 Gezagsverhoudingtabel', 'lo3_gezagsverhouding'],

]);

const columnNameMap = new Map([

  ['02.21 Adellijke titel/predicaat', 'titel_predikaat'],
  ['02.02 Omschrijving', 'titel_predikaat_oms'],
  ['02.23 Soort', 'titel_predikaat_soort'],

  ['32.11 Gezagsverhouding', 'gezagsverhouding_code'],
  ['32.12 Omschrijving', 'gezagsverhouding_oms'],

  ['88.11 Code RNI-deelnemer', 'deelnemer_code'],
  ['88.12 Omschrijving', 'deelnemer_oms'],

  ['99.98 Datum ingang', 'tabel_regel_start_datum'],
  ['99.99 Datum einde', 'tabel_regel_eind_datum'],

]);

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

    if(columnValue !== '') {
      columnNames.push(columnName);

      statement.text += index === 0
        ? `${columnName}`
        : `,${columnName}`;
      statement.values.push(row[key]);
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

function upsertLandelijkTabel(filename) {
  fs.createReadStream(`scripts/${filename}.csv`)
  .pipe(parse({ delimiter: ';', columns: true}))
  .on('data', async function(row) {
    const client = await pool.connect();
    try {
      const statement = createUpsertStatement(filename, row);
      console.log(statement);
      await client.query(statement);
    }
    catch(ex) {
        console.log(ex.stack);
    }
    finally {
        client.release();
    }
  })
  .on('end', function() {
    console.log('done');
  });
}

upsertLandelijkTabel('Tabel38 Adellijke titel predicaat');
upsertLandelijkTabel('Tabel60 RNI-deelnemerstabel');
upsertLandelijkTabel('Tabel61 Gezagsverhoudingtabel');