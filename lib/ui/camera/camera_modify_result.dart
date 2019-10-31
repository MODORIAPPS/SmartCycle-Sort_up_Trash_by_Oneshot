import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/RcleDetail.dart';
import 'package:smartcycle/ui/act/act_prepare_page.dart';
import 'package:smartcycle/ui/camera/camera_get_feedback.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';

class ModifyPage extends StatefulWidget {
  final File initImage;

  ModifyPage({Key key, @required this.initImage}) : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "🤔앗 아닌가요?",
                        style: TextAssets.mainBlack,
                      ),
                      Text(
                        "직접 알려주세요.",
                        style: TextAssets.mainBlack,
                      ),
                      AspectRatio(
                        aspectRatio: 1 / 1.2,
                        child: Image.file(widget.initImage),
                      ),
                      Text(
                        "쓰레기 종류를 직접 입력합니다.",
                        style: TextAssets.subBold,
                      ),
                      Text(
                        "찾고자 하는 쓰레기가 없을 경우에는 '기타'를 선택해주세요.",
                        style: TextAssets.subBold,
                      ),
                      DropdownButton<String>(
                        value: _value,
                        items: TrashType().trashes.map((String value) {
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

//         Align(
//            alignment: Alignment.center,
//            child:
//          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
                minWidth: double.infinity,
                height: 65,
                child: RaisedButton(
                  child: Text(
                    "제출",
                    style: TextAssets.mainRegularW,
                  ),
                  onPressed: () {
                    if (_value.isNotEmpty) {
                      if (_value == "기타") {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => CameraFeedBack()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SmartDialog(
                                title: "피드백 접수됨",
                                content: "도와주셔서 감사합니다. 더 나은 서비스를 만드는데 큰 도움이 될 것입니다.",
                                colors: Colors.green,
                              ),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                RecycleDetail(
                                  itemID: TrashType().getTrashNumber(_value),
                                ),
                          ),
                        );
                      }
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
    );
  }
}
