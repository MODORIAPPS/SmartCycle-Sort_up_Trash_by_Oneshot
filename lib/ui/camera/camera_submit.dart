import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

const base = 'http://smartcycle.ljhnas.com';

class CameraSubmit extends StatefulWidget {
  File imageFile;
  String imagePath;

  CameraSubmit({this.imageFile, this.imagePath});

  @override
  _CameraSubmitState createState() => _CameraSubmitState();
}

class _CameraSubmitState extends State<CameraSubmit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.file(widget.imageFile),
          RaisedButton(
            child: Text("이미지 업로드"),
            onPressed: () {
              //_uploadImage(widget.imageFile);
            },
          ),
        ],
      ),
    );
  }
}

