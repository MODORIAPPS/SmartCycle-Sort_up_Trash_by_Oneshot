import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/RcleDetail.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_pageview_card.dart';

class RclDetailPageView extends StatelessWidget {
  final RclDetail rclDetail;

  RclDetailPageView({this.rclDetail});

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
        stepWidgets.add(RclDetailPageViewCard(
          step: step,
          count: i,
        ));
        i++;
      }
    }

    return PageView(
      children: <Widget>[
        _title(rclDetail, context),
        _showMaterials(rclDetail, context, compositionWidgets),

      ],
    );
  }
}

Widget _title(RclDetail rclDetail, BuildContext context) {
  return Stack(
    children: <Widget>[
      CachedNetworkImage(
//              imageUrl: rclDetail.imageURL,
        imageUrl: SmartCycleServer.base_n + "/pictures" + rclDetail.imageURL + ".jpg",
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
              ),
            ),
//                alignment: Alignment(-.2, 0),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      Container(
        decoration: BoxDecoration(
          border: new Border.all(width: 20, color: Colors.transparent),
          color: new Color.fromRGBO(0, 0, 0, 0.3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 30),
            child: Column(
              children: <Widget>[
                Text(
                  "${rclDetail.name}을(를) 분리수거 하는 방법",
                  style: TextAssets.mainBlackW,
                ),

              ],
            )
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 30),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.close),
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
      ),
    ],
  );
}

Widget _showMaterials(RclDetail rclDetail, BuildContext context,
    List<Widget> compoWidget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

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
      new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: compoWidget,
          ),
        ],
      ),
    ],
  );
}

Widget CompositionWidget(String part, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
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
