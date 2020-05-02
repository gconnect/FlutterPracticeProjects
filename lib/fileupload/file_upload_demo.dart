import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileUploadsDemo extends StatefulWidget {
  @override
  FileUploadsDemoState createState() => FileUploadsDemoState();
}

class FileUploadsDemoState extends State<FileUploadsDemo> {
  final imgurl =
      "https://images.unsplash.com/photo-1486608766848-9b9fe0c37b9d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=966&q=80";
  bool downloading = false;
  var progressString = "";

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgurl, "${dir.path}/myImage.jpg",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec, Total: $total");
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Upload Demo"),
      ),
      body: Center(
        child: downloading ? showProgress(context) : Text("No data"),
      ),
    );
  }

  Widget showProgress(BuildContext context) {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card(
//        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 10.0,
            ),
            Text("Downloading File: $progressString")
          ],
        ),
      ),
    );
  }
}
