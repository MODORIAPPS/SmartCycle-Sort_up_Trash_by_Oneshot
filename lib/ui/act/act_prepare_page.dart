import 'package:flutter/material.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';

class ActPreparePage extends StatelessWidget {
  final String contents;

  ActPreparePage({this.contents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  "🛠 개발중",
                  style: TextAssets.mainBlack,
                ),
                Text(
                  contents,
                  style: TextAssets.mainBlack,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
                minWidth: double.infinity,
                height: 60,
                child: RaisedButton(
                  child: Text(
                    "메인 화면으로",
                    style: TextAssets.mainRegularW,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
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
