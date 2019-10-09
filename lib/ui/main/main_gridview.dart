import 'package:flutter/material.dart';
import 'package:smartcycle/HistoryCard.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:smartcycle/styles/Styles.dart';

class HistoryGridView extends StatefulWidget {
  final bool isUserAvail;
  final String userEmail;

  HistoryGridView({Key key, this.isUserAvail, this.userEmail})
      : super(key: key);

  @override
  _HistoryGridViewState createState() => _HistoryGridViewState();
}

class _HistoryGridViewState extends State<HistoryGridView> {
  bool isDataReady = false;
  SearchHistorys _historys; // getFrom SmartCycle internal server.
  SmartCycleServer smartCycleServer = new SmartCycleServer();

  @override
  Widget build(BuildContext context) {
    if (widget.userEmail != null && _historys == null) {
      // %% ONLY FOR TEST %% getUserHistoryTest
      smartCycleServer.getUserHistoryTest(widget.userEmail).then((historyData) {
        _historys = historyData;

        setState(() {});
      });

//      smartCycleServer.getUserHistory(widget.userEmail).then((historyData) {
//        _historys = historyData;
//        setState(() {});
//      });

    }

    return widget.isUserAvail
        ? (_historys != null)
            ? _historyGridView(context, _historys)
        : Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
              )
        : Center(
            child: Text("개인화된 기능을 사용하려면 로그인 하세요"),
          );
  }
}

Widget _historyGridView(BuildContext context, SearchHistorys historys) {
  return (historys.historys.length == 0)
      ? Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Icon(Icons.info_outline),
              SizedBox(
                height: 8,
              ),
              Text(
                "검색한 정보가 없어요.",
                style: cardRegular,
              ),
            ],
          ),
        )
      : Expanded(
          child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(historys.historys.length, (index) {
              var history = historys.historys[index];
              return Center(
                child: HistoryCard(
                    id: int.parse(history.trash_id),
                    itemName:
                        TrashType().getTrashName(int.parse(history.trash_id)),
                    itemImage:
                        TrashType().getTrashImage(int.parse(history.trash_id)),
                    date: history.date,
                    itemIndex: index),
              );
            }),
          ),
        ));
}
