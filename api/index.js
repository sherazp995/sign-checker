const express = require('express');
const cors = require('cors');
const auth = require("./middleware/authentication");
const routes = require("./routes");
const dotenv = require('dotenv');
var http = require('http');
var debug = require('debug')('server:server');
dotenv.config();
require('./db/conn');

const app = express();
const port = process.env.PORT || '3000';

app.use(cors());
app.use(auth);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(routes);

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
    var addr = server.address();
    var bind = typeof addr === 'string'
        ? 'pipe ' + addr
        : 'port ' + addr.port;
    debug('Listening on ' + bind);
    console.log('Listening on http://localhost:' + addr.port);
}



server.listen(port, '0.0.0.0');
server.on('error', onError);
server.on('listening', onListening);