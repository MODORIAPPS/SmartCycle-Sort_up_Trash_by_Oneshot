import 'package:flutter/material.dart';
import 'package:smartcycle/AuthPage.dart';
import 'package:smartcycle/styles/Styles.dart';

class RegiCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "성공! 🎉",
                  style: blueHigh,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "기기 등록이 완료되었습니다.",
                  style: completeHigh,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "이제부터 NUGU에게 분리수거를 물어보세요!\n아리아, 이거 어떻게 버려?",
                  style: normalText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.black87,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
