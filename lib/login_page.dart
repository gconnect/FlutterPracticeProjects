import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login auth"),
      ),
      body: Center(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection()
                ],
              ),
      )),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Code Land Form",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          textEmail("Email", Icons.email),
          SizedBox(
            height: 30.0,
          ),
          textPassword("Password", Icons.lock),
        ],
      ),
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget textEmail(String title, IconData icon) {
    return TextFormField(
      controller: emailController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(icon)),
      validator: (String value) {
        if (value.isEmpty) {
          return "Email is required";
        }
      },
      onSaved: (String value) {
        emailController.text = value;
        print(value);
      },
    );
  }

  Widget textPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(icon)),
    );
  }

  signIn(String email, String password) async {
    Map data = {'email': email, 'password': password};
    var jsonData = null;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http
        .post("https://laundry-back.herokuapp.com/api/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.body);
      _isLoading = false;
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
//          _isLoading = false;
        },
        color: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          "Sign in",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
