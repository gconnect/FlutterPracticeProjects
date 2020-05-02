import 'package:flutter/material.dart';
import 'package:formvalidation/nestedtabdemo/HomeforyouTab.dart';
import 'package:formvalidation/nestedtabdemo/MovieTab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HomeTopChartsTab.dart';

class HomeTopTab extends StatefulWidget {
  int colorVal;
  HomeTopTab(this.colorVal);
  _HomeTopTabState createState() => _HomeTopTabState();
}

class _HomeTopTabState extends State<HomeTopTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0xffff5722;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor: Color(0xffff5722),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 0
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "For you",
                  style: TextStyle(
                      color: _tabController.index == 0
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 1
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "Top charts",
                  style: TextStyle(
                      color: _tabController.index == 1
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 2
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      color: _tabController.index == 2
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 3
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "Editors",
                  style: TextStyle(
                      color: _tabController.index == 3
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 4
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "Premiun",
                  style: TextStyle(
                      color: _tabController.index == 4
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(Icons.access_alarms,
                    color: _tabController.index == 5
                        ? Color(widget.colorVal)
                        : Colors.grey),
                child: Text(
                  "Family",
                  style: TextStyle(
                      color: _tabController.index == 5
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            HomeForYouTab(),
            HomeTopChartTab(),
            MovieTab(),
            MovieTab(),
            MovieTab(),
            Container(child: Text("Hello Family"))
          ],
        ),
      ),
    );
  }
}
