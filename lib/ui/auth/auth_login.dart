import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/ui/main/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl:
          "https://source.unsplash.com/collection/162468/1080x1920",
          placeholder: (context, url) => SCircularProgress(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          alignment: Alignment(-.2, 0),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            border: new Border.all(width: 20, color: Colors.transparent),
            color: new Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "SmartCycle과 함께 깨끗한 지구 만들기.",
                                style: TextAssets.mainBoldW,
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
                  ),
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
//                  showDialog(
//                    context: mContext,
//                    builder: (BuildContext context) =>
//
//                        SmartDialog(
//                          title: "네트워크 없음.",
//                          content: "로그인 또는 회원가입을 위해 인터넷 접속이 필요합니다.",
//                          colors: Colors.red,
//                        ),
//                  );
//                    AuthUtils().openGoogleSignIn();
                    AuthUtils()
                        .handleSignIn()
                        .then((FirebaseUser user) => print(user))
                        .catchError((e) => print(e))
                        .whenComplete(() {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    });
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
}
