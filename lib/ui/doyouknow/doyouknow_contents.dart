import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/DoYouKnowDTO.dart';

class DoYouKnowContents extends StatelessWidget {
  final Contents contents;

  DoYouKnowContents({this.contents});

  @override
  Widget build(BuildContext context) {
    print("카드 컨텐츠.." + contents.image.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          contents.image.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: contents.image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
//                alignment: Alignment(-.2, 0),
                  width: double.infinity,
                  alignment: Alignment.center,
                )
              : Text(""),
          Text(
            contents.secTitle,
            style: TextAssets.mainRegular,
          ),
          Text(contents.secContent)
        ],
      ),
    );
  }
}
