import 'package:flutter/material.dart';
import 'package:formvalidation/data/TabChoice.dart';
import 'package:formvalidation/listviews/appbar_search_object.dart';
import 'package:formvalidation/main.dart';

import 'appbar_search.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var list = [];
  List<TabChoice> _data;
  ScrollController controller = ScrollController();
  List<TabChoice> filteredList = [];
  SearchAppBarDelegate2 _searchAppBarDelegate;
  @override
  void initState() {
    super.initState();
    _data = getChoices;
    list = _data;
//    filteredList = list;
    _searchAppBarDelegate = SearchAppBarDelegate2(filteredList);
  }

  onSearchView(String value) {
    setState(() {
      filteredList = list.where((item) => item.contains("$value")).toList();
      print(filteredList.length);
      print(list.length);
    });
  }

  navigateToDetail(TabChoice choiceData) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  choice: choiceData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Page and With Detail"),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.all(20.0),
              child: IconButton(
                tooltip: "Search",
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearchPage2(context, _searchAppBarDelegate);
                },
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search here...",
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0)),
              ),
              onChanged: (value) {
                onSearchView(value);
                print(value);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Card(
                      margin: EdgeInsets.all(5.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_data[index].title),
                            Icon(_data[index].icon)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/detail',
                          arguments: (_data[index]));
//                navigateToDetail(_data[index]);
                    },
                  );
                },
                shrinkWrap: true,
                itemCount: _data.length,
                controller: controller,
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final TabChoice choice;

  DetailPage({Key key, this.choice}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.choice.title),
            Icon(widget.choice.icon)
          ],
        ),
      ),
    );
  }
}
