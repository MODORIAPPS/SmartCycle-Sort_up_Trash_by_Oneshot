import 'package:flutter/material.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/styles/Styles.dart';

class TutorialsPage extends StatelessWidget {
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
    switch (pageCode) {
      case 1:
        return AppUsing(context);
      case 2:
        return CameraUsing();
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
Widget CameraUsing() {
  return Scaffold(
    body: PageView(
      children: <Widget>[
        _cPage1(),
      ],
    ),
  );
}

Widget _cPage1() {
  return Padding(
    padding: EdgeInsets.only(left: 15, right: 15, top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.blur_circular, color: Colors.blue, size: 40,),
        Text("카메라로 직접 검색하기", style: tutoBold,),
        SizedBox(
          height: 5,
        ),
        Text("갤러리에서도, 카메라로 직접 찍으셔도 좋아요.", style: rclRegular,)
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
        Image.asset(
          "assets/images/SmartCycle_logo_white.png",
          width: 300,
        ),
        Text(
          "SmartCycle 시작하기",
          style: mainBold,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "설치해주셔서 감사합니다.",
          style: appBarRegular,
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
              style: mainBold,
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
              style: mainBold,
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
