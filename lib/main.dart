import 'package:flutter/material.dart';
import 'package:formvalidation/DropDownDemo.dart';
import 'package:formvalidation/RouteGenerator.dart';
import 'package:formvalidation/form_screen.dart';
import 'package:formvalidation/login_page.dart';
import 'package:formvalidation/radiobutton_example.dart';
import 'package:formvalidation/splash_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'DateTimePickerDemo.dart';
import 'TableDemo.dart';
import 'checkbox_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: DataTimeDemo(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Form land",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Builder(
        builder: (ctx) => RaisedButton(
            textColor: Colors.red,
            child: Text('Submit'),
            onPressed: () {
              Scaffold.of(ctx).showSnackBar(
                SnackBar(
                  content: Text('Profile Save'),
                ),
              );
            }),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Text("Welcome to first page"),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/second",
                  arguments: "Hello there from the first page");
            },
            child: Text("Open second Page"),
          )
        ],
      )),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String data;

  SecondPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print("app is inactive");
        break;
      case AppLifecycleState.paused:
        print("App is paused");
        break;
      case AppLifecycleState.resumed:
        print("App is resumed");
        break;
      case AppLifecycleState.detached:
        print("App is detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("welcome to Second page"),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Open First Page"),
            ),
            Text(widget.data),
            RaisedButton(
              onPressed: () {
                setState(() {
                  spinkit2;
                });
              },
              child: Text("Open spinner"),
            ),
          ],
        ),
      ),
    );
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  final spinkit2 = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );
}
