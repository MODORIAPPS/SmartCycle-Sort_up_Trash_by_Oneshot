import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smartcycle/Utils/SCircularProgress.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_default.dart';
import 'package:smartcycle/ui/rcldetail/rcldetail_pageview.dart';
import '../../model/RcleDetail.dart';

class RecycleDetail extends StatefulWidget {
  final String keyword;
  final int itemID;

  RecycleDetail({this.keyword, this.itemID});

  @override
  _RecycleDetailState createState() => _RecycleDetailState(itemId: itemID);
}

class _RecycleDetailState extends State<RecycleDetail> {
  PageController controller = PageController();
  var currentPage = 0;
  Future<RclDetail> _getRclDetailData;
  int itemId;
  List<Widget> pages = new List();

  _RecycleDetailState({this.itemId});

  @override
  void initState() {
    // %% ONLY FOR TEST %% getRclData
    super.initState();
//    _getRclDetailData = SmartCycleServer().getRclDetailTest(2);

    _getRclDetailData = SmartCycleServer()
        .getRclDetail(itemId)
        .timeout(const Duration(seconds: 5));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    controller.addListener(() {
//      controller.jumpToPage(currentPage);
//
//      setState(() {
//      });
//    });

    return Scaffold(
      body: FutureBuilder<RclDetail>(
        future: _getRclDetailData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text("서버에 접근할 수 없었습니다."),
                    Text("이 문제가 계속해서 발생하면 문의해주세요."),
                    RaisedButton(
                      child: Text("재시도"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _getRclDetailData = SmartCycleServer()
                            .getRclDetail(2)
                            .timeout(const Duration(seconds: 5));
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            } else {
              pages.add(RclDetailDefault(
                rclDetail: snapshot.data,
                trashNumber: widget.itemID,
              ));
              pages.add(RclDetailPageView(rclDetail: snapshot.data));
              return PageView(
                controller: controller,
                scrollDirection: Axis.vertical,
                pageSnapping: false,
                children: <Widget>[
                  RclDetailDefault(
                    rclDetail: snapshot.data,
                    trashNumber: widget.itemID,
                  ),
//                  RclDetailPageView(
//                    rclDetail: snapshot.data,
//                  )
                ],
              );
            }
          } else {
            return SCircularProgress();
          }
        },
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.refresh,
//          color: Colors.black87,
//        ),
//        backgroundColor: Colors.white,
//        onPressed: () {
//          print(controller.page.toString());
//          if (controller.page == 0.0) {
//            controller.jumpToPage(2);
//          } else {
//            controller.jumpToPage(0);
//          }
////          controller.jumpTo(2.0);
////          controller.jumpToPage(2);
//        },
//      ),
    );
  }
}
