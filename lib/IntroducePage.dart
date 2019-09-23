import 'package:flutter/material.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/styles/Styles.dart';

class IntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

Widget _page1() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/images/SmartCycle_logo_white.png", width: 300,),
        Text("SmartCycle 시작하기", style: mainBold,),
        SizedBox(height: 20,),
        Text("설치해주셔서 감사합니다.", style: appBarRegular,)

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
            Text("[1] NUGU에서 시작하기", style: mainBold,)
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
            Text("[2] 앱에서 시작하기", style: mainBold,)
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
