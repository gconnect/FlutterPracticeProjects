import 'package:flutter/material.dart';
import 'package:formvalidation/database_example/data/database_helper.dart';
import 'package:formvalidation/database_example/model/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(child: Text("Hello")),
    );
  }
}
