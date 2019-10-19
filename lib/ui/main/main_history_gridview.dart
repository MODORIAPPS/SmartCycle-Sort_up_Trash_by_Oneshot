import 'package:flutter/material.dart';
import 'package:smartcycle/SCircularProgress.dart';
import 'package:smartcycle/ui/main/main_history_card.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/model/SearchHistory.dart';
import 'package:smartcycle/model/TrashType.dart';
import 'package:smartcycle/styles/Styles.dart';

class HistoryGridView extends StatefulWidget {
  final bool isSignIn;
  final String userEmail;

  HistoryGridView({Key key, this.isSignIn, this.userEmail}) : super(key: key);

  @override
  _HistoryGridViewState createState() => _HistoryGridViewState();
}

class _HistoryGridViewState extends State<HistoryGridView> {
  Future<SearchHistorys> _getUserHistory;
  bool isDataReady = false;
  SmartCycleServer smartCycleServer = new SmartCycleServer();

  @override
  void initState() {
    super.initState();

    // %% ONLY FOR TEST %% getUserHistoryTest
    _getUserHistory = smartCycleServer.getUserHistoryTest(widget.userEmail);
    //_getUserHistory = smartCycleServer.getUserHistory(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSignIn
        ? FutureBuilder<SearchHistorys>(
      future: _getUserHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data != null
              ? (snapshot.data.historys.length != 0)
              ? _historyGridView(context, snapshot.data)
              : Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text("검색하신 쓰레기가 없어요.")
            ],
          )
              : Text("서버에 접근할 수 없었습니다.");
        } else {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              SCircularProgress()
            ],
          );
        }
      },
    )
        : Text("기록을 사용하시려면 먼저 로그인해주세요.");
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
