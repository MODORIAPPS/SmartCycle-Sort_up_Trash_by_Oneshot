class GoogleAuthDTO {
  String accessToken;
  String idToken;

  GoogleAuthDTO({this.accessToken, this.idToken});

  factory GoogleAuthDTO.fromJson(Map<String, dynamic> json) {
    return GoogleAuthDTO(
      accessToken: json['accessToken'],
      idToken: json['idToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['idToken'] = this.idToken;
    return data;
  }
}
