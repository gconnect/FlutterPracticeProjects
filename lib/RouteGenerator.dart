import 'package:flutter/material.dart';
import 'package:formvalidation/AppbarTabDemo.dart';
import 'package:formvalidation/Introduction_Screen.dart';
import 'package:formvalidation/carousel/carousel_demo.dart';
import 'package:formvalidation/carousel/carousel_page.dart';
import 'package:formvalidation/database_example/pages/homepage.dart';
import 'package:formvalidation/database_example/pages/login_page.dart';
import 'package:formvalidation/database_example/todolist/todo_form.dart';
import 'package:formvalidation/database_example/todolist/todo_list.dart';
import 'package:formvalidation/fileupload/file_picker_demo.dart';
import 'package:formvalidation/fileupload/file_upload_demo.dart';
import 'package:formvalidation/fileupload/image_file_demo.dart';
import 'package:formvalidation/fileupload/pdf_from_asset_and_url.dart';
import 'package:formvalidation/fileupload/videoplaydemo.dart';
import 'package:formvalidation/listviews/customScrollAppbarListView.dart';
import 'package:formvalidation/listviews/grid_view_demo.dart';
import 'package:formvalidation/listviews/horizontal_listview.dart';
import 'package:formvalidation/listviews/nested_list_view.dart';
import 'package:formvalidation/listviews/simple_list_view_with_detail.dart';

import 'package:formvalidation/navigationdrawerdemo/navigation_drawer_example.dart';
import 'package:formvalidation/navigationdrawerdemo/navigationdemo.dart';
import 'package:formvalidation/navigationdrawerdemo/navigationdrawer.dart';
import 'package:formvalidation/nestedtabdemo/NestedTabDemo.dart';
import 'package:formvalidation/onboarding.dart';
import 'package:formvalidation/rawjson/json_api_get.dart';
import 'package:formvalidation/rawjson/json_demo.dart';
import 'package:formvalidation/rawjson/json_server_demo.dart';
import 'package:formvalidation/sharedPreference_demo/sharedpreference_demo.dart';

import 'bottomnavigation/curvebuttonNavigation.dart';
import 'data/TabChoice.dart';
import 'fileupload/video_player_demo.dart';
import 'localdatabase/database_demo.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TodoListPage());
        break;
//      case NewPageState.routeName:
//        if (routeSettings.name == NewPageState.routeName) {
//          return MaterialPageRoute(
//              builder: (_) => Page1(
//                    title: newPageArg.title,
//                    bodyText: newPageArg.bodyText,
//                  ));
//        }
//        break;
      case '/add':
        return MaterialPageRoute(builder: (_) => TodoForm());
        break;
      case '/todo_list':
        return MaterialPageRoute(builder: (_) => TodoListPage());
        break;

      case NewPageState.routeName:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => Page1(
                    title: args,
                    bodyText: args,
                  ));
        }
        break;
      case '/second':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => PDFViewPage(
              path: args,
            ),
          );
        }
        return _errorRoute();
        break;
      case '/detail':
        if (args is TabChoice) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(
              choice: args,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error Page"),
        ),
        body: Center(
          child: Text("Error Occured"),
        ),
      );
    });
  }
}
