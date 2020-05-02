import 'package:flutter/material.dart';
import 'package:formvalidation/data/TabChoice.dart';

class HorizontalListViewDemo extends StatefulWidget {
  @override
  _HorizontalListViewDemoState createState() => _HorizontalListViewDemoState();
}

class _HorizontalListViewDemoState extends State<HorizontalListViewDemo> {
  List<bool> _data = List<bool>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _data.add(false);
    }
  }

  void onChange(bool value, int index) {
    setState(() {
      _data[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Horizontal Listview"),
        ),
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      value: _data[index],
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text("Click me item $index"),
                      onChanged: (bool value) {
                        onChange(value, index);
                      },
                    )
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.vertical,
        ));
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category(this.image_location, this.image_caption);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: InkWell(
        hoverColor: Colors.yellow,
        onTap: () {},
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 300,
                width: 300,
                child: Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Image.asset(image_location),
                    subtitle: Text(image_caption),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizonalScrollView extends StatefulWidget {
  @override
  _HorizonalScrollViewState createState() => _HorizonalScrollViewState();
}

class _HorizonalScrollViewState extends State<HorizonalScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horizonal Scrollview"),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
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
