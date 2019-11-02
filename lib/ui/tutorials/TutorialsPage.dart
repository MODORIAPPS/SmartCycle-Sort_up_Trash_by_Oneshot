import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/styles/Styles.dart';

BuildContext mContext;

class TutorialsPage extends StatelessWidget {
  static const platform = const MethodChannel('smartcycle.flutter.dev/widget');
  int pageCode;

  TutorialsPage({this.pageCode});

  /*
  *  pageCode 1 -> 전반적인 앱의 사용방법
  *  pageCode 2 -> 카메라 파트의 사용방법
  *
  *
  * */

  @override
  Widget build(BuildContext context) {
    mContext = context;
    switch (pageCode) {
      case 1:
        return AppUsing(context);
      case 2:
        return CameraUsing(context);
    }
  }
}

// 전반적인 앱 설명
Widget AppUsing(BuildContext context) {
  return Scaffold(
    body: PageView(
      children: <Widget>[
        _page1(),
        _page2(),
        _page3(),
        _page4(context),
      ],
      scrollDirection: Axis.vertical,
    ),
  );
}

// 카메라 설명
Widget CameraUsing(BuildContext context) {
  return Scaffold(
    body: PageView(
      children: <Widget>[
        _cPage1(context),
      ],
    ),
  );
}

Widget _cPage1(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "사용자 설명서",
              style: TextAssets.subBold,
            ),
            Icon(
              Icons.center_focus_strong,
              color: Colors.blue,
              size: 50,
            ),
            Text(
              "카메라로 직접 검색하기",
              style: tutoBold,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "갤러리에서도, 카메라로 직접 찍으셔도 좋아요. 불편하게 직접 입력하지 않아도 되죠.",
              style: rclRegular,
            ),
          ],
        ),
        RaisedButton(
          child: Text("위젯 생성"),
          onPressed: () {
            _generateWidgetAtHome();
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              iconSize: 20,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _page1() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.black87,
              onPressed: () => Navigator.of(mContext).pop(true),
            ),
          ],
        ),
        Image.asset(
          "assets/images/SmartCycle_logo_white.png",
          width: 300,
        ),
        Text(
          "Smartcycle 시작하기",
          style: TextAssets.mainBlack,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "설치해주셔서 감사합니다.",
          style: TextAssets.mainRegular,
        )
      ],
    ),
  );
}

Widget _page2() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              "[1] NUGU에서 시작하기",
              style: TextAssets.mainBold,
            )
          ],
        ),
      ],
    ),
  );
}

Widget _page3() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              "[2] 앱에서 시작하기",
              style: TextAssets.mainBold,
            )
          ],
        ),
      ],
    ),
  );
}

Widget _page4(BuildContext context) {
  return Container(
    color: Colors.yellow,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text("다음으로"),
            onPressed: () {
              /// 모든 설명이 끝났으로 메인페이지로 이동
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _generateWidgetAtHome() async {
  try {
    await TutorialsPage.platform.invokeMethod('generateWidget');
  } on PlatformException catch (e) {
    print("ERROR: '${e.message}'.");
  }
}


