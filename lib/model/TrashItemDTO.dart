class TrashItemDTO {
  List<TrashItem> trashItems;

  TrashItemDTO({this.trashItems});

  factory TrashItemDTO.fromJson(List<TrashItem> parsedJson) {
    return TrashItemDTO(
        trashItems: parsedJson);
  }
}

class TrashItem {
  Information information;

  // original key was "_id"
  String idunder;
  String published_date;
  int id;
  String name;
  String imageUrl;
  int time;

  // original key was "__v"
  int vDoubleUnder;

  TrashItem(
      {this.information,
      this.idunder,
      this.published_date,
      this.id,
      this.name,
      this.imageUrl,
      this.time});

  factory TrashItem.fromJson(Map<String, dynamic> parsedJson) {
    return TrashItem(
        information: Information.fromJson(parsedJson['information']),
        idunder: parsedJson['_id'],
        published_date: parsedJson['published_date'],
        id: parsedJson['id'],
        name: parsedJson['name'],
        imageUrl: parsedJson['imageUrl'],
        time: parsedJson['time']);
  }
}

class Information {
  List<Composition> composition;
  List<Step> step;
  String compo_number;
  String step_number;

  Information(
      {this.composition, this.step, this.compo_number, this.step_number});

  factory Information.fromJson(Map<String, dynamic> parsedJson) {
    // var compositFromJson = parsedJson['composition'];
    List<Composition> compositList =
        new List<Composition>.from(parsedJson['composition']);

    // var stepFromJson = parsedJson['stepFromJson'];
    List<Step> stepList = new List<Step>.from(parsedJson['stepFromJson']);

    // var compositList = parsedJson['composition'] as List;

    return Information(
        composition: compositList,
        step: stepList,
        compo_number: parsedJson['compo_number'],
        step_number: parsedJson['step_number']);
  }
}

class Composition {
  String part;
  String value;

  Composition({this.part, this.value});

  factory Composition.fromJson(Map<String, dynamic> parsedJson) {
    return Composition(part: parsedJson['part'], value: parsedJson['value']);
  }
}

class Step {
  int number;
  String contents;

  Step({this.number, this.contents});

  factory Step.fromJson(Map<String, dynamic> parsedJson) {
    return Step(number: parsedJson['number'], contents: parsedJson['contents']);
  }
}
