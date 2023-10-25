const path = require('path');
const fs = require('fs');

const models = {};
const directoryPath = path.join(__dirname);
files = fs.readdirSync(directoryPath);
files.forEach(function (file) {
    let parsedFile = path.parse(file);
    if (parsedFile.name !== 'index' && parsedFile.ext == '.js') {
        models[parsedFile.name.charAt(0).toUpperCase() + parsedFile.name.slice(1)] = require('./' + parsedFile.name);
    }
});

module.exports = models;