
const express = require('express');
const app = express();
let cors = require('cors');

//Utilizar funciones de express para gestionar datos en formato json
app.use(express.json());

//Utilizar cors
app.use(cors());

//Utilizar las rutas definidas en rutas.js de routes
app.use(require('./routes/rutas'))

//Escuchar en puerto 3000
app.listen(3000);
console.log('Server on port 3000');