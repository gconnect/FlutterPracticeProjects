import 'dart:convert';

import 'package:flutter/material.dart';

class JsonDemo extends StatefulWidget {
  @override
  _JsonDemoState createState() => _JsonDemoState();
}

class _JsonDemoState extends State<JsonDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Demo"),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var data = jsonDecode(snapshot.data.toString());
            print(data);
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(data[index]['title']),
                        subtitle: Text(data[index]['beloved_message']),
                      ),
                    )
                  ],
                );
              },
              itemCount: data.length,
            );
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/devotional_oct.json"),
        ),
      ),
    );
  }
}
