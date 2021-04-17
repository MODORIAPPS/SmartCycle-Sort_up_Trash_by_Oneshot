import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/ui/auth/auth_main.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/ui/nugudevice/nugu_regi_completed.dart';

TextEditingController deviceIdController = new TextEditingController();

class AddDevice extends StatelessWidget {
  final UserInfo userInfo;

  AddDevice({@required this.userInfo});

  final snackBar = SnackBar(
    content: Text('입력 값에 문제가 있습니다.'),
    duration: const Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "내 기기 추가하기",
            style: TextAssets.mainRegular,
          ),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 10),
                    child: Icon(
                      Icons.accessibility,
                      color: Colors.black87,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 7, bottom: 7),
                    child: Text(
                      "더 편하게 분리수거를 즐기실 \n준비가 되셨나요?",
                      style: blueHigh,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 13,
                    ),
                    child: Text(
                      "물론 SmartCycle앱을 통해서도 분리수거 방법을 검색할 수 있지만 앞으로 SmartCycle 기기와 연동하면 물건을 보여주기만 하면 된답니다.",
                      style: normalText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, top: 7, bottom: 7),
                    child: Text(
                      "연동은 어떻게 하나요?",
                      style: TextAssets.mainRegular,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 13,
                    ),
                    child: Text(
                      '모든 SmartCycler 기기에는 각 디바이스ID를 표시하는 스티커가 붙여져있습니다.',
                      style: normalText,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 13,
                    ),
                    child: Text(
                      '그 디바이스ID를 아래에 아래에 입력하시고 지금 추가 또는 연동 버튼을 눌러주시면 됩니다.',
                      style: smallHigh,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: new TextFormField(
                      controller: deviceIdController,
                      decoration: new InputDecoration(
                        labelText: "디바이스 id 입력",
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.important_devices),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "공백은 허용되지 않습니다.";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                          fontFamily: "NotoCjkKR",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 60,
                child: RaisedButton(
                  child: Text(
                    "지금 추가 또는 연동",
                    style: authRegular,
                  ),

                  color: Colors.blue,
                  //splashColor: Colors.yellow,
                  onPressed: () {
                    // POST
                    String berry_id = deviceIdController.text;
                    String user_email = userInfo.email;

                    // %% ONLY FOR TEST %% getUserHistoryTest
                    SmartCycleServer()
                        .registerDeviceTest(user_email, berry_id)
                        .then((result) {
                      print(result);
                      if (result == '{"result":1}') {
                        Scaffold.of(context)
                            .showSnackBar(new SnackBar(content: Text("성공")));

                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RegiCompleted()),
                        );
                      } else if (result == '{"result":2}') {
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: Text("이미 등록된 기기입니다.")));
                      } else if (result == '{"result":false}') {
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: Text("등록 중 오류가 발생했습니다.")));
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
