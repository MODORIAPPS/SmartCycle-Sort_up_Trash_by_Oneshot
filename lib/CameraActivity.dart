import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:googleapis/compute/v1.dart';
import 'package:smartcycle/CameraModify.dart';
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
  Future<File> imageFile;
  CameraController controller;

  getImageFromAlbum(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CameraModify(imageFile: imageFile)));
    });
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        okay = true;
        return;
      }

      setState(() {

      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
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
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.photo_album, color: Colors.white),
                      onPressed: () {
                        getImageFromAlbum(ImageSource.gallery);
                      },
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera,
                          color: Colors.white,
                        )),
                    InkWell(
                      child: hasTorch
                          ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_off,
                            color: Colors.white,
                          ))
                          : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_on,
                            color: Colors.white,
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
      ],
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
