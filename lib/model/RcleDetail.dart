import 'package:smartcycle/model/TrashItemDTO.dart';

class RclDetails {
  final List<RclDetail> rcls;

  RclDetails({this.rcls});

  factory RclDetails.fromJson(List<dynamic> parsedJson) {
    List<RclDetail> rcls = new List<RclDetail>();
    rcls = parsedJson.map((i) => RclDetail.fromJson(i)).toList();
    return new RclDetails(
      rcls: rcls,
    );
  }
}

class RclDetail {
  // 쓰레기 분리수거 자세한 정보

  Information information;

  String published_date;
  String id;
  String name;
  String imageURL;

  // __v
  int v;

  RclDetail({this.information,
    this.published_date,
    this.id,
    this.name,
    this.imageURL,
    this.v});

  factory RclDetail.fromJson(Map<dynamic, dynamic> json) {
    return RclDetail(
      information: Information.fromJson(json['information']),
      published_date: json['published_date'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
//      imageURL: json['imageURl'] as String,
      imageURL: (json['imageURl'] == null) ? "s" : json['imageURl'] as String,
      v: json['__v'] as int,
    );
  }
}

class Information {
  List<Composition> composition;
  List<Step> step;
  int compo_number;
  int step_number;
  String time_rot;

  Information({this.compo_number,
    this.step_number,
    this.composition,
    this.step,
    this.time_rot});

  factory Information.fromJson(Map<dynamic, dynamic> json) {
    var compoList = json['composition'] as List;
    print(compoList.runtimeType); //returns List<dynamic>
    List<Composition> mCompoList =
    compoList.map((i) => Composition.fromJson(i)).toList();

    var stepList = json['step'] as List;
    print(stepList.runtimeType); //returns List<dynamic>
    List<Step> mStepList = stepList.map((i) => Step.fromJson(i)).toList();

    return Information(
        composition: mCompoList,
        step: mStepList,
        compo_number: json['compo_number'],
        step_number: json['step_number'],
        time_rot: json['time_rot']);
  }
}

class Composition {
  String part;
  String value;

  Composition({this.part, this.value});

  factory Composition.fromJson(Map<String, dynamic> json) {
    return Composition(part: json['part'], value: json['value']);
  }
}

class Step {
  String contents;
  String imageURL_step;

  Step({this.contents, this.imageURL_step});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
//        imageURL_step: json['imageURL_step'],
        imageURL_step: (json['imageURL_step'] == null ) ? "s" : json['imageURL_step'] as String,
        contents: json['contents']);
  }
}
