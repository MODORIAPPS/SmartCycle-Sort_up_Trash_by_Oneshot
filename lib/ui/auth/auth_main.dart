import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/ui/auth/auth_login.dart';
import 'package:smartcycle/ui/auth/auth_profile.dart';

BuildContext mContext;

String access_token = "INIT";
bool isUserAvail = false;
bool isAccessTokenAvail = false;
bool isProfileAlreadyLoaded = false;

String userEmail;
String userName;
String userId;
String userProfile;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<bool> _isSignIn;

//  Future<AuthMainData> initAccessToken() async {
//    String access_token = await AuthUtils().getAccessToken();
//    String user_id = await AuthUtils().getUserId();
//    if (access_token == null || access_token.isEmpty) return null;
//    return AuthMainData(access_token: access_token, user_id: user_id);
//  }

  @override
  void initState() {
    super.initState();
    _isSignIn = AuthUtils().isSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
          future: _isSignIn,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("ddd");
          if (!snapshot.data) {
            return LoginPage();
          } else {
            return AuthProfile(
              access_token: "DD",
              user_id: "dd",
            );
          }
        } else {
          return SCircularProgressWithBtn();
        }
      },
    ));
  } //  @override
//  Widget build(BuildContext context) {
//    if (access_token == null || access_token.length <= 10) {
//      AuthUtils().getAccessToken().then((token) {
//        access_token = token;
//        if (access_token.length >= 8) {
//          isAccessTokenAvail = true;
//        } else {
//          isAccessTokenAvail = false;
//        }
//
//        print("액세스 토큰의 유무 : " + isAccessTokenAvail.toString());
//
//        setState(() {});
//      });
//
//      AuthUtils().getUserId().then((user_id) {
//        userId = user_id;
//      });
//    } else {
//      if (isProfileAlreadyLoaded != true) {}
//    }
//
//    mContext = context;
//    return Scaffold(
//        body: !isAccessTokenAvail
//            ? LoginPage()
//            : AuthProfile(
//          user_id: userId,
//          access_token: access_token,
//        ));
//    //body: LoginPage());
//  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AuthMainData {
  String access_token;
  String user_id;

  AuthMainData({this.access_token, this.user_id});
}

//Future<String> _openGoogleAuth() async {
//  String data;
//  await launch("https://smartcycle.ljhnas.com/getGoogleAuth").then((value) {});
//  //print(data.toString());
//  return data;
//}

// GET /getGoogleAuth 의 응답 결과 예시
// { "access_token": ya29.Il-PBzH0ujxpeon-TCBdu7eL9fydzpfKJmoGY5rrQTVp29ANANarLREQ6Ipo-iTgnHe_YNOLjrzBvsEe4W74-behloGRib5Z258uVa5lR5TGzTMZ8AkSn7sKLqrQDaKpJw,
// "refresh_token" : 1/VKCgCK35dvRxZVp6xc-0zWizdSbX96enrvp_vHBQOMc,
// "expires_in" : 3600 }
