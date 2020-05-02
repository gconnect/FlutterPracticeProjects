import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/data/SliderModel.dart';

class OnboardindDemo extends StatefulWidget {
  @override
  OnboardindDemoState createState() => OnboardindDemoState();
}

class OnboardindDemoState extends State<OnboardindDemo> {
  List<SliderModel> slides = List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }

  Widget PageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.grey : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index) {
            return SliderTilesDemo(
              slides[index].imagePath,
              slides[index].title,
              slides[index].desc,
            );
          }),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              color: Colors.white,
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        pageController.animateToPage(slides.length - 1,
                            duration: Duration(microseconds: 400),
                            curve: Curves.linear);
                      },
                      child: currentIndex == 0 ? Text("") : Text("SKIP")),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length; i++)
                        currentIndex == i
                            ? PageIndexIndicator(true)
                            : PageIndexIndicator(false)
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        pageController.animateToPage(currentIndex + 1,
                            duration: Duration(microseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text("NEXT")),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: Platform.isIOS ? 70 : 60,
              color: Colors.blue,
              child: Text(
                "Get Started",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
    );
  }
}

class SliderTilesDemo extends StatelessWidget {
  String imagePath, title, desc;
  SliderTilesDemo(this.imagePath, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 20,
          ),
          Text(title),
          SizedBox(
            height: 20,
          ),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
