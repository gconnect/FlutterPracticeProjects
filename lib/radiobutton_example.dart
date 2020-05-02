import 'package:flutter/material.dart';

import 'data/User.dart';

class RadioWidgetDemo extends StatefulWidget {
  RadioWidgetDemo() : super();
  final String title = "Radio Widget Demo";

  @override
  RadioWidgetDemoState createState() => RadioWidgetDemoState();
}

class RadioWidgetDemoState extends State<RadioWidgetDemo> {
  User selectedUser;
  int selectedRadio;
  int selectedRadioTile;
  List<User> users;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getusers();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(User user) {
    selectedUser = user;
    setState(() {});
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (User user in users) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: selectedUser,
          title: Text(user.firstName),
          subtitle: Text(user.lastName),
          onChanged: (currentUser) {
            print("Current user ${currentUser.firstName}");
            setSelectedUser(currentUser);
          },
          selected: selectedUser == user,
        ),
      );
    }
    return widgets;
  }

  showSnackbar(BuildContext context) {
    var snackbar = SnackBar(
      content: Text("Hello snackbar"),
      action: SnackBarAction(
        label: "OKAY",
        onPressed: () {
          print("Okay action");
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Hello from flaot");
          showSnackbar(context);
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        tooltip: "Add one more item",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("USERS"),
          ),
          Column(
            children: createRadioListUsers(),
          ),
          Divider(
            height: 20,
            color: Colors.green,
          ),
          RadioListTile(
            value: 1,
            groupValue: selectedRadioTile,
            title: Text("Radio 1"),
            subtitle: Text("Radio 1 sub"),
            onChanged: (val) {
              print("Radio tile pressed $val");
              setSelectedRadioTile(val);
            },
            activeColor: Colors.red,
            secondary: OutlineButton(
              child: Text("say Hi"),
              onPressed: () {
                print("Say hi");
              },
            ),
            selected: true,
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedRadioTile,
            title: Text("Radio 2"),
            subtitle: Text("Radio 2 sub"),
            onChanged: (val) {
              print("Radio tile pressed $val");
              setSelectedRadioTile(val);
            },
            activeColor: Colors.red,
            secondary: OutlineButton(
              child: Text("say Hi"),
              onPressed: () {
                print("Say hi");
              },
            ),
            selected: false,
          ),
          Divider(
            height: 20,
            color: Colors.green,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              ),
              Radio(
                value: 2,
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
