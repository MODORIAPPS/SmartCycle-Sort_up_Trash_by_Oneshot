import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/RcleDetail.dart';

class RclDetailDefault extends StatelessWidget {
  final RclDetail rclDetail;

  RclDetailDefault({this.rclDetail});

  @override
  Widget build(BuildContext context) {
    var compositionWidgets = List<Widget>();
    var stepWidgets = List<Widget>();

    if (compositionWidgets.length == 0) {
      for (var composition in rclDetail.information.composition) {
        compositionWidgets
            .add(CompositionWidget(composition.part, composition.value));
      }
      int i = 1;
      for (var step in rclDetail.information.step) {
        stepWidgets.add(StepWidget(step.imageURL_step, step.contents, i));
        i++;
      }
    }
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 10.0,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: Colors.white,
            elevation: 10,
            iconTheme: IconThemeData(color: Colors.black87),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("분리수거 하기", style: TextAssets.mainRegular),
            ),
          ),
        ];
      },
      body: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _title(rclDetail),
              SizedBox(
                height: 30,
              ),
              _element(rclDetail),
              new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    children: compositionWidgets,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              new ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    children: stepWidgets,
                  )
                ],
              ),
              _doYouKnow(rclDetail)
            ],
          ),
        ),
      ),
    );
  }
}

Widget CompositionWidget(String part, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          part,
          style: TextAssets.mainRegular,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          value,
          style: TextAssets.mainBold,
        )
      ],
    ),
  );
}

Widget StepWidget(String image, String step, int i) {
  var base = 'http://smartcycle.ljhnas.com/pictures/';
  var test_base = SmartCycleServer.test_base;

  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "STEP " + i.toString(),
            style: TextAssets.mainBold,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CachedNetworkImage(
//              imageUrl: base + image,
              // %% ONLY FOR TEST %% getImage
              imageUrl: base + image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
//                alignment: Alignment(-.2, 0),
              width: double.infinity,
              alignment: Alignment.center,
            )
//          child: Image.network(
//            base + image,
//            width: double.infinity,
//          ),
            ),
        Text(
          step,
          style: TextAssets.mainRegular,
        )
      ],
    ),
  );
}

Widget _doYouKnow(RclDetail rclDetail) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "알고계셨나요?",
        style: TextAssets.mainBold,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        rclDetail.name + "이(가) 자연에서 완전히 분해되기까지 걸리는 시간",
        style: TextAssets.mainRegular,
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.timelapse,
            size: 35,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            rclDetail.information.time_rot,
            style: TextAssets.subBold,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      )
    ],
  );
}

Widget _title(RclDetail rclDetail) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        rclDetail.name + " 을(를) 분리수거 하는 방법",
        style: TextAssets.mainBold,
      ),
    ],
  );
}

Widget _element(RclDetail rclDetail) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 28,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            rclDetail.name + "을(를) 구성하는 요소",
            style: header2,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
