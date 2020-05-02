import 'package:flutter/material.dart';

class DropDownExample extends StatefulWidget {
  @override
  DropDownExampleState createState() => DropDownExampleState();
}

class DropDownExampleState extends State<DropDownExample> {
  String selected;

  List<DropdownMenuItem> dropDownItems() {
    List<DropdownMenuItem<String>> menuItems = [];
    menuItems.add(
        DropdownMenuItem(child: Text("First item"), value: "First Item Value"));
    menuItems.add(DropdownMenuItem(
        child: Text("Second item"), value: "Second Item Value"));
    menuItems.add(
        DropdownMenuItem(child: Text("Third item"), value: "Third Item Value"));
    menuItems.add(DropdownMenuItem(
        child: Text("Fourth item"), value: "Fourth Item Value"));
    menuItems.add(
        DropdownMenuItem(child: Text("Fifth item"), value: "Fifth Item Value"));
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    selected = null;
//    menuItems = List<DropdownMenuItem>();
  }

  Future<String> showAlertDialog(BuildContext context) async {
    TextEditingController editingController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your Name"),
            content: TextField(
              controller: editingController,
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(editingController.value.text.toString());
                },
                child: Text("send"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop down example 2"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            DropdownButton(
              value: selected,
              items: dropDownItems(),
              hint: Text("Select Items"),
              onChanged: (value) {
                print("You select $value");
                setState(() {
                  selected = value;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
