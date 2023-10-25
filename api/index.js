const express = require('express');
const cors = require('cors');
const auth = require("./middleware/authentication");
const path = require('path');
const dotenv = require('dotenv')
var http = require('http');
var debug = require('debug')('server:server');

require('./db/conn');

const app = express();
const port = process.env.PORT || '3000';

app.use(cors());
app.use(auth);

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

app.set('port', port);

var server = http.createServer(app);



function onError(error) {
    if (error.syscall !== 'listen') {
        throw error;
    }

    var bind = typeof port === 'string'
        ? 'Pipe ' + port
        : 'Port ' + port;

    switch (error.code) {
        case 'EACCES':
            console.error(bind + ' requires elevated privileges');
            process.exit(1);
            break;
        case 'EADDRINUSE':
            console.error(bind + ' is already in use');
            process.exit(1);
            break;
        default:
            throw error;
    }
}

function onListening() {
    console.log(`worker ${process.pid} started`);
    var addr = server.address();
    var bind = typeof addr === 'string'
        ? 'pipe ' + addr
        : 'port ' + addr.port;
    debug('Listening on ' + bind);
}



server.listen(port);
server.on('error', onError);
server.on('listening', onListening);