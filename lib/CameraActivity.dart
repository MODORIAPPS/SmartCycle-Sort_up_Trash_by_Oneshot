import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission/permission.dart';

void main() async {
  var permissionNames = await Permission.requestPermissions([PermissionName.Camera, PermissionName.Camera]);
  Permission.openSettings();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(CameraActivity(
    camera: firstCamera,
  ));
}

class CameraActivity extends StatefulWidget {
  final CameraDescription camera;

  const CameraActivity({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _CameraActivityState createState() => _CameraActivityState();
}

class _CameraActivityState extends State<CameraActivity> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "카메라",
            style: TextStyle(color: Colors.blue),
          ),
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              color: Colors.blue,
              onPressed: () {
                print("!!");
              },
            )
          ],
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);

    _initializeControllerFuture = _controller.initialize();
  }
}
