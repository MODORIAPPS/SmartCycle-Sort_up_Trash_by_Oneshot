import 'package:flutter/material.dart';
import 'package:smartcycle/IntroducePage.dart';
import 'package:smartcycle/styles/CustomStyle.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SmartCycle과 함께 깨끗한 \n지구 만들기.",
                  style: header1,
                ),
              ],
            ),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/googleLogo.png",
                      width: 50,
                      height: 50,
                    ),
                    Text("구글 계정으로 시작하기")
                  ],
                ),
              ),
              onPressed: () {
                /// Launch Google Auth API
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => IntroducePage()),
                );
              },
            ),
            Text("이용약관")
          ],
        ),
      ),
    );
  }
}
