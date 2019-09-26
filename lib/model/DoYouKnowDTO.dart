class DoYouKnows {
  final List<DoYouKnow> datas;

  DoYouKnows({this.datas});

  factory DoYouKnows.fromJson(List<dynamic> parsedJson) {
    List<DoYouKnow> data = new List<DoYouKnow>();
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
      {this.contents,
      this.published_date,
      this.docNum,
      this.title,
      this.readTime,
      this.preImage});

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

  Contents({this.secTitle, this.image, this.secContent});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return Contents(
        secTitle: json['secTitle'],
        image: json['image'],
        secContent: json['secContent']);
  }
}
