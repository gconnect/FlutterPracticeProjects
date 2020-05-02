import 'package:flutter/material.dart';
import 'package:formvalidation/nestedtabdemo/HomeforyouTab.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieTab extends StatefulWidget {
  @override
  MovieTabState createState() => MovieTabState();
}

class MovieTabState extends State<MovieTab> {
  final List<String> movies = [
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          CarouselContainer(),
          SizedBox(
            height: 10.0,
          ),
          InstalledApps(context),
          SizedBox(
            height: 10.0,
          ),
          RecommendedApps(context),
        ],
      ),
    );
  }

  Widget CarouselContainer() {
    return CarouselSlider(
      items: movies.map((url) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: 1000,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
          viewportFraction: 0.9,
          height: 200.0,
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true),
    );
  }

  Widget InstalledApps(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Text("Installed Apps"),
    );
  }

  Widget RecommendedApps(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Text("Installed Apps"),
    );
  }
}
