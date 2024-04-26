import 'package:nathan_app/objects/money_market/user_info.dart';

class AuctionRoundOb {
  AuctionRoundOb({
      this.success, 
      this.message, 
      this.data,});

  AuctionRoundOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoundData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<RoundData>? data;

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

class RoundData {
  RoundData({
    this.id,
    this.roundNumber,
    this.userId,
    this.userinfo,
    this.auctionId,
    this.baseAmount,
    this.realAmount,
    this.monthPosition,
    this.month,
    this.monthDone,
    this.isDone,
    this.currentTime,
    this.createdAt,});

  RoundData.fromJson(dynamic json) {
    id = json['id'];
    roundNumber = json['roundNumber'];
    userId = json['user_id'];
    userinfo = json['userinfo'] != null ? Userinfo.fromJson(json['userinfo']) : null;
    auctionId = json['auction_id'];
    baseAmount = json['base_amount'];
    realAmount = json['real_amount'];
    monthPosition = json['month_position'];
    month = json['month'];
    monthDone = json['monthDone'];
    isDone = json['is_done'];
    currentTime = json['currentTime'];
    createdAt = json['created_at'];
  }
  int? id;
  String? roundNumber;
  int? userId;
  Userinfo? userinfo;
  int? auctionId;
  int? baseAmount;
  int? realAmount;
  int? monthPosition;
  String? month;
  String? monthDone;
  int? isDone;
  String? currentTime;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roundNumber'] = roundNumber;
    map['user_id'] = userId;
    if (userinfo != null) {
      map['userinfo'] = userinfo?.toJson();
    }
    map['auction_id'] = auctionId;
    map['base_amount'] = baseAmount;
    map['real_amount'] = realAmount;
    map['month_position'] = monthPosition;
    map['month'] = month;
    map['monthDone'] = monthDone;
    map['is_done'] = isDone;
    map['currentTime'] = currentTime;
    map['created_at'] = createdAt;
    return map;
  }

}