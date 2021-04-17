import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/Utils/SmartDialog.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/ui/policy/policy_main.dart';

TextEditingController controller = new TextEditingController();

class CameraFeedBack extends StatelessWidget {
  final File imageFile;
  final String user_email;

  CameraFeedBack({@required this.user_email, @required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('camera_feed_back'),
          style: TextAssets.mainRegular,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .translate('camera_feed_back_text1'),
                        style: TextAssets.mainBlack,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('camera_feed_back_text2'),
                        style: TextAssets.mainBold,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('camera_feed_back_text3'),
                  style: TextAssets.subBold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('camera_feed_back_input'),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      )),
                  keyboardType: TextInputType.text,
                  style: TextAssets.mainRegular,
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('camera_feed_back_text4'),
                      style: TextAssets.infoBold,
                    ),
                  ),
                  ButtonTheme(
                      minWidth: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('camera_feed_back_submit_btn'),
                          style: TextAssets.mainRegularW,
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            _showSubmitDialog(context, controller.text,
                                imageFile, user_email);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => SmartDialog(
                                title: AppLocalizations.of(context).translate(
                                    'camera_feed_back_submit_error_title'),
                                content: AppLocalizations.of(context).translate(
                                    'camera_feed_back_submit_error_content'),
                                colors: Colors.red,
                              ),
                            );
                          }
                        },
                        color: Colors.blue,
                        elevation: 5,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

_showSubmitDialog(
    BuildContext mContext, String _value, File imageFile, String user_email) {
  showDialog(
      context: mContext,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)
                    .translate('dialog_feedback_need_title'),
                style: TextAssets.mainBold,
              ),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PolicyMain(),
                    ),
                  );
                },
              ),
            ],
          ),
          content: Text(
            AppLocalizations.of(context)
                .translate('dialog_feedback_need_content'),
            style: TextAssets.mainRegular,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  SmartCycleServer().saveHistory(imageFile, user_email, false,
                      controller.text.toString(), false);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)
                      .translate('dialog_negative_default'),
                  style: TextAssets.dialogText,
                )),
            FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => SmartDialog(
                    title: AppLocalizations.of(context)
                        .translate('dialog_feedback_title'),
                    content: AppLocalizations.of(context)
                        .translate('dialog_feedback_content'),
                    colors: Colors.green,
                  ),
                );
                SmartCycleServer().saveHistory(imageFile, user_email, false,
                    controller.text.toString(), false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text(
                AppLocalizations.of(context)
                    .translate('dialog_positive_default'),
                style: TextAssets.dialogText,
              ),
            )
          ],
        );
      });
}
