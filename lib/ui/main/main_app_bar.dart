import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/TabletDetector.dart';
import 'package:smartcycle/ui/tutorials/TutorialsPage.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/styles/Styles.dart';
import '../auth/auth_main.dart';

class SmartCycleAppBar extends StatefulWidget {
  final bool isSignIn;
  final String photoUrl;

  const SmartCycleAppBar({Key key, this.isSignIn, this.photoUrl})
      : super(key: key);

  @override
  _SmartCycleAppBarState createState() => _SmartCycleAppBarState();
}

class _SmartCycleAppBarState extends State<SmartCycleAppBar> {
  @override
  Widget build(BuildContext context) {
    print(widget.isSignIn);
    double margin = TabletDetector.isTablet(context) ? 30 : 15;

    return Padding(
      padding: EdgeInsets.only(left: margin, right: margin, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Row(
              children: <Widget>[
                Image.asset(
                  ImageAssets.blue_logo,
                  width: 35.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "SmartCycle",
                    style: TextAssets.mainRegular,
                  ),
                )
              ],
            ),
//            onTap: () {
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                    builder: (context) => TutorialsPage(
//                      pageCode: 1,
//                    )),
//              );
//            },
          ),
          InkWell(
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
                        image: widget.isSignIn
                            ? NetworkImage(widget.photoUrl)
                            : AssetImage(
                            "assets/images/google_user_default.png")))),
            onTap: () {
              // Toast message
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
