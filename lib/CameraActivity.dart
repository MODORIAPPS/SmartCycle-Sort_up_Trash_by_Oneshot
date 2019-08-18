import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartcycle/CameraResultActivity.dart';
import 'package:smartcycle/permission_service.dart';
import 'permission_service.dart';

class CameraActivity extends StatefulWidget {
  @override
  _CameraActivityState createState() => _CameraActivityState();
}

class _CameraActivityState extends State<CameraActivity> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool _isReady = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("사진"),
      ),
      body: new Stack(
        children: <Widget>[
          (!_isReady)
              ? new Container(
                  color: Colors.black,
                  child: Text(""),
                )
              : buildCameraView(controller, context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      // initialize camera controllers.
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  void initState() {
    super.initState();

    var value = PermissionsService().hasPermission(PermissionGroup.camera);
    value.then((value) {
      if (!value) {
        PermissionsService().requestPermission(
            permission: PermissionGroup.camera,
            onPermissionGranted: _setupCameras(),
            onPermissionDenied: () {
              _showDialog(context);
            });

        return;
      }
      _setupCameras();
    });
  }
}

Widget buildCameraView(CameraController controller, BuildContext context) {
  return new Container(
    child: new Row(
      children: [
        new Expanded(
          child: new Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1 / 1.34,
                child: new CameraPreview(controller),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        /// 로직 없이 일단은 그냥 바로 다음으로 넘긴다.
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CameraResult()),
                          );
                        },
                        tooltip: 'Camera',
                        child: Icon(Icons.camera),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.camera_enhance,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("권한필요"),
          content: new Text("이 앱을 정상적으로 실행하기 위해 권한이 필요합니다."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
