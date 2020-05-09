import 'package:flutter/material.dart';
import 'package:formvalidation/database_example/todolist/todo.dart';
import 'package:formvalidation/database_example/todolist/todo_provider.dart';

import 'detail_todo.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TodoProvider todoProvider = TodoProvider();
  List<Todo> todoList = [];
//  bool isUpdating;

  fetchTodos() async {
    var _todo = await todoProvider.getTodos();
    print(_todo);
    setState(() {
      todoList = _todo;
    });
  }

  @override
  void initState() {
    fetchTodos();
    super.initState();
//    isUpdating = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App with Sqflite"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((_) => fetchTodos());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoProvider.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(snapshot.data[index].title),
                      leading: Text(snapshot.data[index].id.toString()),
//                    subtitle: Text(snapshot.data[index].content),
                      onTap: () =>
                          _navigateToDetail(context, snapshot.data[index]),
                      trailing: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          _deleteTodo(snapshot.data[index]);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _deleteTodo(Todo todo) {
    todoProvider.delete(todo.id);
  }

  _updateTodo(Todo todo) {
    todoProvider.update(todo);
  }

  _navigateToDetail(BuildContext context, Todo todo) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailTodoScreen(todo: todo)),
    );
  }
}
