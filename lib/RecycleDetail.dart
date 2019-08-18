import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'model/RcleDetail.dart';
import 'styles/CustomStyle.dart';
import 'package:http/http.dart' as http;

// sampleData inserted.
//RclDetail detailData = detailItems;
var detailData;
bool okay = false;

class RecycleDetail extends StatelessWidget {
  final String keyword;
  final int numberCode;

  RecycleDetail({this.keyword, this.numberCode});

  // 키워드 대로 요청

  @override
  Widget build(BuildContext context) {
    //print("받은 키워드  : " + keyword);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "재활용 알아보기",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: DetailPage(number: numberCode,),
    );
  }
}

class DetailPage extends StatelessWidget {
  final number;
  DetailPage({this.number});

  @override
  Widget build(BuildContext context) {
    getData(number);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title(),
            SizedBox(
              height: 30,
            ),
            _element(),
            _step1(),
            SizedBox(
              height: 30,
            ),
            _step2(),
            SizedBox(
              height: 30,
            ),
            _doYouKnow()
          ],
        ),
      ),
    );
  }
}

void _onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: new Dialog(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text("Loading"),
        ],
      ),
    ),
  );
}

Future<bool> getData(int number) async {
  http.Response response = await http.get(
      Uri.encodeFull('http://172.16.0.231:8080/getDetail/&TYPE=1'),
      headers: {"Accept": "application/json"});

  print("받은 쓰레기 이름" + TrashType().getTrashName(number));
  print(response.body);

  detailData = jsonDecode(response.body);
  okay = true;
  print("데이터가 잘 전송되고 있어요." + detailData['step2Content']);
}

Widget _title() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        detailData["mainTitle"],
        style: header1,
      ),
      Text(
        detailData["subTitle"],
        style: normal,
      )
    ],
  );
}

Widget _element() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 28,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            detailData["elementTitle"],
            style: header2,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Image(
        width: double.infinity,
        height: 200,
        fit: BoxFit.contain,
        image: NetworkImage(detailData["elementImage"]),
      )
    ],
  );
}

Widget _step1() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "STEP1",
        style: header2,
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        detailData["step1Content"],
        style: normal,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[
          Icon(Icons.search),
          Text(detailData["step1Content"])
        ],
      )
    ],
  );
}

Widget _step2() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "STEP2",
        style: header2,
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        detailData["step2Content"],
        style: normal,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[Icon(Icons.search), Text(detailData["step2tip"])],
      )
    ],
  );
}

Widget _doYouKnow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "알고계셨나요?",
        style: header2,
      ),
      Text(
        detailData["knowContent"],
        style: normal,
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Icon(
            Icons.timelapse,
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            detailData["knowItems"],
            style: header2,
          )
        ],
      )
    ],
  );
}
