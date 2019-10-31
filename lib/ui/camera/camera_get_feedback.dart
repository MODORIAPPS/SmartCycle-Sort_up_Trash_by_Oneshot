import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';

TextEditingController controller = new TextEditingController();

class CameraFeedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "✨촬영하신 쓰레기가 어떤 쓰레기인지 직접 알려주세요.",
                style: TextAssets.subBold,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                      style: TextAssets.subBold,
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => SmartDialog(
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
