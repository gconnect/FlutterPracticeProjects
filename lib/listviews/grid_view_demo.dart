import 'package:flutter/material.dart';
import 'package:formvalidation/data/TabChoice.dart';

import 'horizontal_listview.dart';

class GridViewDemo extends StatefulWidget {
  @override
  _GridViewDemoState createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View"),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.camera),
              child: Text("Snap"),
            ),
            Tab(
              icon: Icon(Icons.android),
              child: Text("Android"),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          GridOne(),
          GridTwo(),
        ],
      ),
    );
  }
}

class GridOne extends StatefulWidget {
  @override
  _GridOneState createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(30, (index) {
        return Card(
          color: Colors.yellow,
          margin: EdgeInsets.all(10.0),
          child: Container(
            child: Align(
              child: Text("$index"),
            ),
          ),
        );
      }),
    );
  }
}

class GridTwo extends StatefulWidget {
  @override
  _GridTwoState createState() => _GridTwoState();
}

class _GridTwoState extends State<GridTwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Category(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "First Product"),
          Category(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Second Product"),
          Category(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Third Product"),
          Category(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Fourth Product")
        ],
      ),
    );
  }
}
