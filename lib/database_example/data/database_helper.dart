import 'package:formvalidation/database_example/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _oncreate);
    return ourDb;
  }

  void _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Table is created");
  }

  //Insert into db
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.insert("User", user.toMap());
    print(response);
    return response;
  }

  // Delete from the db
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.delete("User");
    return response;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query("User", columns: ["id", "username" "password"]);

    List<User> users = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.map(maps[i]));
      }
      print("all the users are ${users.length}");
      return users;
    }
    return null;
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query("User",
        columns: ["id", "username", "password"],
        where: '"id" = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.map(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete("User", where: '"id" = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient
        .update("User", user.toMap(), where: '"id" = ?', whereArgs: [user.id]);
  }
//
//  Future close() async {
//    var dbClient = await db;
//    dbClient.close();
//  }
}
