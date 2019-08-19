import 'package:flutter/material.dart';
import 'package:smartcycle/main.dart';

class IntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          _page1(),
          _page2(),
          _page3(context),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

Widget _page1() {
  return Container(
    color: Colors.red,
  );
}

Widget _page2() {
  return Container(
    color: Colors.orange,
  );
}

Widget _page3(BuildContext context) {
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
