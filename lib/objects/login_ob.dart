class LoginOb {
  bool? success;
  String? message;
  Data? data;

  LoginOb({this.success, this.message, this.data});

  LoginOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  bool? verified;

  Data({this.token, this.verified});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['verified'] = verified;
    return data;
  }
}
