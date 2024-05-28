
class GiftCardHistoryOb {
  GiftCardHistoryOb({
      this.success, 
      this.message, 
      this.data,});

  GiftCardHistoryOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? GiftHistoryData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  GiftHistoryData? data;

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
class GiftHistoryData {
  GiftHistoryData({
    this.transactions,});

  GiftHistoryData.fromJson(dynamic json) {
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  List<Transactions>? transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Transactions {
  Transactions({
    this.id,
    this.userId,
    this.tag,
    this.playerId,
    this.serverId,
    this.giftCardAmount,
    this.unit,
    this.priceMmk,
    this.status,
    this.remarks,
    this.purchasedTime,
    this.completedTime,
    this.createdAt,
    this.updatedAt,});

  Transactions.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    tag = json['tag'];
    playerId = json['player_id'];
    serverId = json['server_id'];
    giftCardAmount = json['gift_card_amount'];
    unit = json['unit'];
    priceMmk = json['price_mmk'];
    status = json['status'];
    remarks = json['remarks'];
    purchasedTime = json['purchased_time'];
    completedTime = json['completed_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? tag;
  String? playerId;
  String? serverId;
  int? giftCardAmount;
  String? unit;
  String? priceMmk;
  String? status;
  dynamic remarks;
  String? purchasedTime;
  dynamic completedTime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['tag'] = tag;
    map['player_id'] = playerId;
    map['server_id'] = serverId;
    map['gift_card_amount'] = giftCardAmount;
    map['unit'] = unit;
    map['price_mmk'] = priceMmk;
    map['status'] = status;
    map['remarks'] = remarks;
    map['purchased_time'] = purchasedTime;
    map['completed_time'] = completedTime;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}