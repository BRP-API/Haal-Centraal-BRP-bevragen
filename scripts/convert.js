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
 * Convert files:
 * node scripts/convert.js <input-file-path> <output-file-path> <...tags>
 * For example:
 * node scripts/convert.js features/publish/volledige-naam-bepaling.feature features/published/volledige-naam-bepaling.md @info-api @data-api
 * 
 * Convert directories:
 * node scripts/convert.js <input-directory-path> <output-directory-path> <...tags>
 * For example:
 * node scripts/convert.js features/publish features/published @info-api @data-api
 */