import 'package:flutter/material.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';

class PolicyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        title: Text(
          AppLocalizations.of(context)
              .translate('policy_appbar'),
          style: TextAssets.mainRegular,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(ImageAssets.sirenImage),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate('policy_title'),
                  style: TextAssets.mainBlack,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('policy_content1'),
                  style: TextAssets.mainRegular,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('policy_content2'),
                  style: TextAssets.mainRegular,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('policy_footer'),
                  style: TextAssets.mainRegular,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
