

class ShoppingNetworkOb {
  ShoppingNetworkOb({
      this.success, 
      this.message, 
      this.data,});

  ShoppingNetworkOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ShoppingNetworkData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<ShoppingNetworkData>? data;

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

class ShoppingNetworkData {
  ShoppingNetworkData({
    this.id,
    this.totalAmount,
    this.currency,
    this.fromUser,
    this.date,});

  ShoppingNetworkData.fromJson(dynamic json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    currency = json['currency'];
    fromUser = json['from_user'];
    date = json['date'];
  }
  int? id;
  String? totalAmount;
  String? currency;
  String? fromUser;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total_amount'] = totalAmount;
    map['currency'] = currency;
    map['from_user'] = fromUser;
    map['date'] = date;
    return map;
  }

}