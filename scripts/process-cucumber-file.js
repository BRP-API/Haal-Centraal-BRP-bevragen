const fs = require('fs');

function processFile(inputPath, outputPath, caption) {
    const content = fs.readFileSync(inputPath, 'utf8');
    const lines = content.split('\n');
    const results = [];
    let footerLines = [];

    if (lines.length >= 4) {
        footerLines = lines.slice(-4);
    }

    let finalOutput = `#### ${caption}\n`;
    finalOutput += footerLines.join('\n') + '\n';

    lines.forEach((line) => {
        const match = line.match(/^\d+\) Scenario: .*# (.+:\d+)/);
        if (match) {
            results.push((results.length + 1) + ": " + match[1]);
        }
    });

    if (results.length > 0) {
        finalOutput += `<details>\n<summary>Bestandsnamen en regelnummers</summary>\n\n`;
        finalOutput += results.join('\n') + '\n';
        finalOutput += `\n</details>\n\n`;
    }

    fs.appendFileSync(outputPath, finalOutput, 'utf8');
}

exports.processFile = processFile;
