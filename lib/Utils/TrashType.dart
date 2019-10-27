import 'package:flutter/material.dart';

class TrashType {
  var trashes = [
    "페트병",
    "종이팩",
    "내열유리",
    "우산",
    "건전지",
    "스티로폼",
    "휴지",
    "부탄가스 통",
    "유리병",
    "약통"
  ];
  var trashImages = ["assets/images/"];

  getTrashNumber(String trashType) {
    print(trashes.indexOf(trashType));
    return trashes.indexOf(trashType);
  }

  String getTrashName(int number) {
    print("return TrashName by TrashID" + trashes[number]);
    return trashes[number];
  }

  String getTrashImage(int number) {
    return 'assets/images/${number}_0.jpg';
  }
}
