class SearchHistory{
  int id;
  String itemName;
  String date;
  String itemImage;
  SearchHistory({ this.id, this.itemName, this.date, this.itemImage});
}

var searchItems = [
  SearchHistory(id: 1, itemName: "우유팩", date: "2019/06/20", itemImage: "assets/images/sampleimage01.png"),
  SearchHistory(id: 2, itemName: "신문지", date: "2019/06/19", itemImage: "assets/images/sampleimage02.png"),
  SearchHistory(id: 3, itemName: "색종이", date: "2019/06/15", itemImage: "assets/images/sampleimage03.jpg"),
];