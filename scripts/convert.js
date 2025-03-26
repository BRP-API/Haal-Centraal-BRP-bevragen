const fs = require('fs').promises;
const path = require('path');
const { convertGherkinToMarkdown } = require('./convert-feature-file');

let tags = [];

process.argv.forEach(function (val, index, array) {
  if (index >= 4) {
    tags.push(val.replace('@', ''));
  }
});

async function processDirectory(inputDir, outputDir, tags) {
  try {
    await fs.mkdir(outputDir, { recursive: true });

    const files = await fs.readdir(inputDir);
    for (const file of files) {
      const inputFilePath = path.join(inputDir, file);
      const outputFilePath = path.join(outputDir, `${path.basename(file, '.feature')}.feature.md`);
      if (path.extname(file) === '.feature') {
        await convertGherkinToMarkdown(inputFilePath, outputFilePath, tags);
      }
    }
  } catch (error) {
    console.error('Error processing directory:', error);
  }
}

async function main() {
  const inputPath = process.argv[2];
  const outputPath = process.argv[3];

  try {
    const stats = await fs.stat(inputPath);
    if (stats.isDirectory()) {
      await processDirectory(inputPath, outputPath, tags);
    } else if (stats.isFile()) {
      await convertGherkinToMarkdown(inputPath, outputPath, tags);
    } else {
      console.error('Input path is neither a file nor a directory');
    }
  } catch (error) {
    console.error('Error processing input path:', error);
  }
}

main();

/**
 Losse bestanden converteren: (Let op: gebruik .md als output-file-path extensie)
 node scripts/convert.js <input-file-path> <output-file-path> <...tags>
  
 Folders converteren:
 node scripts/convert.js <input-directory-path> <output-directory-path> <...tags>
  
 Notes: 
 - Scenario elementen moeten voorafgegaan worden door een Regel-element.
 - Scenario elementen zonder een voorafgaand Regel-element worden genegeerd.
 - Scenario elementen zonder een tag worden genegeerd.
 - Regel elementen zonder een tag worden genegeerd.
  
 Voorbeeld:
 ----------
 Functionaliteit: Een omschrijving van de functionaliteit

  @tag
  Regel: De regel

    @tag
    Scenario: Een beschrijving van het scenario
      Gegeven ...
      En ...
      Als ...
      Dan ...
 ----------

 * Frontmatter is automatisch gegenereerd. De frontmatter bevat de volgende items:
    - layout: page-with-side-nav
    - title: <feature-name>

 * De volgende Gherkin keywords worden ondersteund:
    - Functionaliteit
    - Achtergrond
    - Feature
    - Regel
    - Scenario
    - Abstract Scenario
    - Voorbeelden
 */