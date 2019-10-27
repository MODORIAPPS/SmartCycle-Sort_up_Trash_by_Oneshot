import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/ui/act/act_error_page.dart';
import 'package:smartcycle/ui/camera/camera_modify_result.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/assets.dart';

class CameraResult extends StatefulWidget {
  final File imageFile;

  CameraResult({this.imageFile});

  @override
  _CameraResultState createState() => _CameraResultState();
}

class _CameraResultState extends State<CameraResult> {
  bool okay = false;
  Future<String> _cameraResult;

  @override
  void initState() {
    super.initState();
//    _cameraResult = SmartCycleServer().getCameraResult()
//        .timeout(const Duration(seconds: 10));
//
    _cameraResult = SmartCycleServer().getCameraResult(widget.imageFile);
  }

  @override
  void dispose() {
    super.dispose();
    okay = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("인식결과"),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (okay) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                } else {
                  _asyncConfirmDialog(context);
                }
              }),
        ),
        body: FutureBuilder<String>(
          future: _cameraResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return ErrorPage(
                  error_msg: snapshot.error.toString(),
                );
              } else {
                print(snapshot.data.toString());
                okay = true;
                final int trashNumber = int.parse(snapshot.data);
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "들고 계신 쓰레기는",
                              style: header1,
                            ),
                            Text(
                              "${TrashType().getTrashName(trashNumber)} 같아요",
                              style: header1,
                            ),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 1 / 1.2,
                          child: Image.file(
                            widget.imageFile,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              child: Text("아니에요"),
                              onPressed: () {
                                // 스피너 탭으로 이동
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ModifyPage()),
                                );
                              },
                              color: Colors.blue,
                              elevation: 5,
                            ),
                            RaisedButton(
                              child: Text("맞아요"),
                              onPressed: () {
                                // 서버가 개발되지 않았으므로 임시 코드
                                //var number = TrashType().getTrashNumber("부탄가스");
                                //print(number);

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RecycleDetail(itemID: trashNumber)),
                                );
                              },
                              color: Colors.green,
                              elevation: 5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            } else {
              return _waiting();
            }
          },
        ));
  }
}

Widget _waiting() {
  return Align(
    alignment: Alignment.center,
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.phonelink_ring,
              size: 30,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "서버로부터 결과를 \n받아오고 있습니다.",
              style: TextAssets.mainBold,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
          ]),
    ),
  );
}

Future<bool> _asyncConfirmDialog(BuildContext mContext) async {
  return showDialog<bool>(
    context: mContext,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('작업 취소'),
        content: const Text('현재 진행중인 작업을 취소하시겠어요?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('아니오'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          )
        ],
      );
    },
  );
}
