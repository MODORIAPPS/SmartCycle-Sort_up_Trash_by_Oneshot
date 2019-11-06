import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/ui/main/main_doyouknow.dart';
import 'package:smartcycle/ui/main/main_qr_code.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/ui/camera/camera_start.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/ui/main/main_app_bar.dart';
import 'package:smartcycle/ui/main/main_history_gridview.dart';
import 'Utils/ScaleRoute.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
//        '/cameraStart' : (context) => CameraActvity(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> _isSignIn;
  Future<UserInfo> _userInfo;
  String user_email = "";

  var history = new List<SearchHistory>();

  @override
  initState() {
    networkCheck(context);
    super.initState();

    _isSignIn = AuthUtils().isSignIn();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    networkCheck(context);

    if (user_email == null) {
      _isSignIn = AuthUtils().isSignIn();
    }

    return Scaffold(
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FloatingActionButton(
          onPressed: () {
            if (user_email != null) {
              Navigator.push(
                context,
                ScaleRoute(
                    widget: CameraActvity(
                      userEmail: user_email,
                    )),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    SmartDialog(
                      title: "로그인 필요",
                      content: "로그인이 필요한 서비스입니다.",
                      colors: Colors.orange,
                    ),
              );
            }
          },
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          // elevation: 5.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.settings),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        SmartDialog(
                          title: "준비중",
                          content: "죄송합니다. 아직 준비중입니다.",
                          colors: Colors.orange,
                        ),
                  );
                },
              ),
              IconButton(
                iconSize: 35.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Image.asset(
                  "assets/images/qrCode.png",
                  color: Colors.black87,
                  width: 35,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        QrDialog(
                          title: "QR코드",
                          description: "이 QR코드를 기기의 카메라 앞에 대세요.",
                          posiBtn: "알겠습니다.",
                          // userEmail
                          url: user_email,
                        ),
                  );
                },
              )
            ],
          )),
      body: FutureBuilder<bool>(
        future: _isSignIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              // already signed

              print("유저 로그인 되어있음");

              // Call currentUser
              _userInfo = AuthUtils().currentUser();
              return FutureBuilder<UserInfo>(
                future: _userInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    user_email = snapshot.data.email;
                    return mainColumn(context, snapshot.data.photoUrl, true,
                        true, snapshot.data.email);
                  } else {
                    return mainColumn(context, "NO", false, false, "NO");
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
        height: 30,
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
      Container(
        height: 200,
        child: MainDoYouKnow(),
      ),

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
