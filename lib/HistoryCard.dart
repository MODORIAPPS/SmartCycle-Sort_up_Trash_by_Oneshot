import 'package:flutter/material.dart';
import 'package:smartcycle/RecycleDetail.dart';
import 'package:smartcycle/model/TrashType.dart';

class HistoryCard extends StatelessWidget {
  final int id;
  final String itemName;
  final String date;
  final String itemImage;

  HistoryCard({this.id, this.itemImage, this.date, this.itemName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 6), blurRadius: 6)
              ]),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image.asset(itemImage),
              ),
              Text(itemName),
              Text(date)
            ],
          ),
        ),
        onTap: () {
          /// todo
          var number = TrashType().getTrashNumber(itemName);
          print(number);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RecycleDetail(numberCode: number)),
          );
        },
      ),
    );
  }
}
