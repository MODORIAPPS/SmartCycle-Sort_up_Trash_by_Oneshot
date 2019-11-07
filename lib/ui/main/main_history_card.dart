import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/styles/Styles.dart';

class HistoryCard extends StatelessWidget {
  final int id;
  final String itemName;
  final String date;
  final String itemImage;
  final int itemIndex;

  HistoryCard(
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
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 7), blurRadius: 7)
              ]),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: SmartCycleServer.getPresentImage(itemImage),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        alignment: Alignment(-.2, 0),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                itemName,
                style: settingBlue,
              ),
              Text(
                date,
                style: cardLight,
              )
            ],
          ),
        ),
        onTap: () {
          var number = TrashType().getTrashNumber(itemName);

          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    RecycleDetail(
                      itemID: number,
                      mode: false,
                    )),
          );
        },
        onLongPress: () {},
      ),
    );
  }
}
