import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';

class DoYouKnowContents extends StatelessWidget {
  final Contents contents;

  DoYouKnowContents({this.contents});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: contents.image.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: contents.image,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
//                alignment: Alignment(-.2, 0),
                  width: double.infinity,
                  alignment: Alignment.center,
                )
                    : Text(""),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            contents.secTitle,
            style: TextAssets.mainBold,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            contents.secContent,
            style: TextAssets.insideContents,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
