class GoogleProfileError {
  Error error;

  GoogleProfileError({this.error});

  factory GoogleProfileError.fromJson(Map<String, dynamic> json) {
    return GoogleProfileError(
      error: json['error'] != null ? Error.fromJson(json['error']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Error {
  int code;
  List<ErrorX> errors;
  String message;

  Error({this.code, this.errors, this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json['code'],
      errors: json['errors'] != null
          ? (json['errors'] as List).map((i) => ErrorX.fromJson(i)).toList()
          : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErrorX {
  String domain;
  String location;
  String locationType;
  String message;
  String reason;

  ErrorX(
      {this.domain,
      this.location,
      this.locationType,
      this.message,
      this.reason});

  factory ErrorX.fromJson(Map<String, dynamic> json) {
    return ErrorX(
      domain: json['domain'],
      location: json['location'],
      locationType: json['locationType'],
      message: json['message'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['location'] = this.location;
    data['locationType'] = this.locationType;
    data['message'] = this.message;
    data['reason'] = this.reason;
    return data;
  }
}
