import 'package:flutter/material.dart';

class CheckBoxExample extends StatefulWidget {
  @override
  _CheckBoxExampleState createState() => _CheckBoxExampleState();
}

class _CheckBoxExampleState extends State<CheckBoxExample> {
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkbox"),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Checkbox(
              value: checkboxValue,
              onChanged: (bool value) {
                print(value);
                setState(() {
                  checkboxValue = value;
                });
              },
            ),
            Text("Notification"),
            Checkbox(
              value: checkboxValue,
              onChanged: (bool value) {
                print(value);
                setState(() {
                  checkboxValue = value;
                });
              },
            ),
            Text("Settings")
          ],
        ),
      ),
    );
  }
}
