import 'package:flutter/material.dart';
import 'package:formvalidation/database_example/todolist/todo.dart';

class DetailTodoScreen extends StatefulWidget {
  final Todo todo;

  DetailTodoScreen({this.todo});

  @override
  _DetailTodoScreenState createState() => _DetailTodoScreenState();
}

class _DetailTodoScreenState extends State<DetailTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed Todo"),
      ),
      body: Column(
        children: <Widget>[
          Text(widget.todo.title),
          Text(widget.todo.done.toString())
        ],
      ),
    );
  }
}
