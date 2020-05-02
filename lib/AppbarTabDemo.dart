import 'package:flutter/material.dart';
import 'package:formvalidation/data/TabChoice.dart';

class AppBarTabDemo extends StatefulWidget {
  @override
  AppBarTabDemoState createState() => AppBarTabDemoState();
}

class AppBarTabDemoState extends State<AppBarTabDemo> {
  List<TabChoice> choices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choices = getChoices;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tabbed App Bar"),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map<Widget>((TabChoice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map<Widget>((TabChoice choice) {
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: ChoicePage(
                  choice: choice,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ChoicePage extends StatelessWidget {
  final TabChoice choice;
  const ChoicePage({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 150.0,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
