import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcycle/DoYouKnowDetail.dart';
import 'package:smartcycle/SmartDialog.dart';
import 'package:smartcycle/TutorialsPage.dart';
import 'package:smartcycle/QrDialog.dart';
import 'package:smartcycle/AuthPage.dart';
import 'package:smartcycle/UserPage.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/styles/CustomStyle.dart';
import 'package:smartcycle/CameraActivity.dart';
import 'package:smartcycle/HistoryCard.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:http/http.dart' as http;
import 'package:smartcycle/ui/main/main_gridview.dart';

import 'model/RcleDetail.dart';

void main() => runApp(MyApp());

bool doYouKnowGo = false;
bool isUserAvail = false;
bool isHistoryReady = false;

SearchHistorys historys;
var userProfileURL;
var user_email;

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var history = new List<SearchHistory>();

  // FabBtn Controll
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    networkCheck();

    // FabBtn Controll
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));

    isUserAvail = false;

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    isUserAvail = false;
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget image() {
    return Container(
      child: new FloatingActionButton(
        heroTag: "imageFab",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CameraActvity()),
          );
        },
        tooltip: 'camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget qrCode() {
    return Container(
      child: new FloatingActionButton(
          heroTag: "qrFab",
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  QrDialog(
                    title: "QR코드",
                    description: "이 QR코드를 기기의 카메라 앞에 대세요.",
                    posiBtn: "알겠습니다.",
                    url: user_email,
                  ),
            );
          },
          tooltip: 'qrCode',
          child: Image.asset(
            "assets/images/qrCode.png",
            color: Colors.white,
            width: 30,
          )),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'open menu',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //networkCheck();

    if (userProfileURL == null) {
      AuthUtils().getAccessToken().then((access_token) {
        if (access_token.length <= 4) {
          isUserAvail = false;
        } else {
          isUserAvail = true;
          AuthUtils().getGoogleProfile(access_token).then((profile) {
            var json = jsonDecode(profile);
            //userProfileURL = json['profile'];
            print(userProfileURL);

            user_email = json['email'];

            print(userProfileURL);
            userProfileURL = json['picture'];

            AuthUtils().getUserHistory(user_email).then((history) {
              historys = history;
              isHistoryReady = true;
            });
          });
        }
      });
    }

    if (isUserAvail == true) {
      AuthUtils().getUserHistory(user_email).then((history) {
        historys = history;
        isHistoryReady = true;
      });
    }

    print(isUserAvail);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(14.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value * 2.0,
                  0.0,
                ),
                child: image(),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value,
                  0.0,
                ),
                child: qrCode(),
              ),
              toggle(),
            ],
          )),
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
            items: <Widget>[_page1(context), _page2(context), _page3(context)],
          ),
//          doYouKnowGo
//              ? CarouselSlider(
//                  height: 200.0,
//                  enlargeCenterPage: true,
//                  autoPlay: true,
//                  initialPage: 0,
//                  onPageChanged: (index) {
//                    setState(() {});
//                  },
//                  items: <Widget>[
//                    _page1(context, data[0]),
//                    _page2(context, data[1]),
//                    _page3(context, data[2])
//                  ],
//                )
//              : Container(),
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

          // TEST DATA
          HistoryGridView(isUserAvail: true, userEmail: "Dd",),
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
                  MaterialPageRoute(builder: (context) => AuthPage()),
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

//Widget _historyGridView(BuildContext context) {
//  return isHistoryReady
//      ? (historys.historys.length == 0)
//          ? Center(
//              child: Column(
//                children: <Widget>[
//                  SizedBox(
//                    height: 50,
//                  ),
//                  Icon(Icons.info_outline),
//                  SizedBox(
//                    height: 8,
//                  ),
//                  Text(
//                    "검색한 정보가 없어요.",
//                    style: cardRegular,
//                  ),
//                ],
//              ),
//            )
//          : Expanded(
//              child: MediaQuery.removePadding(
//              context: context,
//              removeTop: true,
//              child: GridView.count(
//                crossAxisCount: 2,
//                children: List.generate(historys.historys.length, (index) {
//                  var history = historys.historys[index];
//                  return Center(
//                    child: HistoryCard(
//                        id: int.parse(history.trash_id),
//                        itemName: TrashType()
//                            .getTrashName(int.parse(history.trash_id)),
//                        itemImage: TrashType()
//                            .getTrashImage(int.parse(history.trash_id)),
//                        date: history.date,
//                        itemIndex: index),
//                  );
//                }),
//              ),
//            ))
//      : Center(
//          child: Text("개인화된 기능을 사용하려면 로그인 하세요"),
//        );
//}

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
                        "우리가 분리수거를 해야하는 확실한 이유",
                        style: mainRegular,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2020년 1월 1일",
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
//        Navigator.of(context).push(
//          MaterialPageRoute(builder: (context) => DoYouKnowDetail()),
//        );
      },
    ),
  );
}

Widget _page2(BuildContext context) {
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
                      "설레임은 어떻게 분리수거해야할까?",
                      style: mainRegular,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "2020년 1월 1일",
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

Widget _page3(BuildContext context) {
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
                      "쓰레기가 자연적으로 분해되는 시간",
                      style: mainRegular,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "2020년 1월 1일",
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

Future<RclDetail> getData(String itemId) async {
  print("요청 진입 : " + itemId.toString());
  http.Response response = await http.get(
      Uri.encodeFull('http://smartcycle.ljhnas.com/api/trash/$itemId'),
      headers: {"Accept": "application/json"});

  //printch
  // ("받은 쓰레기 이름" + TrashType().getTrashName(itemId));
  print(response.body);
  final jsonData = json.decode(response.body.toString());
  RclDetails data = RclDetails.fromJson(jsonData);
  rclData = data.rcls[0];
  print(data.rcls[0].name.toString());

  return rclData;
  //print("데이터가 잘 전송되고 있어요." + detailData['step2Content']);
}

Future<Widget> networkCheck() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    // noNetwork
    return showDialog(
      context: mContext,
      builder: (BuildContext context) =>
          SmartDialog(
            title: "네트워크 없음.",
            content: "네트워크가 필요한 작업이 있기 때문에 기능이 제한됩니다.",
            colors: Colors.red,
          ),
    );
  }
}

//Future<String> getDoYouKnow() async {
//  String loadStr = await rootBundle.loadString('assets/data/doYouKnow.json');
//  print(loadStr);
//  return loadStr;
//}
//  Stream<List<int>> stream = new File("assets/json/doYouKnow.json").openRead();
//  StringBuffer buffer = new StringBuffer();
//  stream.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
//    print("ReadData : $data");
//    buffer.write(data);
//  }, onDone: () => print(buffer.toString()), onError: (e) => print(e));
