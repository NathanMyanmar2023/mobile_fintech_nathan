class AuctionRoundMonthlyBidOb {
  AuctionRoundMonthlyBidOb({
      this.success, 
      this.message, 
      this.data,});

  AuctionRoundMonthlyBidOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? RoundMonthlyData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  RoundMonthlyData? data;

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

class RoundMonthlyData {
  RoundMonthlyData({
    this.bidAmountEndtime,
    this.bitStartime,
    this.bidUsersLists,
    this.lastBidUser,});

  RoundMonthlyData.fromJson(dynamic json) {
    bidAmountEndtime = json['bidAmountEndtime'];
    bitStartime = json['bitStartime'];
    if (json['bidUsersLists'] != null) {
      bidUsersLists = [];
      json['bidUsersLists'].forEach((v) {
        bidUsersLists?.add(BidUsersLists.fromJson(v));
      });
    }
    lastBidUser = json['lastBidUser'] != null ? LastBidUser.fromJson(json['lastBidUser']) : null;
  }
  dynamic bidAmountEndtime;
  String? bitStartime;
  List<BidUsersLists>? bidUsersLists;
  LastBidUser? lastBidUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bidAmountEndtime'] = bidAmountEndtime;
    map['bitStartime'] = bitStartime;
    if (bidUsersLists != null) {
      map['bidUsersLists'] = bidUsersLists?.map((v) => v.toJson()).toList();
    }
    if (lastBidUser != null) {
      map['lastBidUser'] = lastBidUser?.toJson();
    }
    return map;
  }
}
class BidUsersLists {
  BidUsersLists({
    this.id,
    this.auctionMonthId,
    this.userId,
    this.amount,
    this.username,});

  BidUsersLists.fromJson(dynamic json) {
    id = json['id'];
    auctionMonthId = json['auction_month_id'];
    userId = json['user_id'];
    amount = json['amount'];
    username = json['username'];
  }
  int? id;
  int? auctionMonthId;
  int? userId;
  String? amount;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['auction_month_id'] = auctionMonthId;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['username'] = username;
    return map;
  }

}

class LastBidUser {
  LastBidUser({
    this.id,
    this.auctionMonthId,
    this.userId,
    this.amount,
    this.username,});

  LastBidUser.fromJson(dynamic json) {
    id = json['id'];
    auctionMonthId = json['auction_month_id'];
    userId = json['user_id'];
    amount = json['amount'];
    username = json['username'];
  }
  int? id;
  int? auctionMonthId;
  int? userId;
  String? amount;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['auction_month_id'] = auctionMonthId;
    map['user_id'] = userId;
    map['amount'] = amount;
    map['username'] = username;
    return map;
  }

}