import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/styles/Styles.dart';

class NewHistoryCard extends StatelessWidget {
  final int id;
  final String itemName;
  final String date;
  final String itemImage;
  final int itemIndex;

  NewHistoryCard(
      {this.id, this.itemImage, this.date, this.itemName, this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemIndex % 2 == 0
          ? EdgeInsets.only(left: 14, right: 7, top: 10)
          : EdgeInsets.only(right: 14, left: 7, top: 10),
      child: InkWell(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 10),
                    blurRadius: 10)
              ]),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: SmartCycleServer.getPresentImageTest(itemImage),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      alignment: Alignment(-.2, 0),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  height: 75,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              itemName,
                              style: TextAssets.cardBlue,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Text(
                              date,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 10),
                            blurRadius: 10)
                      ]),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          var number = TrashType().getTrashNumber(itemName);

          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RecycleDetail(
                      itemID: number,
                      mode: false,
                    )),
          );
        },
      ),
    );
  }
}
