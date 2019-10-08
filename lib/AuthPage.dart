import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcycle/AddDevice.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/SmartDialog.dart';
import 'package:smartcycle/TutorialsPage.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/styles/CustomStyle.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'model/GoogleUserDTO.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

BuildContext mContext;

String access_token = "INIT";
bool isUserAvail = false;
bool isAccessTokenAvail = false;
bool isProfileAlreadyLoaded = false;

String userEmail;
String userName;
String userID;
String userProfile;

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
    'openid',
    'profile',
  ],
);

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    if (access_token == null || access_token.length <= 10) {
      AuthUtils().getAccessToken().then((token) {
        access_token = token;
        if (access_token.length >= 8) {
          isAccessTokenAvail = true;
        } else {
          isAccessTokenAvail = false;
        }

        print("액세스 토큰의 유무 : " + isAccessTokenAvail.toString());

        setState(() {});
      });

//      _googleSignIn.signInSilently().then((value) {
//        print(value);
//      });
    }

    if (access_token != null && access_token.length >= 50) {
      if (isProfileAlreadyLoaded != true) {
        AuthUtils().getGoogleProfile(access_token).then((profile) {
          if (profile == "401") {
            // 액세스 토큰 기간 만료 이므로 재 요청
//            AuthUtils().getNewAccessTokenByRefreshToken();
//            AuthUtils().getGoogleProfile(access_token).then((profile) {
//              userProfile = jsonDecode(profile);
//              isProfileAlreadyLoaded = true;
//
//              setState(() {});
//            });

//            _googleSignIn.signInSilently().then((signIn){
//              signIn.authentication.then((auth){
//              signIn.authentication.then((auth){
//                print("새로운 : " + auth.accessToken);
//              });
//            });
            _handleSignIn().then((value) {
              isProfileAlreadyLoaded = true;
            });
          }
          print(profile);
          var data = json.decode(profile);
          print(data['email']);

          userEmail = data["email"];
          userName = data["name"];
          userID = data["sub"];
          userProfile = data["picture"];

          isProfileAlreadyLoaded = true;

          print(userName);
          setState(() {});
        });
      }
    }

    mContext = context;
    return Scaffold(
        body: !isAccessTokenAvail ? LoginPage() : UserPage(context));
  }

  @override
  void dispose() {
    access_token = "INIT";
    isUserAvail = false;
    isAccessTokenAvail = false;
    isProfileAlreadyLoaded = false;
  }

//
//  @override
//  void initState() {
//
//  }
}

Widget UserPage(BuildContext context) {
//  if (isProfileAlreadyLoaded != true) {
//    AuthUtils().getGoogleProfile(access_token).then((value) {
//      print(value);
//      var data = json.decode(value);
//      print(data['email']);
//
//      userEmail = data["email"];
//      userName = data["name"];
//      userID = data["family_name"];
//      userProfile = data["picture"];
//
//      isProfileAlreadyLoaded = true;
//      print(userName);
//
//
//    });
//  }

  return isProfileAlreadyLoaded
      ? Scaffold(
          appBar: AppBar(
            title: Text(
              "사용자 계정정보",
              style: appBarRegular,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: InkWell(
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
                                image: NetworkImage(userProfile)))),
                    onTap: () {
                      // Toast message
//                Navigator.of(context).push(
//                  MaterialPageRoute(builder: (context) => AuthPage()),
//                );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: Text(
                                userName,
                                style: mainBold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.email),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    userEmail,
                                    style: normalText,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.pages),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    userID,
                                    style: normalText,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 6),
                              blurRadius: 6)
                        ]),
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "기기 연결",
                          style: mainBold,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 7,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            noDeviceAvail(),
                            //myDeviceInfo()
                          ],
                        )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 6),
                              blurRadius: 6)
                        ]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        "로그아웃",
                        style: TextStyle(color: Colors.orange),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.orange, width: 1)),
                      color: Colors.white,
                      //splashColor: Colors.yellow,
                      onPressed: () {
                        // Logout
                        _asyncConfirmDialog(context);
                      },
                    ),
                  ),
                ),

//          Padding(
//            padding: const EdgeInsets.all(15.0),
//            child: ButtonTheme(
//              minWidth: double.infinity,
//              child: RaisedButton(
//                child: Text(
//                  "서비스 탈퇴",
//                  style: TextStyle(color: Colors.red),
//                ),
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(30.0),
//                    side: BorderSide(color: Colors.red, width: 1)),
//                color: Colors.white,
//                onPressed: () {
//                  // Logout
//                  _asyncConfirmDialog(context);
//                },
//              ),
//            ),
//          ),
              ],
            ),
          ),
        )
      : Container(
          child: Align(
            child: Image.asset('assets/images/loading.gif'),
          ),
        );
}

Widget LoginPage() {
  return Stack(
    children: <Widget>[
      ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment(-.2, 0),
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1569493086584-33e0b36f3145?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80'),
                  fit: BoxFit.cover),
            ),
          )),
      Container(
        decoration: BoxDecoration(
          border: new Border.all(width: 20, color: Colors.transparent),
          color: new Color.fromRGBO(0, 0, 0, 0.3),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "SmartCycle과 함께 깨끗한 지구 만들기.",
                        style: authBold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "설치해주셔서 감사합니다.",
                  style: authRegular,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 6),
                            blurRadius: 6)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 5, bottom: 5),
                          child: Image.asset(
                            "assets/images/googleLogo.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "구글 계정으로 로그인",
                            textAlign: TextAlign.center,
                            style: authBtn,
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: mContext,
                    builder: (BuildContext context) =>
                        SmartDialog(
                          title: "네트워크 없음.",
                          content: "로그인 또는 회원가입을 위해 인터넷 접속이 필요합니다.",
                          colors: Colors.red,
                        ),
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                InkWell(
                  child: Text(
                    "이용약관",
                    style: startLight,
                  ),
                  onTap: () {
                    launch("https://smartcycle.ljhnas.com/terms");
                  },
                ),
                Text(
                  "Photo by 'Christopher Rusev' on Unsplash",
                  style: startLight,
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget noDeviceAvail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    verticalDirection: VerticalDirection.up,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "연결된 내 기기 없음.",
              style: noDeviceAlert,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "오른쪽 버튼을 눌러 새 기기를 추가하세요",
              style: normalText,
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            icon: Icon(
              Icons.add_box,
              color: Colors.black87,
            ),
            iconSize: 40,
            onPressed: () {
              Navigator.of(mContext).push(
                MaterialPageRoute(builder: (context) => AddDevice()),
              );
            }),
      )
    ],
  );
}

Widget myDeviceInfo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.devices_other,
                size: 45,
              )
            ],
          ),
          SizedBox(
            width: 13,
          ),
          Column(
            children: <Widget>[
              Text(
                "N832E7GdAI3D",
                style: normalText,
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          child: Icon(
            Icons.delete_outline,
            color: Colors.black45,
            size: 25,
          ),
          onTap: () {},
        ),
      )
    ],
  );
}

Future<String> _openGoogleAuth() async {
  String data;
  await launch("https://smartcycle.ljhnas.com/getGoogleAuth").then((value) {});
  //print(data.toString());
  return data;
}

Future<void> _handleSignIn() async {
  try {
    //_googleSignIn.
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    access_token = authentication.accessToken;
    print(account.toString());
    print(authentication.toString());

    if (access_token != "INIT") {
      AuthUtils().saveAccessToken(access_token);
      isUserAvail = true;
    }
  } catch (error) {
    print(error);
  }
}

Future<bool> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('로그아웃'),
        content: const Text('예기치 못한 문제가 발생하거나 다른 계정이 있는 경우 도움이 될 수 있습니다.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('로그아웃'),
            onPressed: () {
              AuthUtils().signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          )
        ],
      );
    },
  );
}
// GET /getGoogleAuth 의 응답 결과 예시
// { "access_token": ya29.Il-PBzH0ujxpeon-TCBdu7eL9fydzpfKJmoGY5rrQTVp29ANANarLREQ6Ipo-iTgnHe_YNOLjrzBvsEe4W74-behloGRib5Z258uVa5lR5TGzTMZ8AkSn7sKLqrQDaKpJw,
// "refresh_token" : 1/VKCgCK35dvRxZVp6xc-0zWizdSbX96enrvp_vHBQOMc,
// "expires_in" : 3600 }
