class GoogleProfileDTO {
  String displayName;
  List<Email> emails;
  String etag;
  String id;
  Image image;
  String kind;
  String language;
  Name name;

  GoogleProfileDTO(
      {this.displayName,
      this.emails,
      this.etag,
      this.id,
      this.image,
      this.kind,
      this.language,
      this.name});

  factory GoogleProfileDTO.fromJson(Map<dynamic, dynamic> json) {
    var emailList = json['emails'] as List;
    List<Email> emails = emailList.map((i) => Email.fromJson((i))).toList();

    return GoogleProfileDTO(
      displayName: json['displayName'],
      emails: emails,
      etag: json['etag'],
      id: json['id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      kind: json['kind'],
      language: json['language'],
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['etag'] = this.etag;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['language'] = this.language;
    if (this.emails != null) {
      data['emails'] = this.emails.map((v) => v.toJson()).toList();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    return data;
  }
}

class Image {
  bool isDefault;
  String url;

  Image({this.isDefault, this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      isDefault: json['isDefault'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDefault'] = this.isDefault;
    data['url'] = this.url;
    return data;
  }
}

class Email {
  String type;
  String value;

  Email({this.type, this.value});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class Name {
  String familyName;
  String givenName;

  Name({this.familyName, this.givenName});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      familyName: json['familyName'],
      givenName: json['givenName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyName'] = this.familyName;
    data['givenName'] = this.givenName;
    return data;
  }
}
