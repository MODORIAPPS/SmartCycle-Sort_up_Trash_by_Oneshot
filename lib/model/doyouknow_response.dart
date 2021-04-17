class DoYouKnows {
  final List<DoYouKnow> datas;

  DoYouKnows({required this.datas});

  factory DoYouKnows.fromJson(List<dynamic> parsedJson) {
    List<DoYouKnow> data;
    data = parsedJson.map((i) => DoYouKnow.fromJson(i)).toList();
    return new DoYouKnows(
      datas: data,
    );
  }
}

class DoYouKnow {
  List<Contents> contents;
  String published_date;
  String docNum;
  String title;
  int readTime;
  String preImage;

  DoYouKnow(
      {required this.contents,
      required this.published_date,
      required this.docNum,
      required this.title,
      required this.readTime,
      required this.preImage});

  factory DoYouKnow.fromJson(Map<dynamic, dynamic> json) {
    var contentList = json['contents'] as List;
    print(contentList.runtimeType); //returns List<dynamic>
    List<Contents> mCompoList =
        contentList.map((i) => Contents.fromJson(i)).toList();

    return DoYouKnow(
      contents: mCompoList,
      published_date: json['published_date'],
      docNum: json['docNum'],
      title: json['title'],
      readTime: json['readTime'],
      preImage: json['preImage'],
    );
  }
}

class Contents {
  String secTitle;
  String image;
  String secContent;

  Contents(
      {required this.secTitle, required this.image, required this.secContent});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return Contents(
        secTitle: json['secTitle'],
        image: json['image'],
        secContent: json['secContent']);
  }
}
