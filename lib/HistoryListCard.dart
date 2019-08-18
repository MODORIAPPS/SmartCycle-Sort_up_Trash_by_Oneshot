import 'package:flutter/material.dart';

class HistoryListCard extends StatelessWidget {
  final int id;
  final String itemName;
  final String date;
  final String itemImage;

  HistoryListCard({this.id, this.itemImage, this.date, this.itemName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(itemImage),
      ),
      title: Text(itemName),
      subtitle: Text(date),
      trailing: Icon(Icons.search),
      onTap: () {
        print('camel');
      },
      enabled: false,
    );
  }
}
