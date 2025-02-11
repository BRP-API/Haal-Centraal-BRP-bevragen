const fs = require('fs').promises;
const { parse } = require('gherkin-io');

function toTable(dataTable) {
  let markdown = '';
  dataTable.rows.forEach((row, index) => {
    markdown += `| ${row.cells.map(cell => cell.value.replace(/</g, '\`<').replace(/>/g, '>\`')).join(' | ')} |\n`;
    if (index === 0) {
      markdown += `| ${row.cells.map(() => '---').join(' | ')} |\n`;
    }
  });
  return markdown;
}

function toExamples(examples) {
  let markdown = '';
  examples.forEach(example => {
    markdown += `#### ${example.keyword}\n\n`;
    markdown += `| ${example.header.cells.map(cell => cell.value).join(' | ')} |\n`;
    markdown += `| ${example.header.cells.map(() => '---').join(' | ')} |\n`;
    example.body.map(body => {
      markdown += '| ';
      body.cells.forEach(cell => {
        markdown += `${cell.value} |`;
      });
      markdown += '\n';
    });
  });
  return markdown;
}

function astToMarkdown(gherkinAST, tags) {
  let markdown = '';

  const feature = gherkinAST.feature;
  markdown += `# ${feature.keyword}: ${feature.name}\n\n`;

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
            markdown += '\n';
            markdown += toTable(step.dataTable);
            markdown += '\n';
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
                    markdown += `- ${step.keyword.replace('*', "En")} ${step.text}\n`;
                    if (step.dataTable) {
                      markdown += '\n';
                      markdown += toTable(step.dataTable);
                      markdown += '\n';
                    }
                  });
                  markdown += '\n';
                }
              })
            }

            // Convert Abstract Scenario
            if (ruleElement.keyword === 'Abstract Scenario') {
              let scenarioTags = ruleElement.tags;
              scenarioTags.forEach(tag => {
                if (tags.includes(tag.name)) {
                  const escapedName = ruleElement.name.replace(/</g, '\`<').replace(/>/g, '>\`');
                  markdown += `### ${ruleElement.keyword}: ${escapedName}\n\n`;
                  ruleElement.steps.forEach(step => {
                    markdown += `- ${step.keyword.replace('*', "En")} ${step.text}\n`;
                    if (step.dataTable) {
                      markdown += '\n';
                      markdown += toTable(step.dataTable);
                      markdown += '\n';
                    }
                  });

                  if (ruleElement.examples) {
                    markdown += '\n';
                    markdown += toExamples(ruleElement.examples);
                    markdown += '\n';
                  }

                  markdown += '\n';
                }
              })
            }
          });
        }
      }
    });
  }

  return markdown;
}

async function convertGherkinToMarkdown(inputPath, outputPath, tags) {
  try {
    const featureFileContent = await fs.readFile(inputPath, 'utf8');
    const document = await parse(featureFileContent, inputPath);
    const gherkinAST = JSON.parse(JSON.stringify(document));
    const markdownContent = astToMarkdown(gherkinAST, tags);

    await fs.writeFile(outputPath, markdownContent);

    console.log(`Markdown file generated successfully in ${outputPath}`);
  } catch (error) {
    console.error('Error converting Gherkin to Markdown:', error);
  }
}


module.exports = { convertGherkinToMarkdown };