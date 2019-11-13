import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/model/TrashDTO.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_main.dart';

class SearchMain extends StatefulWidget {
  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  List<TrashDTO> trashItem;

  @override
  void initState() {
    trashItem = TrashType.trashItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('search_appbar'),
            style: TextAssets.mainRegular,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate('search_content1'),
                  style: TextAssets.mainBold,
                ),
                SizedBox(
                  height: 10,
                ),
//                TextField(
//                    decoration: InputDecoration(border: OutlineInputBorder())),
                Text(
                  AppLocalizations.of(context).translate('search_content2'),
                  style: TextAssets.subBold,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: trashItem.length,
                    itemBuilder: (context, index) {
                      var item = trashItem[index];
                      return ListTile(
                        title: Text(
                          item.trashName.toString(),
                          style: TextAssets.mainRegular,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RecycleDetail(
                                    itemID: item.trashNumber, mode: false)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
