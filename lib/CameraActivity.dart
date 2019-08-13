import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      body: new Stack(
        children: <Widget>[
          (!_isReady)
              ? new Container(
                  child: Text("Dd"),
                )
              : buildCameraView(controller),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // controller dispose;
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
    _setupCameras();
  }
}

Widget buildCameraView(CameraController controller) {
  return new Container(
    child: new Row(
      children: [
        new Expanded(
          child: new Column(
            children: <Widget>[
              new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
