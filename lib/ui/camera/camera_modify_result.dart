import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/RcleDetail.dart';
import 'package:smartcycle/ui/act/act_prepare_page.dart';
import 'package:smartcycle/ui/camera/camera_get_feedback.dart';
import 'package:smartcycle/ui/policy/policy_main.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';

class ModifyPage extends StatefulWidget {
  final String user_email;
  final String oldTrashType;
  final File initImage;

  ModifyPage({Key key,
    @required this.initImage,
    @required this.oldTrashType,
    @required this.user_email})
      : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  String _value;

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery
        .of(context)
        .size;
    final double _height = logicalSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "직접 피드백",
          style: TextAssets.mainRegular,
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "🤔앗 아닌가요?",
                    style: TextAssets.mainBlack,
                  ),
                  Text(
                    "직접 알려주세요.",
                    style: TextAssets.mainBlack,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Container(
                      child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Hero(
                            tag: "camera_hero",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                widget.initImage,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 15),
                                blurRadius: 15)
                          ]),
                    ),
                  ),
                  Text(
                    "쓰레기 종류를 직접 입력합니다.",
                    style: TextAssets.subBold,
                  ),
                  Text(
                    "찾고자 하는 쓰레기가 없을 경우에는 '기타'를 선택해주세요.",
                    style: TextAssets.subBold,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: DropdownButton<String>(
                      value: _value,
                      items: TrashType.trashes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _value = newValue;
                        });
                      },
                      hint: Text(
                        "어떤 쓰레기인지 알려주세요!",
                        style: TextAssets.mainRegular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: (_height - 800.0) < 0 ? 0 : _height - 800),
              child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 65,
                  child: RaisedButton(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "제출",
                          style: TextAssets.mainRegularW,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (_value != null) {
                        if (_value == "기타") {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    CameraFeedBack(
                                      user_email: widget.user_email,
                                      imageFile: widget.initImage,
                                    )),
                          );
                        } else if (_value == widget.oldTrashType) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                SmartDialog(
                                  title: "잘못된 피드백",
                                  content: "추측한 값과 수정값이 같을 수 없습니다.",
                                  colors: Colors.orange,
                                ),
                          );
                        } else {
                          _showSubmitDialog(context, _value);
                          SmartCycleServer().saveHistory(
                              widget.initImage,
                              widget.user_email,
                              true,
                              TrashType().getTrashNumber(_value).toString(),
                              false);
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SmartDialog(
                                title: "공란 감지",
                                content: "피드백 란은 공란일 수 없습니다. 하나를 선택해주세요.",
                                colors: Colors.red,
                              ),
                        );
                      }
//                    Navigator.of(context).pushReplacement(
//                      MaterialPageRoute(
//                          builder: (context) => ActPreparePage(
//                                contents: "아직은 제공하지 않는 기능입니다.",
//                              )),
//                    );
                    },
                    color: Colors.blue,
                    elevation: 5,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

_showSubmitDialog(BuildContext mContext, String _value) {
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          RecycleDetail(
                            itemID: TrashType().getTrashNumber(_value),
                            mode: true,
                          ),
                    ),
                  );
                },
                child: Text(
                  "아니오",
                  style: TextAssets.dialogText,
                )),
            FlatButton(
              onPressed: () {
                SmartDialog(
                  title: "피드백 접수됨",
                  content: "도와주셔서 감사합니다. 더 나은 서비스를 만드는데 큰 도움이 될 것입니다.",
                  colors: Colors.green,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        RecycleDetail(
                          itemID: TrashType().getTrashNumber(_value),
                          mode: true,
                        ),
                  ),
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
