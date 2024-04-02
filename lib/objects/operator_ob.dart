
class OperatorOb {
  OperatorOb({
      this.success, 
      this.message, 
      this.data,});

  OperatorOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OperatorData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<OperatorData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OperatorData {
  OperatorData({
    this.id,
    this.country,
    this.name,
    this.logo,});

  OperatorData.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'];
    name = json['name'];
    logo = json['logo'];
  }
  int? id;
  String? country;
  String? name;
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country'] = country;
    map['name'] = name;
    map['logo'] = logo;
    return map;
  }

}