import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'insect.dart';

const BASE_URL = 'http://www.mocky.io/v2/5e6446133400005a003387ef';

class JsonServerDemo extends StatefulWidget {
  @override
  _JsonServerDemoState createState() => _JsonServerDemoState();
}

class _JsonServerDemoState extends State<JsonServerDemo> {
  var insectList = List<Insect>();
  List<Insect> insectList2 = List<Insect>();
  bool isloading = false;

  Future<List<Insect>> fetchInsects() async {
    try {
      var response = await http.get(BASE_URL);
      if (response.statusCode == 200) {
        setState(() {
          isloading = false;
        });
        var insectJson = jsonDecode(response.body);
        List<dynamic> data = insectJson["insect"];
        for (var insect in data) {
          insectList2.add(Insect.fromJson(insect));
        }
      } else {
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
    return insectList2;
  }

  @override
  void initState() {
    super.initState();
    fetchInsects().then((value) {
      setState(() {
        insectList2.addAll(value);
        isloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON from Server Demo"),
      ),
      body: isloading
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                //Format the date
                var newDateTimeObj2 =
                    new DateFormat("dd-MM-yyyy").parse(insectList2[index].date);
                var myDate = DateFormat.yMMMMEEEEd().format(newDateTimeObj2);

                return Card(
                  child: Column(
                    children: <Widget>[
                      Text(insectList2[index].name),
                      Text(insectList2[index].time),
                      Text(myDate.toString()),
                      Image.network(insectList2[index].insect_image),
                      Text(insectList2[index].longitude)
                    ],
                  ),
                );
              },
              itemCount: insectList2.length,
            )
          : CircularProgressIndicator(),
    );
  }
}
