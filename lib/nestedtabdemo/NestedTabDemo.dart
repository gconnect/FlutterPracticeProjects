import 'package:flutter/material.dart';
import 'package:formvalidation/nestedtabdemo/MovieTab.dart';

import 'HomeTopTab.dart';

class NestedTabDemo extends StatefulWidget {
  @override
  NestedTabDemoState createState() => NestedTabDemoState();
}

Color primaryColor = Color(0xff109618);

class NestedTabDemoState extends State<NestedTabDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _GoogleAppBar(),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    primaryColor = Color(0xffff5722);
                    break;
                  case 1:
                    primaryColor = Color(0xff3f51b5);
                    break;
                  case 2:
                    primaryColor = Color(0xffe91e63);
                    break;
                  case 3:
                    primaryColor = Color(0xff9c27b0);
                    break;
                  case 4:
                    primaryColor = Color(0xff2196f3);
                    break;
                  default:
                }
              });
            },
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              Tab(
                child: Text(
                  "Game",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              Tab(
                child: Text(
                  "Movie",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              Tab(
                child: Text(
                  "Book",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              Tab(
                child: Text(
                  "Music",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomeTopTab(0xffff5722),
            MovieTab(),
            MovieTab(),
            MovieTab(),
            MovieTab(),
          ],
        ),
      ),
    );
  }
}

Widget _GoogleAppBar() {
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(Icons.menu),
          ),
        ),
        Container(
          child: Text(
            "Google Play",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
              Icons.mic,
              color: Colors.blueGrey,
            ),
            onPressed: null,
          ),
        )
      ],
    ),
  );
}
