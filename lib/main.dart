import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcycle/ui/doyouknow/doyouknow_main.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/ScaleRoute.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/ui/tutorials/TutorialsPage.dart';
import 'package:smartcycle/model/GoogleProfileDTO.dart' as prefix0;
import 'package:smartcycle/model/InitUserDTO.dart';
import 'package:smartcycle/ui/main/main_qr_code.dart';
import 'package:smartcycle/ui/auth/auth_main.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/ui/camera/camera_start.dart';
import 'package:smartcycle/ui/main/main_history_card.dart';
import 'package:smartcycle/ui/rcldetail/RecycleDetail.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:http/http.dart' as http;
import 'package:smartcycle/ui/main/main_app_bar.dart';
import 'package:smartcycle/ui/main/main_history_gridview.dart';

import 'model/GoogleProfileDTO.dart';
import 'model/RcleDetail.dart';

void main() => runApp(MyApp());

//bool doYouKnowGo = false;
//bool isUserAvail = false;
//bool isHistoryReady = false;
//
//SearchHistorys historys;
//var userProfileURL;
//var user_email;

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
  Future<InitUserDTO> _getinitUserData;
  Future<bool> _isSignIn;
  Future<UserInfo> _userInfo;

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
    networkCheck(context);
    super.initState();

    _isSignIn = AuthUtils().isSignIn();

    //_userInfo = AuthUtils().currentUser();
    //_isSignIn = AuthUtils().isSignIn();
    //_getinitUserData = AuthUtils().getInitialUserData();

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
  }

  @override
  dispose() {
    _animationController.dispose();
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

  Widget _launchCamera(BuildContext context) {
    return Container(
      child: new FloatingActionButton(
        heroTag: "imageFab",
        onPressed: () {
          Navigator.push(
            context,
            ScaleRoute(widget: CameraActvity()),
          );
        },
        tooltip: 'camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _launchQrCode(String email) {
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
                    // userEmail
                    url: email,
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
    networkCheck(context);

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
                child: _launchCamera(context),
              ),
              Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  _translateButton.value,
                  0.0,
                ),
                child: _launchQrCode("Dd"),
              ),
              toggle(),
            ],
          )),
      body: FutureBuilder<bool>(
        future: _isSignIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              // already signed

              // Call currentUser
              _userInfo = AuthUtils().currentUser();
              return FutureBuilder<UserInfo>(
                future: _userInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return mainColumn(context, snapshot.data.photoUrl, true,
                        true, snapshot.data.email);
                  } else {
                    return mainColumn(context, "NO", false, true, "NO");
                  }
                },
              );
            } else {
              // not signed
              return mainColumn(context, "NO", false, true, "NO");
            }
          } else {
            // connecting to server
            return mainColumn(context, "NO", false, false, "NO");
          }
        },
      ),
    );
  }
}

Widget mainColumn(BuildContext context, String photoUrl, bool isSigned,
    bool done, String email) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 20,
      ),
//          SmartCycleAppBar(
//            isUserAvail: snapshot.data,
//            userProfileURL: "",
//          ),
      SmartCycleAppBar(
        isSignIn: isSigned,
        photoUrl: photoUrl,
      ),

      Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "알고계셨나요?",
              style: TextAssets.mainBold,
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
          //setState(() {});
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
          style: TextAssets.mainBold,
        ),
      ),

      // TEST DATA
      (done)
          ? HistoryGridView(
        isSignIn: isSigned,
        userEmail: email,
      )
          : Text("서버에 접속중입니다."),
    ],
  );
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

//Widget _row(BuildContext context) {
//  return Row(
//    children: <Widget>[
//      Flexible(
//        flex: 1,
//        child: Column(
//          children: <Widget>[
//            SizedBox(
//              height: 30,
//            ),
//            Image.asset("assets/images/icecream.png"),
//            RaisedButton(
//              child: Text("임시 버튼"),
//              onPressed: () {
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                      builder: (context) => RecycleDetail(
//                        keyword: "페트병",
//                      )),
//                );
//              },
//            ),
//            RaisedButton(
//              child: Text("임시 버튼"),
//              onPressed: () {
//                // Google auth 로그인 상태 아닌 경우 로그인 창으로 이동(사실상 최초 실행시 소개 페이지와 같음)
//                Navigator.of(context).push(
//                  MaterialPageRoute(builder: (context) => AuthPage()),
//                );
//              },
//            ),
//          ],
//        ),
//      ),
//      Flexible(
//          flex: 1,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              SizedBox(
//                height: 30,
//              ),
//              Text(
//                "오늘의 분리수거\n알아보기",
//                textAlign: TextAlign.left,
//                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                height: 15,
//              ),
//              Text("날마다 헷갈리는 재활용품의 \n분리수거 방법을 알려드립니다."),
//              SizedBox(
//                height: 30,
//              ),
//              Text(
//                "오늘의 분리수거",
//                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//              ),
//              Text(":  '설레임'",
//                  textAlign: TextAlign.left,
//                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
//            ],
//          )),
//    ],
//  );
//}

//void _showSearchSheet(context) {
//  showModalBottomSheet(
//      context: context,
//      builder: (BuildContext bc) {
//        return Container(
//          child: new Wrap(
//            children: <Widget>[
//              new ListTile(
//                  leading: new Icon(Icons.music_note),
//                  title: new Text('Music'),
//                  onTap: () => {}),
//              new ListTile(
//                leading: new Icon(Icons.videocam),
//                title: new Text('Video'),
//                onTap: () => {},
//              ),
//            ],
//          ),
//        );
//      });
//}

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
                            'https://images.unsplash.com/photo-1495556650867-99590cea3657?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "우리가 무심코 버린 쓰레기가 가는 곳",
                        style: mainRegular,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2019년 9월 12일",
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
//          MaterialPageRoute(builder: (context) => AuthPage()),
//        );

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
                          'https://images.unsplash.com/photo-1524074500728-47a32346e245?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "일상속에서 흔하지만 분리수거 할줄 모르는 그것들.",
                      style: mainRegular,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "2019년 10월 12일",
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
                          'https://images.unsplash.com/photo-1526951521990-620dc14c214b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "2019년 8월 15일",
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

Future<Widget> networkCheck(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    // noNetwork
    return showDialog(
      context: context,
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
