import 'package:flutter/material.dart';

class HomeForYouTab extends StatefulWidget {
  @override
  _HomeForYouTabState createState() => _HomeForYouTabState();
}

class _HomeForYouTabState extends State<HomeForYouTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          ImageContainer(),
          SizedBox(
            height: 10.0,
          ),
          InstalledApps(),
          SizedBox(
            height: 10.0,
          ),
          RecommendedApps(),
          SizedBox(
            height: 10.0,
          ),
          RecommendedApps(),
        ],
      ),
    );
  }

  Widget ImageContainer() {
    return Container(
      height: 200.0,
      child: Image.network(
        'https://cdn.pixabay.com/photo/2020/04/22/01/59/hands-5075436_960_720.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget InstalledApps() {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: labelContainer("Previously Installed Apps"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: appsRecommendedContainer(),
          )
        ],
      ),
    );
  }

  Widget RecommendedApps() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Recommended Apps"),
          appsRecommendedContainer(),
        ],
      ),
    );
  }

  Widget labelContainer(String name) {
    return Container(
      child: Text(name),
    );
  }

  Widget appsRecommendedContainer() {
    return Container(
      height: 160.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          imageSection(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Amazon Kindle",
              "4.2"),
          SizedBox(
            width: 20.0,
          ),
          imageSection(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Amazon Kindle",
              "4.2"),
          SizedBox(
            width: 20.0,
          ),
          imageSection(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Amazon Kindle",
              "4.2"),
          SizedBox(
            width: 20.0,
          ),
          imageSection(
              "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
              "Amazon Kindle",
              "4.2"),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }

  Widget imageSection(String imagePath, String appName, String rating) {
    return Column(
      children: <Widget>[
        Container(
          height: 70.0,
          width: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          appName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Text(
              appName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            Icon(
              Icons.star,
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}
