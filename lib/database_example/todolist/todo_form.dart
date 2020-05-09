import 'package:flutter/material.dart';
import 'package:formvalidation/database_example/todolist/todo.dart';
import 'package:formvalidation/database_example/todolist/todo_list.dart';
import 'package:formvalidation/database_example/todolist/todo_provider.dart';

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  String title;
  bool done = false;
  int id;
  TodoProvider todoProvider = TodoProvider();
  List<Todo> todo = [];
  Todo todos;
  bool isUpdating;

  @override
  void initState() {
    fetchTodos();
    super.initState();
    if (todos != null) {
      titleController.text = todos.title;
      done = todos.done;
    }

    isUpdating = false;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Input Page"),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                onChanged: (val) {
                  title = val;
                },
                onSaved: (val) => title = val,
                validator: (val) => val.length == 0 ? "Enter title" : null,
                decoration: InputDecoration(labelText: "Enter title"),
              ),
              Switch(
                value: done,
                onChanged: (value) {
                  setState(() {
                    done = value;
                    print(value);
                  });
                },
                activeTrackColor: Colors.pink,
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
              ),
              RaisedButton(
                onPressed: () async {
                  await validate();
                  setState(() {});
                  print(title);
                  print(done);
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Todo todo = Todo(null, title, done);
        todoProvider.update(todo);
      } else {
        Todo todo = Todo(null, title, done);
        todoProvider.insert(todo);
//      Navigator.pushNamed(context, '/');
        fetchTodos();
        Navigator.pop(context);
      }
    }
  }

  fetchTodos() async {
    var _todo = await todoProvider.getTodos();
    print(_todo);
    setState(() {
      todo = _todo;
    });
  }

  _saveTodo(Todo todo) async {
    if (todo == null) {
      todoProvider.insert(todo);
      Navigator.pop(context, "Your todo has been saved.");
    } else {
      await todoProvider.update(todo);
      Navigator.pop(context);
    }
  }
}
