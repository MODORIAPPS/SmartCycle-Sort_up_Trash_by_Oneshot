import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:smartcycle/CameraModify.dart';
import 'package:smartcycle/TutorialsPage.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:torch/torch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

List<CameraDescription> cameras;
bool hasTorch = false;
bool okay = false;

cameraLaunch() async {
  cameras = await availableCameras();
  hasTorch = await Torch.hasTorch;
  print(hasTorch);
}

class CameraActvity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cameraLaunch();
    return Scaffold(
      body: CameraApp(),
      floatingActionButton: null,
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  File _image;
  CameraController controller;

  getImageFromAlbum(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    goCrop(imageFile);
  }

  goCrop(File source) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: source.path,
        ratioX: 3,
        ratioY: 2,
        toolbarTitle: "사진 편집하기",
        toolbarColor: Colors.black54,
        maxWidth: 640,
        maxHeight: 480);

    setState(() {
      _image = croppedFile;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CameraModify(imageFile: _image)));
    });
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      okay = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return okay
        ? Stack(
      children: <Widget>[
        RotationTransition(
          turns: AlwaysStoppedAnimation(1),
          child: CameraPreview(controller),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.blueAccent,
                      icon: Icon(Icons.photo_album,
                          color: Colors.blueAccent),
                      onPressed: () {
                        getImageFromAlbum(ImageSource.gallery);
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera,
                          color: Colors.blueAccent,
                        )),
                    InkWell(
                      child: hasTorch
                          ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_off,
                            color: Colors.blueAccent,
                          ))
                          : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_on,
                            color: Colors.blueAccent,
                          )),
                      onTap: () {
                        setState(() {
                          if (hasTorch) {
                            hasTorch = false;
                            Torch.turnOff();
                          } else {
                            hasTorch = true;
                            Torch.turnOn();
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => TutorialsPage(pageCode: 2,)),
                  );
                },
                elevation: 10,

                backgroundColor: Colors.white,
                label: Text(
                  "탐색할 물건 촬영",
                  style: fabText,
                  textAlign: TextAlign.center,
                ),
                icon: Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ],
    )
        : Container(
      child: CircularProgressIndicator(),
    );
  }
}

// void _showDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("권한필요"),
//           content: new Text("이 앱을 정상적으로 실행하기 위해 권한이 필요합니다."),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text("닫기"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       });
// }
