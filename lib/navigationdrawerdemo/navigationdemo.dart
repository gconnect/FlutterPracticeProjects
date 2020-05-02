import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationPractice extends StatefulWidget {
  @override
  _NavigationPracticeState createState() => _NavigationPracticeState();
}

class _NavigationPracticeState extends State<NavigationPractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Demo"),
        elevation: debugDefaultTargetPlatformOverride == TargetPlatform.android
            ? 5.0
            : 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.deepOrange, Colors.orangeAccent]),
              ),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Expanded(
                    child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(70.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/brand_icon.png",
                            width: 100,
                            height: 100,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Payowners",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  )
                ],
              )),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Page One"),
              trailing: Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(NewPageState.routeName,
                    arguments: NewPageState("Page 1", "Hello page 1"));
              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text("Page Two"),
              trailing: Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  '/drawer',
                  arguments: Page1(
                    title: "Page Two",
                    bodyText: "Welcome to page 2",
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Page Three"),
              trailing: Icon(Icons.arrow_upward),
            ),
            Divider(),
            CustomListTiles(Icons.home, "Last item", (onTap) {})
          ],
        ),
      ),
      body: Container(
        child: Center(child: Text("Homepage")),
      ),
    );
  }
}

class CustomListTiles extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTiles(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewPageState extends StatelessWidget {
  static const routeName = '/newPage';
  final String title;
  final String bodyText;

  NewPageState(this.title, this.bodyText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
          child: Center(
        child: Text(bodyText),
      )),
    );
  }
}

class Page1 extends StatelessWidget {
  static const routeName = '/page1';
  final String title;
  final String bodyText;

  Page1({Key key, @required this.title, @required this.bodyText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Container(
          child: Center(
        child: Text("Welcome to Page 1"),
      )),
    );
  }
}
