class PresignOb {
  bool? success;
  String? message;
  Data? data;

  PresignOb({this.success, this.message, this.data});

  PresignOb.fromJson(Map<String, dynamic> json) {
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
  String? presign;

  Data({this.presign});

  Data.fromJson(Map<String, dynamic> json) {
    presign = json['presign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['presign'] = presign;
    return data;
  }
}
