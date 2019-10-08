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

  SearchHistory({this.id, this.user_email, this.trash_id, this.date});

  factory SearchHistory.fromJson(Map<dynamic, dynamic> parsedJson) {
    return SearchHistory(
        id: parsedJson['_id'],
        user_email: parsedJson['user_email'],
        date: parsedJson['date'],
        trash_id: parsedJson['trash_id']);
  }
}

//// 임시로 모든 쓰레기 항목의 id를 1로  처리함
//var searchItems = [
//  SearchHistory(id: 1, itemName: "종이팩", date: "2019/06/20", itemImage: "assets/images/sampleimage01.png"),
//  SearchHistory(id: 1, itemName: "신문지", date: "2019/06/19", itemImage: "assets/images/sampleimage02.png"),
//  SearchHistory(id: 1, itemName: "종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//  SearchHistory(id: 1, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
//];
