import 'package:flutter/material.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';

class ErrorPage extends StatelessWidget {
  final error_msg;

  ErrorPage({this.error_msg});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                AppLocalizations.of(context)
                    .translate('act_error_title'),
                style: TextAssets.mainBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)
                    .translate('act_error_content'),
                style: TextAssets.mainBold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                AppLocalizations.of(context)
                    .translate('act_error_content2'),
                style: TextAssets.mainRegular,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                error_msg,
                style: TextAssets.errorBold,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                AppLocalizations.of(context)
                    .translate('act_error_content3'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text("dialog_positive_default"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text("kwonkiseok7@gmail.com"),
          ),
        ),
      ],
    );
  }
}
