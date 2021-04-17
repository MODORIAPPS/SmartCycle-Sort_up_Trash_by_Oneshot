import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/AuthUtils.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/ScaleRoute.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/Utils/TabletDetector.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/ui/camera/camera_start.dart';
import 'package:smartcycle/ui/main/main_doyouknow.dart';
import 'package:smartcycle/ui/main/main_history_gridview.dart';

import 'main_app_bar.dart';
import 'main_qr_code.dart';
import 'main_search_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                builder: (BuildContext context) => SmartDialog(
                  title: AppLocalizations.of(context)
                      .translate('dialog_login_need_title'),
                  content: AppLocalizations.of(context)
                      .translate('dialog_login_need_content'),
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
                    builder: (BuildContext context) => SmartDialog(
                      title: AppLocalizations.of(context)
                          .translate('dialog_prepare_title'),
                      content: AppLocalizations.of(context)
                          .translate('dialog_prepare_content'),
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
                  if (user_email != "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => QrDialog(
                        title: AppLocalizations.of(context)
                            .translate('dialog_qr_title'),
                        description: AppLocalizations.of(context)
                            .translate('dialog_qr_content'),
                        posiBtn: AppLocalizations.of(context)
                            .translate('dialog_positive_default'),
                        // userEmail
                        url: user_email,
                      ),
                    );
                  }
                },
              )
            ],
          )),
      body: FutureBuilder<bool>(
        future: _isSignIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              print(snapshot.data.toString());
              // already signed

              print("유저 로그인 되어있음");

              // Call currentUser
              _userInfo = AuthUtils().currentUser();
              return FutureBuilder<UserInfo>(
                future: _userInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // print(snapshot.data);
                    user_email = snapshot.data.email;
                    return mainColumn(context, snapshot.data.photoURL, true,
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
  double height = TabletDetector.isTablet(context) ? 400 : 180;
  double margin = TabletDetector.isTablet(context) ? 30 : 15;
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
      MainSearchBar(),
      Padding(
        padding: EdgeInsets.only(left: margin, right: margin, top: margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('main_doyouknow'),
              style: TextAssets.mainBold,
            ),
          ],
        ),
      ),
      Container(height: height, child: MainDoYouKnow()),

      SizedBox(
        height: 15,
      ),
      Padding(
        padding: EdgeInsets.only(left: margin),
        child: Text(
          AppLocalizations.of(context).translate('main_search_history'),
          style: TextAssets.mainBold,
        ),
      ),

      (done)
          ? HistoryGridView(
              isSignIn: isSigned,
              userEmail: email,
            )
          : SCircularProgress(),
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
      builder: (BuildContext context) => SmartDialog(
        title:
            AppLocalizations.of(context).translate('dialog_no_network_title'),
        content:
            AppLocalizations.of(context).translate('dialog_no_network_content'),
        colors: Colors.red,
      ),
    );
  }
}
