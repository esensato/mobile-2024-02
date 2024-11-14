// funções de acesso ao banco de dados sqlite
import 'package:simple_black_jack/jogador_db.dart';
import 'package:sqflite/sqflite.dart';

class Db {

  // abrir / criar o banco de dados
  static Future<Database> abrir() async {

    Database db =  await openDatabase("SimpleBlackJackDB", onCreate: (db, version){
      db.execute("CREATE TABLE TAB_JOGADOR (ID INTEGER PRIMARY KEY, USERNAME TEXT)");
    }, version: 2);

    return db;

  }
  // inserir um novo jogador
  static Future<int> inserir(Database db, JogadorDB jogador) async {

    // converter o objeto jogador em um Map<username, valor>
    var id = await db.insert('TAB_JOGADOR', jogador.toMap());
    return id;

  }

  // consultar jogador pelo username
  static Future<List<Map>> listar(Database db, String username) async {

    // select TAB_JOGADOR where USERNAME = username
    // Ex de retorno: [{ID: 1, USERNAME: 'jogador1'}, {ID: 2, USERNAME: 'jogador2'}]
    return db.query('TAB_JOGADOR', where: "USERNAME = ?", whereArgs: [username]);

  }

  // verifica se existe algum jogador na base
  static Future<List<Map>> obtemJogador(Database db) async {

    // select * from TAB_JOGADOR
    // Ex de retorno: [{ID: 1, USERNAME: 'jogador1'}, {ID: 2, USERNAME: 'jogador2'}]
    return db.query('TAB_JOGADOR');

  }

}