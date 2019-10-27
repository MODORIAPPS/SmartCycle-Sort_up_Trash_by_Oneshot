import 'package:flutter/material.dart';

class TrashType {
  var trashes = [
    "페트병",
    "종이팩",
    "도자기",
    "우산",
    "의약품",
    "스티르폼",
    "케이블",
    "부탄가스",
    "유리병"
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
