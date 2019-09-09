import 'package:flutter/material.dart';
import 'package:smartcycle/styles/Styles.dart';

class DoYouKnowDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "알고계셨나요?",
          style: appBarRegular,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: <Widget>[
          Text("Building the SwiftUI Sample in Flutter", style: mainBold,),
          SizedBox(height: 20,),
          SingleChildScrollView(
            child: Text(""),
          )
        ],
      ),
    );
  }
}
