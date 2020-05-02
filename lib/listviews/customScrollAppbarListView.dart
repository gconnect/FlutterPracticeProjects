import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatefulWidget {
  @override
  _CustomScrollViewDemoState createState() => _CustomScrollViewDemoState();
}

class _CustomScrollViewDemoState extends State<CustomScrollViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Custom Nested Scrollview"),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  buildList(),
                  buildList(),
                  buildList(),
                  buildList(),
                  buildList(),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget buildList() {
    return Column(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text("Hello custom scrollview");
          },
          itemCount: 6,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}
