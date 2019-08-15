import 'package:flutter/material.dart';

import 'model/RcleDetail.dart';
import 'styles/CustomStyle.dart';

// sampleData inserted.
RclDetail detailData = detailItems;

class RecycleDetail extends StatelessWidget {
  final String keyword;

  RecycleDetail({this.keyword});

  // 키워드 대로 요청

  @override
  Widget build(BuildContext context) {
    print("받은 키워드  : " + keyword);
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
      body: DetailPage(),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

Widget _title() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        detailData.mainTitle,
        style: header1,
      ),
      Text(
        detailData.subTitle,
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
            detailData.elementTitle,
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
        image: NetworkImage(detailData.elementImage),
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
        detailData.step1Content,
        style: normal,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[Icon(Icons.search), Text(detailData.step1Content)],
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
        detailData.step2Content,
        style: normal,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[Icon(Icons.search), Text(detailData.step2tip)],
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
        detailData.knowContent,
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
            detailData.knowItems[0],
            style: header2,
          )
        ],
      )
    ],
  );
}
