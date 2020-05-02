import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String VISITING_KEY = "isVisited";

class SharePreferenceDemo extends StatefulWidget {
  @override
  _SharePreferenceDemoState createState() => _SharePreferenceDemoState();
}

class _SharePreferenceDemoState extends State<SharePreferenceDemo> {
  String data = "";
  String nameKey = "dataKey";
  TextEditingController controller = TextEditingController();

  setVisiting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool("visit", true);
  }

  getVisiting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("visit") ?? false;
  }

  // Alternative method

  Future<bool> saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, controller.text);
  }

  Future<String> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nameKey);
  }

  @override
  void initState() {
    super.initState();
  }

  setData() {
    loadData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

//  fetchProduct() async {
//    try {
//      final response = await HttpRequest.getString(
//          "https://laundry-back.herokuapp.com/api/products");
//      print(response);
//      print("Successful");
//    } catch (error) {
//      print(error);
//      print("Failed");
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference Demo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Proceed"),
              color: Colors.blue,
              onPressed: () async {
                bool visitingflag = await getVisiting();
                setVisiting();
                if (visitingflag == true) {
                  Navigator.pushNamed(context, '/welcome');
                } else {
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter your name",
                labelText: "Name",
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0)),
              ),
            ),
            RaisedButton(
              onPressed: () {
                saveData();
                print(saveData());
              },
              child: Text("SAVE DATA"),
            ),
            Text(data),
            RaisedButton(
              onPressed: () {
                setData();
                print(setData());
              },
              child: Text("GET DATA"),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome Page"),
      ),
      body: Container(
        child: Text("Welcome you can go ahead and signup"),
      ),
    );
  }
}

class VisitingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        child: Text("Welcome to home page you already visited"),
      ),
    );
  }
}
