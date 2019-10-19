import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

const base = 'http://smartcycle.ljhnas.com';

class CameraModify extends StatefulWidget {
  File imageFile;
  String imagePath;

  CameraModify({this.imageFile, this.imagePath});

  @override
  _CameraModifyState createState() => _CameraModifyState();
}

class _CameraModifyState extends State<CameraModify> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.file(widget.imageFile),
          RaisedButton(
            child: Text("이미지 업로드"),
            onPressed: () {
              _uploadImage(widget.imageFile);
            },
          ),
        ],
      ),
    );
  }
}

void _uploadImage(File image) {
  if (image == null) return;
  String base64Image = base64Encode(image.readAsBytesSync());
  String fileName = image.path.split("/").last;

  // !! SAMPLE EMAIL USED

  var jsonData = ''
      '{ "img":$base64Image, "name": $fileName, "userEmail":"kwonkiseok7@gmail.com" }';

  http.post(base + "/imageUpload", body: {"data": jsonData}).then((res) {
    print(res.statusCode);
  }).catchError((err) {
    print(err);
  });
}