import 'package:flutter/material.dart';
import 'package:smartcycle/CameraActivity.dart';
import 'package:smartcycle/HistoryCard.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/SearchHistory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var history = new List<SearchHistory>();

  // Future로 서버에 데이터 요청후, 콜백에 리스트뷰 생성.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/images/icecream.png"),
                    RaisedButton(
                      child: Text("임시 버튼"),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              RecycleDetail(
                                keyword: "페트병",
                              )),
                        );
                      },
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "오늘의 분리수거\n알아보기",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("날마다 헷갈리는 재활용품의 \n분리수거 방법을 알려드립니다."),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "오늘의 분리수거",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(":  '설레임'",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.blue,
            height: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "최근 검색한 재활용품",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                var product = searchItems[index];
                return HistoryCard(
                  id: product.id,
                  itemName: product.itemName,
                  date: product.date,
                  itemImage: product.itemImage,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CameraActivity()),
          );
        },
        tooltip: 'openSearch',
        child: Icon(Icons.photo_camera),


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void _showSearchSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Music'),
                  onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},
              ),
            ],
          ),
        );
      });
}
