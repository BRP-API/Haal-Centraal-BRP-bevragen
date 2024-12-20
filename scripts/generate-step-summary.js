const fs = require('fs');
const path = require('path');

function processFile(inputPath, outputPath) {
    const content = fs.readFileSync(inputPath, 'utf8');
    const lines = content.split('\n');
    const results = [];
    let footerLines = [];

    if (lines.length >= 4) {
        footerLines = lines.slice(-4);
    }

    lines.forEach((line) => {
        const match = line.match(/^\d+\) Scenario: .*# (.+:\d+)/);
        if (match) {
            results.push((results.length + 1) + ": " + match[1]);
        }
    });

    let finalOutput = footerLines.join('\n') + '\n\n';
    if (results.length > 0) {
        finalOutput += `<details>\n<summary>Bestandsnamen en regelnummers</summary>\n\n`;
        finalOutput += results.join('\n') + '\n';
        finalOutput += `\n</details>\n`;
    }

    fs.writeFileSync(outputPath, finalOutput, 'utf8');
}

processFile(process.argv[2], process.argv[3]);
