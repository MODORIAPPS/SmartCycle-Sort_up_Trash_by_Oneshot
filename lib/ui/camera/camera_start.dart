import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:image_cropper/image_cropper.dart';
import 'package:lamp/lamp.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/ui/act/act_error_page.dart';
import 'package:smartcycle/ui/camera/camera_recognize_result.dart';
import 'package:smartcycle/ui/tutorials/TutorialsPage.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/ui/camera/camera_submit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

BuildContext mContext;
bool hasTorch = false;

class CameraActvity extends StatefulWidget {
  final CameraDescription camera;

  CameraActvity({Key key, @required this.camera}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraActvity> {
  Future<void> _initializeControllerFuture;
  CameraController _controller;
  File _image;

  Future<void> makeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.ultraHigh);
    _controller.initialize().whenComplete(() {
      setState(() {});
    });

    print("동작");
  }

  getImageFromAlbum(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;

        Route route = MaterialPageRoute(
            builder: (context) =>
                CameraResult(
                  imageFile: _image,
                ));
        Navigator.push(mContext, route);
//      Navigator.of(mContext).push(MaterialPageRoute(
//          builder: (context) => CameraModify(imageFile: _image))
      });
    }
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

    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;

        Route route = MaterialPageRoute(
            builder: (context) =>
                CameraResult(
                  imageFile: _image,
                ));
        Navigator.push(mContext, route);
//      Navigator.of(mContext).push(MaterialPageRoute(
//          builder: (context) => CameraModify(imageFile: _image))
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Lamp.hasLamp.then((data) {
      hasTorch = data;
    });

    _initializeControllerFuture = makeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
//              return ErrorPage(error_msg: snapshot.error.toString(),);
              return ErrorPage(error_msg: snapshot.error.toString());
            } else {
              print("카메라 준비 완료");

              final size = MediaQuery.of(context).size;
              final deviceRatio = size.width / size.height;

              return Stack(
                children: <Widget>[
                  _controller.value.isInitialized
                      ? Transform.scale(
                      scale: _controller.value.aspectRatio / deviceRatio,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: CameraPreview(_controller),
                        ),
                      ))
                      : SCircularProgress(),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: IconButton(
                                  color: Colors.blueAccent,
                                  icon: Icon(Icons.photo_album,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    getImageFromAlbum(ImageSource.gallery);
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: IconButton(
                                    onPressed: () async {
                                      try {
                                        // Ensure that the camera is initialized.
                                        await _initializeControllerFuture;

                                        // Construct the path where the image should be saved using the
                                        // pattern package.
                                        final path = join(
                                          // Store the picture in the temp directory.
                                          // Find the temp directory using the `path_provider` plugin.
                                          (await getTemporaryDirectory()).path,
                                          '${DateTime.now()}.png',
                                        );

                                        // Attempt to take a picture and log where it's been saved.
                                        await _controller.takePicture(path);

                                        // If the picture was taken, display it on a new screen.
//                                      Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) =>
//                                              CameraModify(imagePath: path),
//                                        ),
//                                      );

                                        _image = File(path);

                                        Route route = MaterialPageRoute(
                                            builder: (context) =>
                                                CameraResult(
                                                  imageFile: _image,
                                                ));
                                        Navigator.push(mContext, route);
                                      } catch (e) {
                                        // If an error occurs, log the error to the console.
                                        print(e);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                      color: Colors.blueAccent,
                                    )),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: InkWell(
                                    child: hasTorch
                                        ? IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.flash_off,
                                              color: Colors.blueAccent,
                                            ),
                                          )
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
                                          Lamp.turnOff();
                                        } else {
                                          hasTorch = true;
                                          Lamp.turnOn();
                                        }
                                      });
                                    },
                                  )),
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
                                  builder: (context) => TutorialsPage(
                                        pageCode: 2,
                                      )),
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
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
