import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  PageController _controller = PageController();
  CarouselSlider carouselSlider;
  int _current = 0;
  var list = [];
  var imgList = [
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/09/11/33/smartphone-1894723_960_720.jpg"
  ];

  @override
  void initState() {
    super.initState();
    list = imgList;
    print(list);
  }

  List<T> mapIndicator<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel Demo"),
      ),
      body: Column(
        children: <Widget>[
          carouselSlider = CarouselSlider(
            items: list.map((url) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          url,
                          fit: BoxFit.fill,
                          width: 1000,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 0.9,
              height: 300.0,
              autoPlay: false,
              aspectRatio: 2.0,
              carouselController: _controller,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, timed) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: mapIndicator<Widget>(list, (index, url) {
              return Container(
                height: 10.0,
                width: 10.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green),
              );
            }),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  previousPage(Duration(milliseconds: 300), Curves.ease);
                },
                child: Text('<'),
              ),
              OutlineButton(
                onPressed: () {
                  goToNext(Duration(milliseconds: 300), Curves.decelerate);
                },
                child: Text('>'),
              )
            ],
          )
        ],
      ),
    );
  }

//  goToPrevious() {
//    carouselSlider.previousPage(duraation: Duration(milliseconds: 300), curve : Curves.ease);
//  }

  //Previous and first page button code not working
  previousPage(Duration duration, Curve curve) {
    setState(() {
//      _current -= 1;
      list[_current] - 1;
    });
  }

  goToNext(Duration duration, Curve curve) {
    list[_current] + 1;
  }
}
