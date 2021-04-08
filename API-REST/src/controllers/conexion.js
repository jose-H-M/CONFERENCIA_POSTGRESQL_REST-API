const { Pool } = require('pg');

const pool = new Pool({
    host: 'localhost',
    user: 'postgres',
    password: '',
    database: 'pg1',
    port: '5432'
});

module.exports = {pool};