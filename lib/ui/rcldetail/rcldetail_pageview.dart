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
    return PageView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CachedNetworkImage(
//              imageUrl: rclDetail.imageURL,
              imageUrl:
                  SmartCycleServer.base_n + "/pictures" + rclDetail.imageURL,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Align(
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
                child: Text(
                  "${rclDetail.name}을(를) 분리수거 하는 방법",
                  style: TextAssets.mainBlackW,
                ),
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
        ),
        RclDetailPageViewCard()
      ],
    );
  }
}
