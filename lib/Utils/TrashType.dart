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
    "약통",
    "기타"
  ];
  static var trashTitleImages = [
    "https://source.unsplash.com/4xmgrNUbyNA/1000x400",
    "https://source.unsplash.com/Jjgci6LHWCw/1100x400",
    "https://source.unsplash.com/sG-PR0BNwb4/900x500",
    "https://source.unsplash.com/x1Qw2gCPMUU/1200x500",
    "https://source.unsplash.com/NIDPm-ltVbA/1000x600",
    "https://source.unsplash.com/1MBNvueFZBk/1000x800",
    "https://source.unsplash.com/RmByg5kFfQg/1100x700",
    "https://source.unsplash.com/K4Xa-yC8RDo/900x900",
    "https://source.unsplash.com/RuudPEDUM3w/1000x400",
    "https://source.unsplash.com/nss2eRzQwgw/1000x500",
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
