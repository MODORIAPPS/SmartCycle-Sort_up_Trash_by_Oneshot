import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/blogger/v3.dart';
import 'package:smartcycle/Utils/HexColor.dart';
import 'package:smartcycle/Utils/SmartCycleServer.dart';
import 'package:smartcycle/Utils/TrashType.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/main.dart';
import 'package:smartcycle/model/RcleDetail.dart';
import 'package:smartcycle/ui/camera/camera_start.dart';

class RclDetailDefault extends StatelessWidget {
  final RclDetail rclDetail;
  final int trashNumber;

  RclDetailDefault({@required this.rclDetail, @required this.trashNumber});

  @override
  Widget build(BuildContext context) {
    var compositionWidgets = List<Widget>();
    var stepWidgets = List<Widget>();

    if (compositionWidgets.length == 0) {
      for (var composition in rclDetail.information.composition) {
        compositionWidgets
            .add(CompositionWidget(composition.part, composition.value));
      }
      int i = 1;
      for (var step in rclDetail.information.step) {
        stepWidgets.add(StepWidget(step.imageURL_step, step.contents, i));
        i++;
      }
    }
    return new WillPopScope(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                ),
                expandedHeight: 10.0,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.white,
                elevation: 10,
                iconTheme: IconThemeData(color: Colors.black87),
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("분리수거 하기", style: TextAssets.mainRegular),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _title(rclDetail, trashNumber),
                Container(
                  color: HexColor.fromHex('#84b1f5'),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        _element(rclDetail),
                        ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Column(
                              children: compositionWidgets,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                new ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Column(
                      children: stepWidgets,
                    )
                  ],
                ),
                _doYouKnow(rclDetail)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.of(context).pop(true);
          return false;
        });
  }
}

Widget CompositionWidget(String part, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          part,
          style: BlogTextStyles.compositionTitle,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            value,
            style: BlogTextStyles.compositionContent,
          ),
        )
      ],
    ),
  );
}

Widget StepWidget(String image, String step, int i) {
  var test_base = SmartCycleServer.test_base;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Text(
          "${i.toString()} 단계",
          style: BlogTextStyles.stepTitle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
//              imageUrl: base + image,
                    // %% ONLY FOR TEST %% getImage
                    imageUrl: SmartCycleServer.getServerImage(image),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(
                          Icons.error,
                          color: Colors.redAccent,
                        ),
//                alignment: Alignment(-.2, 0),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                )),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 20),
                    blurRadius: 20)
              ]),
        ),
      ),
      Padding(
        padding:
        const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 25),
        child: Text(
          step,
          style: BlogTextStyles.stepContent,
        ),
      )
    ],
  );
}

Widget _doYouKnow(RclDetail rclDetail) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              color: Colors.black38,
              thickness: 1,
            ),
            Text(
              "알고계셨나요?",
              style: TextAssets.mainBold,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      Container(
        color: HexColor.fromHex('#80ccbd'),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                Text(
                  rclDetail.name + "이(가) 자연에서 완전히 분해되기까지 걸리는 시간",
                  style: BlogTextStyles.stepContentW,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.timelapse,
                      size: 35,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        rclDetail.information.time_rot,
                        style: BlogTextStyles.compositionContent,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            )),
      ),
    ],
  );
}

Widget _title(RclDetail rclDetail, int trashNumber) {
  return Stack(
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: TrashType.trashTitleImages[trashNumber],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            alignment: Alignment(-.2, 0),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 170,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              rclDetail.name + " 을(를) 분리수거 하는 방법",
              style: BlogTextStyles.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Divider(
              color: Colors.black38,
              thickness: 1,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _element(RclDetail rclDetail) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 28,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            rclDetail.name + "을(를) 구성하는 요소",
            style: BlogTextStyles.compositionTitle,
          ),
        ],
      ),
    ],
  );
}
