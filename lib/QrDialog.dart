import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartcycle/styles/Styles.dart';

class Consts {
  Consts._();

  static const double padding = 18.0;
  static const double avatarRadius = 66.0;
}

class QrDialog extends StatelessWidget {
  final String title, description, negaBtn, posiBtn, url;
  final Image image;

  QrDialog({
    this.url,
    @required this.title,
    @required this.description,
    @required this.negaBtn,
    @required this.posiBtn,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Text(
              //   title,
              //   style: TextStyle(
              //     fontSize: 24.0,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              //SizedBox(height: 15.0),
              QrImage(
                data: url,
                size: 0.5 * MediaQuery
                    .of(context)
                    .size
                    .height -
                    MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
              ),
              Text("더 상세한 정보를 얻고 싶다면 카메라에 QR코드를 보여주세요.",
                  textAlign: TextAlign.center, style: mainBold),
              SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "닫기",
                        style: diaBold,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.blueAccent,
        //     radius: Consts.avatarRadius,
        //   ),
        // ),
      ],
    );
  }
}
