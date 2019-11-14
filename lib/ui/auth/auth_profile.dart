import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/driveactivity/v2.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/model/GoogleProfileDTO.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/ui/main/main_page.dart';
import 'package:smartcycle/ui/nugudevice/nugu_add_device.dart';

UserInfo userInfo;

class AuthProfile extends StatefulWidget {
  @override
  _AuthProfileState createState() => _AuthProfileState();
}

class _AuthProfileState extends State<AuthProfile> {
  Future<UserInfo> _userInfo;

  @override
  void initState() {
    super.initState();
    _userInfo = AuthUtils().currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: _userInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          userInfo = snapshot.data;
          return UserProfile(context, snapshot.data);
        } else {
          return SCircularProgress();
        }
      },
    );
  } //  @override

  @override
  void dispose() {
    super.dispose();
  }
}

Widget UserProfile(BuildContext context, UserInfo userinfo) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context).translate('auth_profile_appbar'),
        style: TextAssets.mainRegular,
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
                          image: NetworkImage(userinfo.photoUrl)))),
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
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          userinfo.displayName,
                          style: TextAssets.mainBold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.email),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              userinfo.email,
                              style: normalText,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.pages),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              userinfo.uid,
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

//          Padding(
//              padding: const EdgeInsets.only(left: 20),
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    "기기 연결",
//                    style: TextAssets.mainBold,
//                  ),
//                  IconButton(
//                    icon: Icon(
//                      Icons.info_outline,
//                      color: Colors.black,
//                    ),
//                    onPressed: () {},
//                  )
//                ],
//              )),
//          Padding(
//            padding: const EdgeInsets.only(left: 15, right: 15),
//            child: Container(
//              width: double.infinity,
//              child: Padding(
//                  padding: const EdgeInsets.only(
//                    left: 15,
//                    top: 7,
//                  ),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      noDeviceAvail(context),
//                      //myDeviceInfo()
//                    ],
//                  )),
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(20),
//                  boxShadow: [
//                    BoxShadow(
//                        color: Colors.black12,
//                        offset: Offset(0, 6),
//                        blurRadius: 6)
//                  ]),
//            ),
//          ),

          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('auth_profile_logout_btn'),
                  style: TextAssets.mainRegularW,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(34.0),
                ),
                color: Colors.orangeAccent,
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
//                  "개발자 설정",
//                  style: TextStyle(color: Colors.orange),
//                ),
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(30.0),
//                    side: BorderSide(color: Colors.blue, width: 1)),
//                color: Colors.white,
//                //splashColor: Colors.yellow,
//                onPressed: () {
//                  // Logout
//                  //_asyncConfirmDialog(context);
//                },
//              ),
//            ),
//          ),

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
  );
}

Widget noDeviceAvail(BuildContext context) {
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
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        AddDevice(
                          userInfo: userInfo,
                        )),
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

Future<bool> _asyncConfirmDialog(BuildContext mContext) async {
  return showDialog<bool>(
    context: mContext,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
            AppLocalizations.of(context).translate('auth_profile_logout_btn')),
        content: Text(
            AppLocalizations.of(context).translate(
                'auth_profile_logout_dialog_content')),
        actions: <Widget>[
          FlatButton(
            child: Text(
              AppLocalizations.of(context)
                  .translate('dialog_negative_default2'),
              style: TextAssets.dialogText,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text(
              AppLocalizations.of(context).translate('auth_profile_logout_btn'),
              style: TextAssets.dialogText,
            ),
            onPressed: () {
              AuthUtils().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
