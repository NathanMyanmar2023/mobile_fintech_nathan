
class GiftBuyOb {
  GiftBuyOb({
      this.success, 
      this.message, 
      this.data,});

  GiftBuyOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? GiftBuyData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  GiftBuyData? data;

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

class GiftBuyData {
  GiftBuyData({
    this.userId,
    this.tag,
    this.playerId,
    this.serverId,
    this.giftCardAmount,
    this.unit,
    this.priceMmk,
    this.status,
    this.purchasedTime,
    this.completedTime,
    this.updatedAt,
    this.createdAt,
    this.id,});

  GiftBuyData.fromJson(dynamic json) {
    userId = json['user_id'];
    tag = json['tag'];
    playerId = json['player_id'];
    serverId = json['server_id'];
    giftCardAmount = json['gift_card_amount'];
    unit = json['unit'];
    priceMmk = json['price_mmk'];
    status = json['status'];
    purchasedTime = json['purchased_time'];
    completedTime = json['completed_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? userId;
  String? tag;
  String? playerId;
  String? serverId;
  int? giftCardAmount;
  String? unit;
  String? priceMmk;
  String? status;
  String? purchasedTime;
  dynamic completedTime;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['tag'] = tag;
    map['player_id'] = playerId;
    map['server_id'] = serverId;
    map['gift_card_amount'] = giftCardAmount;
    map['unit'] = unit;
    map['price_mmk'] = priceMmk;
    map['status'] = status;
    map['purchased_time'] = purchasedTime;
    map['completed_time'] = completedTime;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}