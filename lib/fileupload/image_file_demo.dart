import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class MyImagePickerDemo extends StatefulWidget {
  @override
  _MyImagePickerDemoState createState() => _MyImagePickerDemoState();
}

class _MyImagePickerDemoState extends State<MyImagePickerDemo> {
  File _image;
  File _videoFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //this method is called to upload the image to the server
//    uploadImageToServer(image);
    if (image != null) {
      setState(() {
        _image = image;
        print(_image);
      });
    }
  }

  Future getVideo() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _videoFile = video;
        print(_videoFile);
      });
    }
  }

  Future getRecord() async {
    var video = await ImagePicker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      setState(() {
        _videoFile = video;
        print(_videoFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ImageContent(context),
            RaisedButton(
              onPressed: getVideo,
              child: Text("Play video"),
            ),
            RaisedButton(
              onPressed: () {
                getRecord();
              },
              child: Text("Record"),
            ),
            VideoContent2(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

//  void uploadImageToServer(filePath) async {
//    //Get the base file name
//    String fileName = basename(filePath.path);
//    print("file base name: $fileName");
//    try {
//      FormData formData =
//          FormData.fromMap({"file": UploadFileInfo(filePath, fileName)});
//      Response response = await Dio().post("laundry.com/file", data: formData);
//      print("file upload response: $response");
//      //Show the incoming msg in snackbar
//      _showSnakBarMsg(response.data['message $response']);
//    } catch (e) {
//      print("Exception caught $e");
//    }
//  }

  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  Widget ImageContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child:
              _image == null ? Text('No image selected.') : Image.file(_image),
        ),
      ],
    );
  }

  Widget VideoContent2(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: _videoFile == null
              ? Text('No Video selected.')
              : Image.file(_videoFile),
        ),
      ],
    );
  }

//  Widget VideoContent(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Container(
//          child: _videoFile == null
//              ? Text('No video selected.')
//              : Chewie(
//                  controller: ChewieController(
//                    videoPlayerController:
//                        VideoPlayerController.file(_videoFile),
//                    aspectRatio: 3 / 2,
//                    autoPlay: true,
//                    looping: true,
//                  ),
//                ),
//        ),
//      ],
//    );
//  }
}
