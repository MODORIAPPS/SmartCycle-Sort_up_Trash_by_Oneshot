import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcycle/IntroducePage.dart';
import 'package:smartcycle/styles/CustomStyle.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'model/GoogleUserDTO.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

class StartPage extends StatelessWidget {
  // GoogleSignIn _googleSignIn = new GoogleSignIn(
  //   scopes: [

  //   ],
  // );
  String access_key = "";

  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'openid',
      'profile',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;
      access_key = authentication.accessToken;
      print(account.toString());
      print(authentication.toString());
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(-.2, 0),
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1564419429381-98dbcf916478?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "SmartCycle과 함께 깨끗한 \n지구 만들기.",
                            style: startBold,
                          ),
                        ],
                      ),
                      Text(
                        "설치해주셔서 감사합니다.",
                        style: startRegular,
                      )
                    ],
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/googleLogo.png",
                            width: 50,
                            height: 50,
                          ),
                          Text("구글 계정으로 시작하기")
                        ],
                      ),
                    ),
                    onPressed: () {
                      /// Launch Google Auth API
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => IntroducePage()),
                      // );
                      _handleSignIn();
                    },
                  ),
                  RaisedButton(
                    child: Text("Google+ API"),
                    onPressed: () {
                      _launchURL();
                    },
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          "이용약관",
                          style: startLight,
                        ),
                      ),
                      Text(
                        "Photo by 'Boxed Water Is Better' on Unsplash",
                        style: startLight,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

// Future<String> getGoogleData() async {
//   http.Response response = await http.get(
//       Uri.encodeFull(
//           'http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&APPID=$WEATHER_KEY'),
//       headers: {
//         "Accept": "application/json",
//         HttpHeaders.authorizationHeader: WEATHER_KEY
//       });

//   return response.toString();

// }

_launchURL() async {
  String authUrl;
  getGoogleAuthPage().then((value) {
    authUrl = value;
    launch("http://172.16.0.227:8080/getAccessToken");
  });
}

Future<String> getGoogleAuthPage() async {
  http.Response response = await http.Client().get(
      "http://172.16.0.227:8080/getAccessToken");
  print(response.body.toString());
  return response.body.toString();
}
