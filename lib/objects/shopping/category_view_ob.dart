class CategoryViewOb {
  CategoryViewOb({
    this.success,
    this.message,
    this.data,
  });

  CategoryViewOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryViewData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<CategoryViewData>? data;

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
class CategoryViewData {
  CategoryViewData({
    this.id,
    this.name,
    this.photo,});

  CategoryViewData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
  int? id;
  String? name;
  dynamic photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['photo'] = photo;
    return map;
  }
}