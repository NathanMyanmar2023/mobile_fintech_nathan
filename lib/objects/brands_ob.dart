class BrandsOb {
  BrandsOb({
      this.success,
      this.message,
      this.data,});

  BrandsOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BrandData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<BrandData>? data;

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
class BrandData {
  BrandData({
      this.id,
      this.name,
      this.photo,});

  BrandData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
  int? id;
  String? name;
  String? photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['photo'] = photo;
    return map;
  }

}