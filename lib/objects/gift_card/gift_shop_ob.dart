
class GiftShopOb {
  GiftShopOb({
      this.success, 
      this.message, 
      this.data,});

  GiftShopOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GiftShopData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<GiftShopData>? data;

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

class GiftShopData {
  GiftShopData({
    this.id,
    this.shopName,
    this.stockLeft,
    this.shopLogoUrl,
    this.shopProfile,
    this.shopCover,
    this.isServer,
    this.tag,
    this.unit,
    this.open,});

  GiftShopData.fromJson(dynamic json) {
    id = json['id'];
    shopName = json['shop_name'];
    stockLeft = json['stock_left'];
    shopLogoUrl = json['shop_logo_url'];
    shopProfile = json['shop_profile'];
    shopCover = json['shop_cover'];
    isServer = json['is_server'];
    tag = json['tag'];
    unit = json['unit'];
    open = json['open'];
  }
  int? id;
  String? shopName;
  int? stockLeft;
  String? shopLogoUrl;
  String? shopProfile;
  String? shopCover;
  int? isServer;
  String? tag;
  String? unit;
  int? open;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['shop_name'] = shopName;
    map['stock_left'] = stockLeft;
    map['shop_logo_url'] = shopLogoUrl;
    map['shop_profile'] = shopProfile;
    map['shop_cover'] = shopCover;
    map['is_server'] = isServer;
    map['tag'] = tag;
    map['unit'] = unit;
    map['open'] = open;
    return map;
  }

}