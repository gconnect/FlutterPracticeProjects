import 'package:flutter/material.dart';
import 'package:formvalidation/database_example/data/database_helper.dart';
import 'package:formvalidation/database_example/model/user.dart';
import 'package:formvalidation/database_example/pages/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginPageContract {
  BuildContext _context;
  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _username, _password;
  LoginPagePresenter _loginPagePresenter;
  List<User> user;
  DatabaseHelper helper = DatabaseHelper();

  _LoginPageState() {
    _loginPagePresenter = LoginPagePresenter(this);
  }
  _submit() {
    final form = formkey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _loginPagePresenter.doLogin(_username, _password);
        getUsers();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getUsers();
    });
  }

  getUsers() async {
    try {
      if (user != null) {
        user = await helper.getUsers();
      } else {
        print("No user");
      }
    } catch (e) {
      print(e);
    }
  }
//  void _showSnackbar(String text) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(text),
//    ));
//  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var loginBtn = RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );
    var loginForm = Column(
      children: <Widget>[
        Text("SQlite Login App"),
        Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (val) => val.length == 0 ? "Enter username" : null,
                  onSaved: (val) {
                    _username = val;
                    print(_username);
                  },
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (val) => val.length == 0 ? "Enter password" : null,
                  onSaved: (val) {
                    _password = val;
                    print(_password);
                  },
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              loginBtn,
            ],
          ),
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite MVP login demo"),
        key: scaffoldKey,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            loginForm,
//            UserList(),
          ],
        ),
      ),
    );
  }

  Widget UserList() {
    return FutureBuilder(
      future: getUsers(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        data = getUsers();
        return Card(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Text(data[index].username),
                  Text(data[index].password)
                ],
              );
            },
            itemCount: data.length,
          ),
        );
      },
    );
  }
//  @override
//  void onLoginError(String error) {
//    _showSnackbar(error);
//  }

  @override
  void onLoginSuccess(User user) async {
//    _showSnackbar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = DatabaseHelper();
    await db.saveUser(user);
    Navigator.pushNamed(context, "/welcome");
  }
}
