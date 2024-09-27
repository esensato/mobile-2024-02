import * as SQLite from 'expo-sqlite';

const bcodados = SQLite.openDatabaseSync('gastos.db');

export const iniciar = () => {

    bcodados.execSync('CREATE TABLE IF NOT EXISTS gastos (id INTEGER PRIMARY KEY NOT NULL, descricao TEXT NOT NULL, valor REAL NOT NULL)');

    //const ret = bcodados.runSync('DELETE FROM gastos');

    console.log("Banco de dados iniciado");
}

export const inserir = (id: number, descricao: string, valor: number) => {

    const ret = bcodados.runSync('INSERT INTO gastos (id, descricao, valor) VALUES(?, ?, ?)', [id, descricao, valor]);
    console.log("Gasto inserido", id);
    return ret;

}

export const listar = () => {

    return bcodados.getAllSync('SELECT * from gastos');

}