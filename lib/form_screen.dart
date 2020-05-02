import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _email;
  String _password;
  String _url;
  String _phoneNumber;
  String _calories;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Name"),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is required";
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return "Email is required";
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required";
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Url"),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return "Url is required";
        }
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Phone number"),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required";
        }
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Calories"),
      keyboardType: TextInputType.text,
      validator: (String value) {
        int calories = int.tryParse(value);
        if (calories == null || calories <= 0) {
          return "Calories must be greater than 0";
        }
      },
      onSaved: (String value) {
        _calories = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form")),
      body: Container(
        margin: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              _buildEmail(),
              _buildPassword(),
              _buildURL(),
              _buildPhoneNumber(),
              _buildCalories(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_name);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
