function stringifyValues(o) {
    if(o === undefined) return o;

    Object.keys(o).forEach(k => {
        if (typeof o[k] === 'object') {
            o[k] = stringifyValues(o[k]);
        }
        else {
            o[k] = '' + o[k];
        }
    });

    return o;
}

// https://gist.github.com/bennettmcelwee/06f0cadd6a41847f848b4bd2a351b6bc
function jsonStringify (obj, depth = 1, space = '\t') {
    // recursion limited by depth arg
    if (!obj || typeof obj !== 'object') return JSON.stringify(obj, null, space);

    let curDepthResult = '"<?>"'; // too deep
    if (depth > 0) {
        curDepthResult = Object.keys(obj)
            .map( (key) => {
                let val = jsonStringify(obj[key], depth - 1, space);
                if (val === undefined) {
                    val = 'null';
                }
                return `"${key}": ${val}`;
            })
            .join(', ');
        curDepthResult = `{${curDepthResult}}`;
    }

    return JSON.stringify(JSON.parse(curDepthResult), null, space);
}

module.exports = {
    stringifyValues,
    jsonStringify
};
