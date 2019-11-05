import 'package:flutter/material.dart';
import 'package:smartcycle/assets.dart';

class PolicyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 1,
        title: Text(
          "이미지 정책 자세히보기",
          style: TextAssets.mainRegular,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(ImageAssets.sirenImage),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "더 나은 서비스를 위해\n이미지 제출.",
                  style: TextAssets.mainBlack,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "저희 서비스는 인공지능 기술을 사용합니다. "
                  "인공지능 기술을 통해 어떤 쓰레기인지 자동으로 판별하고 "
                  "분리수거를 알려주죠. ",
                  style: TextAssets.mainRegular,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "인공지능에게 있어서 가장 중요한 것은 많은 데이터를 통한 학습입니다."
                  "\n사용자 여러분의 도움이 절실히 필요합니다. 저희 인공지능이 잘못 인식했다면 "
                  "피드백을 주시고 사진 전송을 허용해 주시면 정말 큰 도움이 됩니다. ",
                  style: TextAssets.mainRegular,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "저희는 여러분이 보내주신 소중한 사진들을 학습 용도로만 사용할 것을 맹세합니다.",
                  style: TextAssets.mainRegular,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
