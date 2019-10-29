import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/RcleDetail.dart' as rclDTO;

class RclDetailPageViewCard extends StatelessWidget {
  final int count;
  final rclDTO.Step step;

  RclDetailPageViewCard({@required this.step, @required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30, right: 15, bottom: 20),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "$count 단계",
              style: TextAssets.mainBlack,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: ClipRRect(
                child: CachedNetworkImage(
//              imageUrl: base + image,
                  // %% ONLY FOR TEST %% getImage
                  imageUrl: SmartCycleServer.getServerImage(step.imageURL_step),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  ),
//                alignment: Alignment(-.2, 0),
                  alignment: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 6),
                        blurRadius: 6)
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    step.contents,
                    style: TextAssets.mainRegular,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 6),
                          blurRadius: 6)
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
