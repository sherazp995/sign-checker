const path = require('path');
const fs = require('fs');
const router = require('express').Router();

const directoryPath = path.join(__dirname);
files = fs.readdirSync(directoryPath);
files.forEach(function (file) {
    let parsedFile = path.parse(file);
    if (parsedFile.name !== 'index' && parsedFile.ext == '.js') {
        router.use('/' + parsedFile.name, require('./' + parsedFile.name));
    }
});

module.exports = router