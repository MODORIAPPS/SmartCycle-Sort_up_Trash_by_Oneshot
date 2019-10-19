import 'package:flutter/material.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/TrashType.dart';
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
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
              ]),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(itemImage),
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
          /// todo
          var number = TrashType().getTrashNumber(itemName);

          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RecycleDetail(itemID: number)),
          );
        },
      ),
    );
  }
}
