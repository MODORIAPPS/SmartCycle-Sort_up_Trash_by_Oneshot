import 'dart:convert';
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

class AuthPage extends StatelessWidget {
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
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 20),
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
                        _openGoogleAuth();
                      },
                    ),),
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

Future<String> _openGoogleAuth() async {
  String data;
  await launch("https://smartcycle.ljhnas.com/getGoogleAuth").then((value) {

  });
  //print(data.toString());
  return data;
}

// GET /getGoogleAuth 의 응답 결과 예시
// { "access_token": ya29.Il-PBzH0ujxpeon-TCBdu7eL9fydzpfKJmoGY5rrQTVp29ANANarLREQ6Ipo-iTgnHe_YNOLjrzBvsEe4W74-behloGRib5Z258uVa5lR5TGzTMZ8AkSn7sKLqrQDaKpJw,
// "refresh_token" : 1/VKCgCK35dvRxZVp6xc-0zWizdSbX96enrvp_vHBQOMc,
// "expires_in" : 3600 }
