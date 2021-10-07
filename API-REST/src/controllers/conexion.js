const { Pool } = require('pg');

const pool = new Pool({
    host: 		process.env.DB_HOST || 'localhost',
    user: 		process.env.DB_USER || 'postgres',
    password: 	process.env.DB_PASS || '',
    database: 	process.env.DB_NAME || 'pg1',
    port: 		process.env.DB_PORT || '5432' 
});

module.exports = {pool};