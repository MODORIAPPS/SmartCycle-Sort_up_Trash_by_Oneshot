class GoogleAccountDTO {
  String displayName;
  String email;
  int id;
  String photoUrl;

  GoogleAccountDTO({this.displayName, this.email, this.id, this.photoUrl});

  factory GoogleAccountDTO.fromJson(Map<String, dynamic> json) {
    return GoogleAccountDTO(
      displayName: json['displayName'],
      email: json['email'],
      id: json['id'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['id'] = this.id;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
