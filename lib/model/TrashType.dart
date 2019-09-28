import 'package:flutter/material.dart';

class TrashType{
  var trashes = ["페트병","종이팩","도자기","우산","의약품","스티르폼","케이블","부탄가스","유리병"];
  var trashImages = ["assets/images/"];
  getTrashNumber(String trashType){
    print(trashes.indexOf(trashType));
    return trashes.indexOf(trashType);
  }

  getTrashName(int number){
    return trashes[number-1];
  }

  String getTrashImage(int number) {
    return 'assets/images/${number - 1}_0.jpg';
  }
}