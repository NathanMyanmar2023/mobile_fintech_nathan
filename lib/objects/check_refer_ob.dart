class CheckReferOb {
  bool? success;
  String? message;
  Data? data;

  CheckReferOb({this.success, this.message, this.data});

  CheckReferOb.fromJson(Map<String, dynamic> json) {
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
  int? parentId;
  int? countryId;
  String? countryName;

  Data({this.parentId, this.countryId, this.countryName});

  Data.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    return data;
  }
}
