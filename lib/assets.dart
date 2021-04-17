import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/HexColor.dart';

class ImageAssets {
  static const String white_logo = "assets/images/SmartCycle_logo_white.png";
  static const String blue_logo = "assets/images/SmartCycle_logo_skyblue.png";
  static const String sirenImage = "assets/images/siren.png";
}

class TextAssets {
  static const TextStyle mainBold = TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mainRegular = TextStyle(
    color: Colors.black87,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle subBold = TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle dialogText = TextStyle(
    color: Colors.blue,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mainBoldW = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mainRegularW = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.2);

  static const TextStyle mainRegularR = TextStyle(
      color: Colors.redAccent,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.2);
  static const TextStyle mainLightW = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle mainLight = TextStyle(
    color: Colors.black87,
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle mainBlackW = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mainBlack = TextStyle(
    color: Colors.black87,
    fontSize: 33,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle errorBold = TextStyle(
    color: Colors.redAccent,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle insideContents = TextStyle(
    color: Colors.black87,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle infoBold = TextStyle(
    color: Colors.black87,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle cardBlue = TextStyle(
    color: Colors.blueAccent,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

class BlogTextStyles {
  static const TextStyle title = TextStyle(
    color: Colors.black87,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle stepTitle = TextStyle(
    color: Colors.black87,
    fontSize: 25,
    backgroundColor: Colors.amberAccent,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle stepContent = TextStyle(
    color: Colors.black87,
    fontSize: 19,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle stepContentW =
  TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle compositionTitle = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle compositionContent = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}

final TextStyle header1 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
final TextStyle normal =
    TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black);
final TextStyle header2 =
    TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black);
