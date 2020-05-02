import 'package:flutter/material.dart';

class BottomNavigationDemo extends StatefulWidget {
  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  int _currentItem = 0;
  final tabs = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Transfers"),
    ),
    Center(
      child: Text("Payments"),
    ),
    Center(
      child: Text("Balance"),
    ),
    Center(
      child: Text("Settings"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation"),
      ),
      body: tabs[_currentItem],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentItem,
        onTap: (index) {
          setState(() {
            _currentItem = index;
          });
        },
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.threed_rotation),
              title: Text("Transfers"),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text("Payments"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              title: Text("Balance"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
