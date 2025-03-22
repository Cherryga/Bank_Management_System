const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    password: 'agmgngcg',
    host: 'localhost',
    port: 5432,
    database: 'bank'
});
module.exports = pool;
