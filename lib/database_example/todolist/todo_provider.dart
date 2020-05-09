import 'package:formvalidation/database_example/todolist/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class TodoProvider {
  static final TodoProvider _instance = TodoProvider.internal();
  TodoProvider.internal();

  factory TodoProvider() => _instance;
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
    String path = join(documentDirectory.path, "todo.db");
    var ourDb = await openDatabase(path, version: 2, onCreate: _oncreate);
    return ourDb;
  }

  void _oncreate(Database db, int version) async {
    await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
    print("Table is created");
  }

  Future<Todo> insert(Todo todo) async {
    var dbClient = await db;
    todo.id = await dbClient.insert(tableTodo, todo.toMap());
    print("Todo saved $todo");
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print("Todo list $maps");
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getTodos() async {
    var dbClient = await db;

    var todos = await dbClient
        .query(tableTodo, columns: [columnId, columnDone, columnTitle]);
    List<Todo> todoList = List<Todo>();
    todos.forEach((currentTodo) {
      Todo todo = Todo.fromMap(currentTodo);
      todoList.add(todo);
    });
    print("Todo list $todoList");

    return todoList;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    var dbClient = await db;
    return await dbClient.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
