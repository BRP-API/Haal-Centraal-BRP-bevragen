const fs = require('fs').promises;
const { parse } = require('gherkin-io');

const lt = "\`<";
const gt = "\>`";

function toTable(dataTable) {
  let markdown = '';
  dataTable.rows.forEach((row, index) => {
    markdown += `| ${row.cells.map(cell => cell.value.replace(/</g, lt).replace(/>/g, gt)).join(' | ')} |\n`;
    if (index === 0) {
      markdown += `| ${row.cells.map(() => '---').join(' | ')} |\n`;
    }
  });
  return markdown;
}

function toExamplesTable(examples) {
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

function toScenarioSection(element, tags) {
  let markdown = '';
  let elementTags = element.tags.map(tag => tag.name);
  const matchingTags = elementTags.filter(tag => tags.includes(tag));
  if (matchingTags.length === 0) {
    return '';
  }
  markdown += `### ${element.keyword}: ${element.name}\n\n`;
  element.steps.forEach(step => {
    markdown += `- ${step.keyword.replace('*', "En")} ${step.text}\n`;
    if (step.dataTable) {
      markdown += '\n';
      markdown += toTable(step.dataTable);
      markdown += '\n';
    }
  });
  markdown += '\n';
  return markdown;
}

function toAbstractScenarioSection(element, tags) {
  let markdown = '';
  let elementTags = element.tags.map(tag => tag.name);
  const matchingTags = elementTags.filter(tag => tags.includes(tag));
  if (matchingTags.length === 0) {
    return '';
  }
  const escapedName = element.name.replace(/</g, lt).replace(/>/g, gt);
      markdown += `### ${element.keyword}: ${escapedName}\n\n`;
      element.steps.forEach(step => {
        markdown += `- ${step.keyword.replace('*', "En")} ${step.text.replace(/</g, lt).replace(/>/g, gt)}\n`;
        if (step.dataTable) {
          markdown += '\n';
          markdown += toTable(step.dataTable);
          markdown += '\n';
        }
      });

      if (element.examples) {
        markdown += '\n';
        markdown += toExamplesTable(element.examples);
        markdown += '\n';
      }

      markdown += '\n';
  return markdown;
}

function toRuleSection(element, tags) {
  let markdown = '';
  let elementTags = element.tags.map(tag => tag.name);
  const matchingTags = elementTags.filter(tag => tags.includes(tag));
  if (matchingTags.length === 0) {
    return '';
  }

  markdown += `## ${element.keyword}: ${element.name}\n\n`;

  if (element.elements && Array.isArray(element.elements)) {
    element.elements.forEach(ruleElement => {

      // Convert Regular Scenario
      if (ruleElement.keyword === 'Scenario') {
        markdown += toScenarioSection(ruleElement, tags);
      }

      // Convert Abstract Scenario
      if (ruleElement.keyword === 'Abstract Scenario') {
        markdown += toAbstractScenarioSection(ruleElement, tags);
      }
    });
  }

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
        // Convert Rule
        markdown += toRuleSection(element, tags);
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