import 'package:flutter/material.dart';

class NestedListView extends StatefulWidget {
  @override
  _NestedListViewState createState() => _NestedListViewState();
}

class _NestedListViewState extends State<NestedListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nested ListView"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 20,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Card(
                      child: Text("first list $index"),
                    ),
                  );
                }),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      child: Text("second list $index"),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
