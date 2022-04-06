import 'dart:async';
import 'dart:io';

import 'package:imageflip/model/mems_dto.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database_key.dart';
/**
 * Created by Amit Rawat on 4/6/2022.
 */
class SQLiteDbProvider {
  SQLiteDbProvider._();

  static SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  static clear() {
    _database = null;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DatabaseKey.DATABASE_NAME);
    return await openDatabase(path,
        version: DatabaseKey.DATABASE_VERSION,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(" CREATE TABLE " +
          DatabaseKey.TABLE_NAME +
          " (" +
          DatabaseKey.UID +
          " INTEGER  PRIMARY KEY AUTOINCREMENT, " +
          DatabaseKey.ID +
          " TEXT , " +
          DatabaseKey.Name +
          " TEXT , " +
          DatabaseKey.URL +
          " TEXT ) ");
    });
  }

  Future<List<Memes>> getAllMemesData() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(DatabaseKey.TABLE_NAME);
    List<Memes> offlineMemes = [];
    for (var result in results) {
      Memes product = Memes.fromJson(result);
      offlineMemes.add(product);

    }
    return offlineMemes;
  }


  insert(Memes memesObj) async {

    final db = await database;

    var result = await db!.rawInsert(
        "INSERT Into " +
            DatabaseKey.TABLE_NAME +
            " (" +
            DatabaseKey.UID +
            "," +
            DatabaseKey.ID +
            "," +
            DatabaseKey.Name +
            "," +
            DatabaseKey.URL +
            ")" +
            " VALUES (?,?,?,?)",
        [
          null,
          memesObj.id,
          memesObj.name,
          memesObj.url,
        ]);
    print(result);
    return result;
  }

  delete(String id) async {
    final db = await database;
    db!.delete(DatabaseKey.TABLE_NAME,
        where: DatabaseKey.ID + " = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db!.rawDelete("Delete * from " + DatabaseKey.TABLE_NAME);
  }

  Future<bool> uidExists(String? id) async {
    final db = await database;
    var result = await db!.rawQuery("SELECT EXISTS( SELECT 1 FROM " +
        DatabaseKey.TABLE_NAME +
        " WHERE " +
        DatabaseKey.ID +
        "=$id" +
        ")");

    int? exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }
}
