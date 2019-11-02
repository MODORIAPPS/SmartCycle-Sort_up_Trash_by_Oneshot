import 'package:flutter/material.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';

class ErrorPage extends StatelessWidget {
  final error_msg;

  ErrorPage({this.error_msg});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "😥죄송합니다.",
                style: TextAssets.mainBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "문제가 발생했습니다.",
                style: TextAssets.mainBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "오류 원인은 아래와 같습니다.",
                style: TextAssets.mainRegular,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                error_msg,
                style: TextAssets.errorBold,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "이 메시지를 스크린 샷하여 아래 이메일로\n보내주시면 도와드리겠습니다.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text("확인"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text("kwonkiseok7@gmail.com"),
          ),
        ),
      ],
    );
  }
}
