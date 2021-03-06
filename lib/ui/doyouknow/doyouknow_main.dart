import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/TabletDetector.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/styles/Styles.dart';
import 'package:smartcycle/ui/doyouknow/doyouknow_card.dart';
import 'package:smartcycle/ui/doyouknow/doyouknow_contents.dart';

List<Widget> contentWidgets;

class DoYouKnowMain extends StatelessWidget {
  final DoYouKnow doYouKnow;

  DoYouKnowMain({@required this.doYouKnow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,

        children: <Widget>[
          Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: doYouKnow.preImage,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
//                alignment: Alignment(-.2, 0),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: new Border.all(
                          width: 20, color: Colors.transparent),
                      color: new Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      doYouKnow.title,
                      style: TextAssets.mainBlackW,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          size: 28,
                          color: Colors.white,
                        ),
                        Text(
                          "${AppLocalizations.of(context).translate(
                              'doyouknow_read_time_start')} ${doYouKnow
                              .readTime}${AppLocalizations.of(context)
                              .translate('doyouknow_read_time_end')}",
                          style: TextAssets.mainBoldW,
                        )
                      ],
                    ),
                    Text(
                      doYouKnow.published_date,
                      style: TextAssets.mainLightW,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ),
            ],
          ),
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 10.0,
                  floating: true,
                  elevation: 2,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black87),
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      title:
                      Text(doYouKnow.title, style: TextAssets.mainRegular),
                      background: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: doYouKnow.preImage,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
//                alignment: Alignment(-.2, 0),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: new Border.all(
                                  width: 20, color: Colors.transparent),
                              color: new Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                        ],
                      )),
                ),
              ];
            },
            body: _contents(doYouKnow, context),
          ),
        ],
      ),
    );
  }
}

Widget _contents(DoYouKnow doYouKnow, BuildContext context) {
  contentWidgets = new List();
  if (contentWidgets.length == 0) {
    for (var _contents in doYouKnow.contents) {
      var data = Contents(
          secTitle: _contents.secTitle,
          image: _contents.image,
          secContent: _contents.secContent);
      contentWidgets.add(DoYouKnowContents(contents: data));
    }
  }

  double margin = TabletDetector.isTablet(context) ? 30 : 15;

  return SingleChildScrollView(
    primary: false,
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text(
                doYouKnow.title,
                style: TextAssets.mainBlack,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    size: 28,
                    color: Colors.black87,
                  ),
                  Text(
                    "${AppLocalizations.of(context).translate(
                        'doyouknow_read_time_start')} ${doYouKnow
                        .readTime}${AppLocalizations.of(context).translate(
                        'doyouknow_read_time_end')}",
                    style: TextAssets.mainBold,
                  )
                ],
              ),
              Text(
                doYouKnow.published_date,
                style: TextAssets.mainLight,
              )
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.black38,
        ),
        Padding(
          padding: EdgeInsets.only(left: margin, right: margin),
          child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: contentWidgets),
        ),
      ],
    ),
  );
}
