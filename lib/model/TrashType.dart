import 'package:flutter/material.dart';

class TrashType{
  var trashes = ["페트병","종이팩","도자기","우산","의약품","스티르폼","케이블","부탄가스","유리병"];
  
  getTrashNumber(String trashType){
    print(trashes.indexOf(trashType)+1);
    return trashes.indexOf(trashType)+1;
  }

  getTrashName(int number){
    return trashes[number-1];
  }
}