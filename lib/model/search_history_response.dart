class SearchHistorys {
  List<SearchHistory> historys;

  SearchHistorys({this.historys});

  factory SearchHistorys.fromJson(List<dynamic> parsedJson) {
    List<SearchHistory> history = new List<SearchHistory>();
    history = parsedJson.map((i) => SearchHistory.fromJson(i)).toList();

    return SearchHistorys(historys: history);
  }
}

class SearchHistory {
  // 쓰레기 반환 예시
  /*
  *
  *  "_id":"5d8e2ddcc8762806d819b625",
      "user_email":"test@gmail.com",
      "trash_id":"1",
      "date":"2019/8/27",
      "__v":0
  *
  * */
  String id;
  String user_email;
  String trash_id;
  String date;
  String imageURL;

  SearchHistory(
      {this.id, this.user_email, this.trash_id, this.date, this.imageURL});

  factory SearchHistory.fromJson(Map<dynamic, dynamic> parsedJson) {
    return SearchHistory(
        id: parsedJson['_id'],
        user_email: parsedJson['user_email'],
        date: parsedJson['date'],
        imageURL: parsedJson['imageURL'],
        trash_id: parsedJson['trash_id']);
  }
}

