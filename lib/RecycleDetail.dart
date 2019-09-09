import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcycle/model/TrashItemDTO.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'model/RcleDetail.dart';
import 'styles/CustomStyle.dart';
import 'package:http/http.dart' as http;

// sampleData inserted.
//RclDetail detailData = detailItems;
TrashItemDTO detailData;
bool okay = false;

class RecycleDetail extends StatefulWidget {


  final String keyword;
  final int itemID;

  RecycleDetail({this.keyword, this.itemID});

  @override
  _RecycleDetailState createState() => _RecycleDetailState(itemId: itemID);
}

class _RecycleDetailState extends State<RecycleDetail> {
  int itemId;
  _RecycleDetailState({this.itemId});

  @override
  Widget build(BuildContext context) {
    print("받은 키워드  : " + itemId.toString());

    if (okay == false) {
      getData(itemId).then((value) {
        if (value != null) {
          okay = true;
          print(value.toString());
          setState(() {});
        }
      });
    }

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
        body: okay ? DetailPage() : _showProgress());
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
            // SizedBox(
            //   height: 30,
            // ),
            // _element(),
            // _step1(),
            // SizedBox(
            //   height: 30,
            // ),
            // _step2(),
            // SizedBox(
            //   height: 30,
            // ),
            // _doYouKnow()
          ],
        ),
      ),
    );
  }
}

Future<Object> getData(int itemId) async {
  print("요청 진입");
  http.Response response = await http.get(
      Uri.encodeFull('http://smartcycle.ljhnas.com:3000/api/trash/$itemId'),
      headers: {"Accept": "application/json"});

  print("받은 쓰레기 이름" + TrashType().getTrashName(itemId));
  print(response.body);
  List<TrashItem> data = json.decode(response.body);  
  print(data[0].name);


  return response.body;
  //print("데이터가 잘 전송되고 있어요." + detailData['step2Content']);
}

Widget _title() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        
      "Ddd",
        style: header1,
      ),
      Text(
        "이게 뭐야",
        style: normal,
      )
    ],
  );
}

Widget _showProgress() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

// Widget _element() {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Icon(
//             Icons.search,
//             size: 28,
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Text(
//             detailData["elementTitle"],
//             style: header2,
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Image(
//         width: double.infinity,
//         height: 200,
//         fit: BoxFit.contain,
//         image: NetworkImage(detailData["elementImage"]),
//       )
//     ],
//   );
// }

// Widget _step1() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         "STEP1",
//         style: header2,
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Text(
//         detailData["step1Content"],
//         style: normal,
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Row(
//         children: <Widget>[
//           Icon(Icons.search),
//           Text(detailData["step1Content"])
//         ],
//       )
//     ],
//   );
// }

// Widget _step2() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         "STEP2",
//         style: header2,
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Text(
//         detailData["step2Content"],
//         style: normal,
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Row(
//         children: <Widget>[Icon(Icons.search), Text(detailData["step2tip"])],
//       )
//     ],
//   );
// }

// Widget _doYouKnow() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         "알고계셨나요?",
//         style: header2,
//       ),
//       Text(
//         detailData["knowContent"],
//         style: normal,
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Row(
//         children: <Widget>[
//           Icon(
//             Icons.timelapse,
//             size: 30,
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Text(
//             detailData["knowItems"],
//             style: header2,
//           )
//         ],
//       )
//     ],
//   );
// }
