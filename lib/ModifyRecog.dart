import 'package:flutter/material.dart';
import 'package:smartcycle/styles/CustomStyle.dart';

class ModifyRecog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("결과 수정"),
      ),
      body: ModifyPage(),
    );
  }
}

class ModifyPage extends StatefulWidget {
  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "앗 아닌가요?",
              style: header1,
            ),
            Text(
              "직접 알려주세요",
              style: header1,
            ),
          ],
        ),
        AspectRatio(
          aspectRatio: 1 / 1.2,
          child: Image.asset("assets/images/sampleimage01.png"),
        ),
        RaisedButton(
          onPressed: (){
            // 제출, 제출해주셔서 감사합니다! 

      
          },
          child: Text("확인"),
        )
      ],
    );
  }
}
