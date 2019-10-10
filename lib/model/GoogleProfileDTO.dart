class GoogleProfileDTO {
  String displayName;
  List<Email> emails;
  String id;
  userImage image;
  String language;
  Name name;

  GoogleProfileDTO(
      {this.displayName,
      this.emails,
      this.id,
      this.image,
      this.language,
      this.name});

  factory GoogleProfileDTO.fromJson(Map<dynamic, dynamic> json) {
    var emailList = json['emails'] as List;
    List<Email> mEmailList = emailList.map((i) => Email.fromJson(i)).toList();

    return GoogleProfileDTO(
      displayName: json['displayName'],
      emails: mEmailList,
      id: json['id'],
      image: userImage.fromJson(json['image']),
      language: json['language'],
      name: Name.fromJson(json['name']),
    );
  }
}

class userImage {
  bool isDefault;
  String url;

  userImage({this.isDefault, this.url});

  factory userImage.fromJson(Map<String, dynamic> json) {
    return userImage(
      isDefault: json['isDefault'],
      url: json['url'] as String,
    );
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
}
