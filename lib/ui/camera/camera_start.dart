import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as prefix1;
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
  final String userEmail;
  final CameraDescription camera;

  CameraActvity({Key key, @required this.camera, @required this.userEmail})
      : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraActvity> {
  Future<void> _initializeControllerFuture;
  CameraController _controller;
  File _image;

  Future<void> makeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras.first, ResolutionPreset.max);
    _controller.initialize().whenComplete(() {
      setState(() {});
    });

    print("동작");
  }

  getImageFromAlbum(ImageSource source) async {
    var imageFile =
    await ImagePicker.pickImage(source: source, imageQuality: 50);

    if (imageFile != null) {
      goCrop(imageFile);
    }
  }

  goCrop(File source) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: source.path,
        ratioX: 1,
        ratioY: 1,
        toolbarTitle: "사진 편집하기",
        toolbarColor: Colors.white,
        maxWidth: 400,
        maxHeight: 400);

    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;

        Route route = MaterialPageRoute(
            builder: (context) =>
                CameraResult(
                  imageFile: _image,
                  userEmail: widget.userEmail,
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
//_controller.value.aspectRatio,
              return Stack(
                children: <Widget>[
                  _controller.value.isInitialized
                      ?
//                  Transform.scale(
//                      scale: _controller.value.aspectRatio / deviceRatio,
//                      child: Center(
//                        child: AspectRatio(
//                          aspectRatio: _controller.value.aspectRatio,
//                          child: CameraPreview(_controller),
//                        ),
//                      ))
                  ClipRect(
                      child: new OverflowBox(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                          alignment: Alignment.center,
                          child: new FittedBox(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              child: new Container(
                                  width: size.width,
                                  height: size.height,
                                  child: CameraPreview(_controller)))))
//                      Center(
//                          child: AspectRatio(
//                            aspectRatio: _controller.value.aspectRatio,
//                            child: CameraPreview(_controller),
//                          ),
//                        )
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
                      padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
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
                                        goCrop(_image);

//                                        Route route = MaterialPageRoute(
//                                            builder: (context) =>
//                                                CameraResult(
//                                                  imageFile: _image
//                                                ));
//                                        Navigator.push(mContext, route);
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
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: InkWell(
                                  child: hasTorch
                                      ? IconButton(
                                      onPressed: () {
                                        _recognizeNotifyDialog(context);
                                      },
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ))
                                      : IconButton(
                                      onPressed: () {
                                        _recognizeNotifyDialog(context);
                                      },
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.amber,
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

Future<File> compressAndGetFile(File file) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    file.absolute.path,
    quality: 88,
    rotate: 180,
  );

  print(file.lengthSync());
  print(result.lengthSync());

  return result;
}

Future<bool> _recognizeNotifyDialog(BuildContext mContext) async {
  return showDialog<bool>(
    context: mContext,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '인식가능한 품목',
          style: TextAssets.mainBold,
        ),
        content: const Text(
          '저희 서비스는 베타 서비스입니다. 그렇기 때문에 인식가능한 품목이 제한되어있습니다. 확인하기 를 눌러 자세한 정보를 확인하세요.',
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              '닫기',
              style: TextAssets.dialogText,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text(
              '확인하기',
              style: TextAssets.dialogText,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        TutorialsPage(
                          pageCode: 2,
                        )),
              );
            },
          )
        ],
      );
    },
  );
}
