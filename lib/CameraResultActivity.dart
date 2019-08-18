import 'package:flutter/material.dart';
import 'package:smartcycle/ModifyRecog.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:smartcycle/styles/CustomStyle.dart';

class CameraResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("인식결과"),
      ),
      body: ResultPage(),
    );
  }
}

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "들고 계신 쓰레기는",
                  style: header1,
                ),
                Text(
                  "페트병같아요",
                  style: header1,
                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 1 / 1.2,
              child: Image.asset("assets/images/sampleimage01.png"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("아니에요"),
                  onPressed: () {
                    // 스피너 탭으로 이동
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ModifyPage()),
                    );
                  },
                  color: Colors.blue,
                  elevation: 5,
                ),
                RaisedButton(
                  child: Text("맞아요"),
                  onPressed: () {
                    // 서버가 개발되지 않았으므로 임시 코드
                    var number = TrashType().getTrashNumber("부탄가스");
                    print(number);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              RecycleDetail(numberCode: number)),
                    );
                  },
                  color: Colors.green,
                  elevation: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
