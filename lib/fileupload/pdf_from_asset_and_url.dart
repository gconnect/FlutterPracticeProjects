import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';

class PdfFromAssetAndUrl extends StatefulWidget {
  @override
  _PdfFromAssetAndUrlState createState() => _PdfFromAssetAndUrlState();
}

class _PdfFromAssetAndUrlState extends State<PdfFromAssetAndUrl> {
  String assetPDFPath = "";
  String urlPDFPath = "";

  @override
  void initState() {
    super.initState();
    getFileFromAsset("assets/inventor.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f) {
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);
      });
    });
  }

  Future<File> getFileFromAsset(String assetName) async {
    try {
      var data = await rootBundle.load(assetName);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/inventor.pdf");
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Bar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                if (assetPDFPath != null) {
                  Navigator.pushNamed(context, '/second',
                      arguments: (assetPDFPath));
                } else {}
              },
              child: Text("Open PDF from Asset"),
            ),
            RaisedButton(
              onPressed: () {
                if (urlPDFPath != null) {
                  Navigator.pushNamed(context, '/second',
                      arguments: (urlPDFPath));
                } else {}
              },
              child: Text("Open PDF from Url"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Upload files"),
            )
          ],
        ),
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class PDFViewPage extends StatefulWidget {
  final String path;

  PDFViewPage({Key key, this.path}) : super(key: key);

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  bool pdfReady = false;
  int totalPage = 0;
  int currentPage = 0;
  PDFViewController _pdfViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document Page")),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                totalPage = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController controller) {
              _pdfViewController = controller;
            },
            onPageChanged: (int page, int totalPages) {
              setState(() {
                currentPage = page;
                totalPage = totalPages;
              });
            },
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          currentPage > 0
              ? FloatingActionButton.extended(
                  onPressed: () {
                    currentPage -= 1;
                    _pdfViewController.setPage(currentPage);
                  },
                  label: Text("Go to ${currentPage - 1}"),
                  backgroundColor: Colors.red,
                )
              : Offstage(),
          currentPage > totalPage
              ? FloatingActionButton.extended(
                  onPressed: () {
                    currentPage += 1;
                    _pdfViewController.setPage(currentPage);
                  },
                  label: Text("Go to ${currentPage + 1}"),
                  backgroundColor: Colors.green,
                )
              : Offstage()
        ],
      ),
    );
  }
}

//class APIService {
//  static final String PDL_URL = "http://www.pdf995.com/samples/pdf.pdf";
//  //This function loads file from url and store in local file
//  static Future<String> loadPDF() async {
//    var response = await http.get(PDL_URL),
//        dir = await getApplicationDocumentsDirectory();
//    File file = File(dir.path + "/data.pdf");
//    await file.writeAsBytes(response.bodyBytes, flush: true);
//    return file.path;
//  }
//}
