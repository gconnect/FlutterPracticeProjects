import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionScreenDemo extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset("assets/images/payowners.jpeg"),
          title: "Payowners",
          body: "This is payowners",
          footer: Text(
            "Glory",
            style: TextStyle(color: Colors.black),
          )),
      PageViewModel(
          image: Image.asset("assets/images/payowners.jpeg"),
          title: "Payowners",
          body: "This is payowners",
          footer: Text(
            "Glory",
            style: TextStyle(color: Colors.black),
          )),
      PageViewModel(
          image: Image.asset("assets/images/payowners.jpeg"),
          title: "Payowners",
          body: "This is payowners",
          footer: Text(
            "Glory",
            style: TextStyle(color: Colors.black),
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        done: Text(
          "Done",
          style: TextStyle(color: Colors.black),
        ),
        onDone: () {},
        onSkip: () {},
      ),
    );
  }
}
