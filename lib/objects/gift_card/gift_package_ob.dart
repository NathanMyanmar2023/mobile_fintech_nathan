
class GiftPackageOb {
  GiftPackageOb({
      this.success, 
      this.message, 
      this.data,});

  GiftPackageOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? GiftPkgData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  GiftPkgData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
class GiftPkgData {
  GiftPkgData({
    this.packages,});

  GiftPkgData.fromJson(dynamic json) {
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages?.add(Packages.fromJson(v));
      });
    }
  }
  List<Packages>? packages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (packages != null) {
      map['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Packages {
  Packages({
    this.id,
    this.name,
    this.tag,
    this.giftCardAmount,
    this.unit,
    this.priceMmk,
    this.createdAt,
    this.updatedAt,});

  Packages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    giftCardAmount = json['gift_card_amount'];
    unit = json['unit'];
    priceMmk = json['price_mmk'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? tag;
  int? giftCardAmount;
  String? unit;
  String? priceMmk;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['tag'] = tag;
    map['gift_card_amount'] = giftCardAmount;
    map['unit'] = unit;
    map['price_mmk'] = priceMmk;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}