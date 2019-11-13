import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/ui/act/act_error_page.dart';
import 'package:smartcycle/ui/camera/camera_modify_result.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/assets.dart';

class CameraResult extends StatefulWidget {
  final File imageFile;
  final String userEmail;

  CameraResult({@required this.imageFile, @required this.userEmail});

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
    _cameraResult =
        SmartCycleServer().getCameraResult(widget.imageFile, widget.userEmail);
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: Text(
            "인식결과",
            style: TextAssets.mainRegular,
          ),
          elevation: 1,
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
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "들고 계신 쓰레기는",
                                style: TextAssets.mainBlack,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
//                                      Container(
//                                        child: Align(
//                                          alignment: Alignment.bottomCenter,
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                              border: new Border.all(
//                                                  width: 5, color: Colors.transparent),
//                                              color: Colors.blue,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
                                      Align(
                                        child: Container(
                                          color: Colors.amberAccent,
                                          child: Text(
                                            "${TrashType().getTrashName(
                                                trashNumber)}",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                        ),
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    " 같아요!",
                                    style: TextAssets.mainBlack,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5, right: 5, bottom: 20),
                                child: Container(
                                  child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Hero(
                                        tag: "camera_hero",
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(34),
                                          child: Image.file(
                                            widget.imageFile,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      )),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(34),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, 15),
                                            blurRadius: 15)
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: ButtonTheme(
                                minWidth: double.infinity,
                                height: 65,
                                child: RaisedButton(
                                  child: Text(
                                    "아니에요",
                                    style: TextAssets.mainRegularW,
                                  ),
                                  onPressed: () {
                                    // 스피너 탭으로 이동
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ModifyPage(
                                                user_email: widget.userEmail,
                                                initImage: widget.imageFile,
                                                oldTrashType: TrashType()
                                                    .getTrashName(trashNumber),
                                              )),
                                    );
                                  },
                                  color: Colors.redAccent,
                                  elevation: 5,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 65,
                                  child: RaisedButton(
                                    child: Text(
                                      "맞아요",
                                      style: TextAssets.mainRegularW,
                                    ),
                                    onPressed: () {
                                      // 서버가 개발되지 않았으므로 임시 코드
                                      //var number = TrashType().getTrashNumber("부탄가스");
                                      //print(number);
                                      SmartCycleServer().saveHistory(
                                          widget.imageFile,
                                          widget.userEmail,
                                          true,
                                          trashNumber.toString(),
                                          true);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecycleDetail(
                                                    itemID: trashNumber,
                                                    mode: true)),
                                      );
                                    },
                                    color: Colors.blue,
                                    elevation: 5,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
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
          borderRadius: BorderRadius.circular(34),
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
        title: Text('작업 취소', style: TextAssets.mainRegular,),
        content: const Text('현재 진행중인 작업을 취소하시겠어요?', style: TextAssets.subBold,),
        actions: <Widget>[
          FlatButton(
            child: const Text('아니오', style: TextAssets.dialogText,),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('확인', style: TextAssets.dialogText,),
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
