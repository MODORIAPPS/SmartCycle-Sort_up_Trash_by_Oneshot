import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/assets.dart';

class DoYouKnowCard extends StatelessWidget {
  final DoYouKnow doYouKnow;

  DoYouKnowCard({this.doYouKnow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: doYouKnow.preImage,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                alignment: Alignment(-.2, 0),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: new Border.all(width: 20, color: Colors.transparent),
                color: new Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        doYouKnow.title,
                        style: TextAssets.mainRegularW,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        doYouKnow.published_date,
                        style: TextAssets.mainLightW,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
            ]),
      ),
    );
  }
}
