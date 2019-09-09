import 'package:flutter/material.dart';
import 'package:smartcycle/DoYouKnowDetail.dart';
import 'package:smartcycle/StartPage.dart';
import 'package:smartcycle/UserPage.dart';
import 'package:smartcycle/styles/CustomStyle.dart';
import 'package:smartcycle/CameraActivity.dart';
import 'package:smartcycle/HistoryCard.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartcycle/styles/Styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(14.0),
        child: FloatingActionButton(
          child: const Icon(Icons.filter_tilt_shift),
          onPressed: () {},
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 5.0,
      //   child: new Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.settings),
      //         onPressed: () {
      //           // open Settings.dart
      //           Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => UserPage()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.search),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Container(
                    //     width: 42,
                    //     height: 42,
                    //     decoration: new BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         image: new DecorationImage(
                    //             fit: BoxFit.fill,
                    //             image: new AssetImage(
                    //                 "assets/images/globe_earth.png")))),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "SmartCycle",
                        style: appBarRegular,
                      ),
                    )
                  ],
                ),
                InkWell(
                  child: Container(
                      width: 42,
                      height: 42,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 8),
                                blurRadius: 10)
                          ],
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "http://www.jobnjoy.com/files/editor/1489453572220_1.jpg")))),
                  onTap: () {
                    // Toast message
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StartPage()),
                    );
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "알고계셨나요?",
                  style: mainBold,
                ),
              ],
            ),
          ),
          CarouselSlider(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            initialPage: 0,
            onPageChanged: (index) {
              setState(() {});
            },
            items: <Widget>[_page1(context), _page2(), _page3()],
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "최근 검색한 분리수거",
              style: mainBold,
            ),
          ),
          _historyGridView(),
        ],
      ),
    );
  }
}

// Widget _pageView(){
//   return PageView(

//     children: <Widget>[
//         Container(color: Colors.blue,child: Text("Dd"),),
//         Container(color: Colors.blue,child: Text("Dd"),),
//         Container(color: Colors.blue,child: Text("Dd"),),

//     ],
//   );
// }

Widget _row(BuildContext context) {
  return Row(
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
                  MaterialPageRoute(
                      builder: (context) => RecycleDetail(
                            keyword: "페트병",
                          )),
                );
              },
            ),
            RaisedButton(
              child: Text("임시 버튼"),
              onPressed: () {
                // Google auth 로그인 상태 아닌 경우 로그인 창으로 이동(사실상 최초 실행시 소개 페이지와 같음)
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
            ),
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(":  '설레임'",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          )),
    ],
  );
}

Widget _historyGridView() {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 2,
      children: List.generate(searchItems.length, (index) {
        var history = searchItems[index];
        return Center(
          child: HistoryCard(
              itemName: history.itemName,
              itemImage: history.itemImage,
              date: history.date,
              itemIndex: index),
        );
      }),
    ),
  );
}

// Widget _ListView() {
//   return Expanded(
//     child: ListView.builder(
//       itemCount: searchItems.length,
//       itemBuilder: (context, index) {
//         var product = searchItems[index];
//         return HistoryListCard(
//           id: product.id,
//           itemName: product.itemName,
//           date: product.date,
//           itemImage: product.itemImage,
//         );
//       },
//     ),
//   );
// }

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

Widget _page1(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      child: Container(
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(-.2, 0),
                        image: NetworkImage(
                            'https://m.hardmarket.co.kr/web/product/big/201905/f51a200d5c7e3791cd3bffd76910b025.jpg'),
                        fit: BoxFit.cover),
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                border: new Border.all(width: 20, color: Colors.transparent),
                color: new Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "이런 형태의 쓰레기는 어떻게 분리수거해야할까?",
                        style: mainRegular,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2020년 4월 3일",
                        style: mainLight,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
            ]),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DoYouKnowDetail()),
        );
      },
    ),
  );
}

Widget _page2() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment(-.2, 0),
                      image: NetworkImage(
                          'https://media.nature.com/w800/magazine-assets/d41586-019-02584-7/d41586-019-02584-7_17110722.jpg'),
                      fit: BoxFit.cover),
                ),
              )),
          Container(
            decoration: BoxDecoration(
              border: new Border.all(width: 20, color: Colors.transparent),
              color: new Color.fromRGBO(0, 0, 0, 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "A better future for graduate-student mental health",
                      style: mainRegular,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "04 September 2019",
                      style: mainLight,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
          ]),
    ),
  );
}

Widget _page3() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment(-.2, 0),
                      image: NetworkImage(
                          'https://media.nature.com/w800/magazine-assets/d41586-019-02638-w/d41586-019-02638-w_17141688.jpg'),
                      fit: BoxFit.cover),
                ),
              )),
          Container(
            decoration: BoxDecoration(
              border: new Border.all(width: 20, color: Colors.transparent),
              color: new Color.fromRGBO(0, 0, 0, 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "First hint that body’s ‘biological age’ can be reversed",
                      style: mainRegular,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "04 September 2019",
                      style: mainLight,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
          ]),
    ),
  );
}
