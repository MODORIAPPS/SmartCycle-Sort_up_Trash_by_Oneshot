import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/ui/policy/policy_main.dart';

TextEditingController controller = new TextEditingController();

class CameraFeedBack extends StatelessWidget {
  final File imageFile;
  final String user_email;

  CameraFeedBack({@required this.user_email, @required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        title: Text(
          "사용자 피드백",
          style: TextAssets.mainRegular,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "'기타'를 선택하셨습니다.🔊",
                        style: TextAssets.mainBlack,
                      ),
                      Text(
                        "서비스 개선을 위해 도와주세요.",
                        style: TextAssets.mainBold,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "✨촬영하신 쓰레기가 어떤 쓰레기인지 직접 알려주세요.",
                  style: TextAssets.subBold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: "쓰레기 정보 직접 입력",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      )),
                  keyboardType: TextInputType.text,
                  style: TextAssets.mainRegular,
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "저희 서비스는 완성되지 않았습니다. \n소중한 피드백으로 더욱 발전된 서비스를 제공하겠습니다.",
                      style: TextAssets.infoBold,
                    ),
                  ),
                  ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        child: Text(
                          "제출 및 메인화면으로",
                          style: TextAssets.mainRegularW,
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            _showSubmitDialog(
                                context, controller.text, imageFile,
                                user_email);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  SmartDialog(
                                    title: "공백감지",
                                    content: "이 입력은 공란일 수 없습니다.",
                                    colors: Colors.red,
                                  ),
                            );
                          }
                        },
                        color: Colors.blue,
                        elevation: 5,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

_showSubmitDialog(BuildContext mContext, String _value, File imageFile,
    String user_email) {
  showDialog(
      context: mContext,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text(
                "인공지능 개선",
                style: TextAssets.mainBold,
              ),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PolicyMain(),
                    ),
                  );
                },
              ),
            ],
          ),
          content: Text(
            "더 나은 서비스 제공을 위해 이미지를 학습용으로 보내주시겠어요?",
            style: TextAssets.mainRegular,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  SmartCycleServer().saveHistory(
                      imageFile,
                      user_email,
                      false,
                      controller.text.toString(),
                      false);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text(
                  "아니오",
                  style: TextAssets.dialogText,
                )),
            FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      SmartDialog(
                        title: "피드백",
                        content: "대단히 감사합니다. 빠른 시일 내에 추가하겠습니다.",
                        colors: Colors.green,
                      ),
                );
                SmartCycleServer().saveHistory(
                    imageFile,
                    user_email,
                    false,
                    controller.text.toString(),
                    false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text(
                "네",
                style: TextAssets.dialogText,
              ),
            )
          ],
        );
      });
}

