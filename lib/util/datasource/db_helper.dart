import 'package:collection/collection.dart';
import 'package:flutter_bana_app/util/datasource/query/history_query.dart';
import 'package:flutter_bana_app/util/datasource/query/user_query.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  //membuat method singleton
  static final DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  final tables = [
    UserQuery.createTable,
    HistoryQuery.createTable
  ]; // membuat daftar table yang akan dibuat

  final dropTables = [
    UserQuery.dropTable,
    HistoryQuery.dropTable,
  ];

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'test.db'),
        onCreate: (db, version) {
      tables.forEach((table) async {
        await db.execute(table).then((value) {
          print("berhasil ");
        }).catchError((err) {
          print("errornya ${err.toString()}");
        });
      });
      //initial data
      insert(UserQuery.tableName,
          {"name": "alice", "password": "alice123", "amount": 1000});
      insert(UserQuery.tableName,
          {"name": "bob", "password": "bob123", "amount": 2000});
      print('Table Created');
    }, version: 1);
  }

  insert(String table, Map<String, Object> data) {
    openDB().then((db) {
      db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
  }

  Future<List> getData(String tableName) async {
    final db = await openDB();
    var result = await db.query(tableName);
    return result.toList();
  }

  Future<Map<String, Object?>> getDataUserByName(String name) async {
    final db = await openDB();
    var result = await db.rawQuery("select * from users where name='$name'");
    return result.isNotEmpty ? result.toList().first : {};
  }

  Future<Map<String, Object?>> getDataUserByNameAndPassword(
      String name, String password) async {
    final db = await openDB();
    var result = await db.rawQuery(
        "select * from users where name='$name' and password='$password'");
    return result.isNotEmpty ? result.first : {};
  }

  Future<Map<String, Object?>> getCurrentUser(String name) async {
    final db = await openDB();
    var result = await db.rawQuery("select * from users where name='$name'");
    return result.isNotEmpty ? result.first : {};
  }

  Future<Map<String, Object?>> getDataUserByNameAndPassword2(
      String name, String password) async {
    final db = await openDB();
    var result = await db.rawQuery(
        "select * from users where name='$name' and password='$password'");
    return result.isNotEmpty ? result.first : {};
  }

  Future<Map<String, Object?>> getAuthStatus(
      String name, String password) async {
    final db = await openDB();
    var result = await db.rawQuery(
        "select * from users where name='$name' and password='$password'");
    return result.isNotEmpty ? {'status': 'authenticated'} : {};
  }

  Future<String> dropTable(String dropTable) async {
    final db = await openDB();
    await db.execute(dropTable);
    return "ok";
  }

  Future<String> dropDatabase() async {
    final dbPath = await sqlite.getDatabasesPath();
    databaseFactory.deleteDatabase(path.join(dbPath, 'test.db'));
    return "ok";
  }
}
