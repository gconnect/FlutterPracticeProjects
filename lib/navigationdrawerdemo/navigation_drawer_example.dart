import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NavigationDrawerExample extends StatefulWidget {
  @override
  _NavigationDrawerExampleState createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appbar Demo"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Glory"),
              accountEmail: Text("agat@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("G"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  child: Text("C"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.add_to_home_screen),
              ),
              title: Text("Home"),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.android),
              ),
              title: Text("Android"),
              onTap: () {
                Navigator.pushNamed(context, "/drawer");
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.close),
              ),
              title: Text("Close"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Show Toast"),
                    onPressed: () {
                      showToast("hello from toast");
                    },
                  ),
                  RaisedButton(
                    child: Text("Show Snackbar"),
                    onPressed: () {
                      showSnackBar(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Hello Snackbar"),
      duration: Duration(seconds: 1),
    ));
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
