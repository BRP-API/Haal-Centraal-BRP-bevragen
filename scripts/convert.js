const fs = require('fs').promises;
const { parse } = require('gherkin-io');

let tags = [];

process.argv.forEach(function (val, index, array) {
  if (index >= 4) {
    tags.push(val.replace('@',''));
  }
});

async function convertGherkinToMarkdown(inputPath, outputPath, tags) {
  try {
    const featureFileContent = await fs.readFile(inputPath, 'utf8');

    const document = await parse(featureFileContent, inputPath);

    const gherkinAST = JSON.parse(JSON.stringify(document));

    function astToMarkdown(gherkinAST) {
      let markdown = '';

      const feature = gherkinAST.feature;
      markdown += `# ${feature.name}\n\n`;

      if (feature.description) {
        markdown += `${feature.description}\n\n`;
      }

      if (feature.elements && Array.isArray(feature.elements)) {
        feature.elements.forEach(element => {
          if (element.keyword === 'Achtergrond') {
            markdown += `## ${element.keyword}\n\n`;
            element.steps.forEach(step => {
              markdown += `- ${step.keyword}: ${step.text}\n`;
              if (step.dataTable) {
                markdown += '  ```\n';
                step.dataTable.rows.forEach(row => {
                  markdown += `  | ${row.cells.map(cell => cell.value).join(' | ')} |\n`;
                });
                markdown += '  ```\n';
              }
            });
            markdown += '\n';
          } else if (element.keyword === 'Regel') {
            markdown += `## ${element.keyword}: ${element.name}\n\n`;
            if (element.elements && Array.isArray(element.elements)) {
              element.elements.forEach(ruleElement => {

                // Convert Regular Scenario
                if (ruleElement.keyword === 'Scenario') {
                  let scenarioTags = ruleElement.tags;
                  scenarioTags.forEach(tag => {
                    if (tags.includes(tag.name)) {
                      markdown += `### ${ruleElement.keyword}: ${ruleElement.name}\n\n`;
                      ruleElement.steps.forEach(step => {
                        markdown += `- ${step.keyword}: ${step.text}\n`;
                        if (step.dataTable) {
                          markdown += '  ```\n';
                          step.dataTable.rows.forEach(row => {
                            markdown += `  | ${row.cells.map(cell => cell.value).join(' | ')} |\n`;
                          });
                          markdown += '  ```\n';
                        }
                      });
                      markdown += '\n';
                    }
                  })
                }

                //TODO: Convert Abstract Scenario
              });
            }
          }
        });
      }

      return markdown;
    }

    const markdownContent = astToMarkdown(gherkinAST);

    await fs.writeFile(outputPath, markdownContent);

    console.log(`Markdown file generated successfully in ${outputPath}`);
  } catch (error) {
    console.error('Error converting Gherkin to Markdown:', error);
  }
}

convertGherkinToMarkdown(process.argv[2], process.argv[3], tags);


// Example usage: <input-filepath> <output-filepath> [..tags]

// node scripts/convert.js features/publish/volledige-naam-bepaling.feature output-volledige-naam-bepaling.md @info-api @data-api

// node scripts/convert.js features/publish/volledige-naam-leveren.feature output-volledige-naam-leveren.md @data-api @info-api

// node scripts/convert.js features/publish/bewoners-vaste-volgorde-leveren.feature output-bewoners-vaste-volgorde.md @info-api