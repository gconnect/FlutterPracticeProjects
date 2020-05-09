import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonAPIGetDemo extends StatefulWidget {
  @override
  _JsonAPIGetDemoState createState() => _JsonAPIGetDemoState();
}

class _JsonAPIGetDemoState extends State<JsonAPIGetDemo> {
  //Insect pest API
  final String url = "http://www.mocky.io/v2/5e6446133400005a003387ef";
// Laundry API
//  final String url = "https://laundry-back.herokuapp.com/api/products";
  List data;

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "Application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['insect'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON GET Request"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(data[index]['name']),
                  subtitle: Text(data[index]['longitude']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index]['insect_image']),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: data == null ? "Loading..." : data.length,
      ),
    );
  }
}
