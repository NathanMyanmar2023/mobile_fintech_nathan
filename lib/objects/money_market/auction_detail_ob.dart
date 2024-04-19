
class AuctionDetailOb {
  AuctionDetailOb({
      this.success, 
      this.message, 
      this.data,});

  AuctionDetailOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

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
class Data {
  Data({
    this.id,
    this.authUserHasStatus,
    this.title,
    this.amount,
    this.stardardLimit,
    this.existingUsers,
    this.leftUser,
    this.description,
    this.billAuctionUserLists,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    authUserHasStatus = json['authUserHasStatus'];
    title = json['title'];
    amount = json['amount'];
    stardardLimit = json['stardardLimit'];
    existingUsers = json['existingUsers'];
    leftUser = json['leftUser'];
    description = json['description'];
    if (json['billAuctionUserLists'] != null) {
      billAuctionUserLists = [];
      json['billAuctionUserLists'].forEach((v) {
        billAuctionUserLists?.add(BillAuctionUserLists.fromJson(v));
      });
    }
  }
  int? id;
  int? authUserHasStatus;
  String? title;
  String? amount;
  int? stardardLimit;
  int? existingUsers;
  int? leftUser;
  String? description;
  List<BillAuctionUserLists>? billAuctionUserLists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['authUserHasStatus'] = authUserHasStatus;
    map['title'] = title;
    map['amount'] = amount;
    map['stardardLimit'] = stardardLimit;
    map['existingUsers'] = existingUsers;
    map['leftUser'] = leftUser;
    map['description'] = description;
    if (billAuctionUserLists != null) {
      map['billAuctionUserLists'] = billAuctionUserLists?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BillAuctionUserLists {
  BillAuctionUserLists({
    this.auctionId,
    this.userId,
    this.deleteStatus,
    this.name,
    this.username,
    this.email,
    this.userProfile,
    this.parentId,});

  BillAuctionUserLists.fromJson(dynamic json) {
    auctionId = json['auction_id'];
    userId = json['user_id'];
    deleteStatus = json['delete_status'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    userProfile = json['user_profile'];
    parentId = json['parent_id'];
  }
  int? auctionId;
  int? userId;
  int? deleteStatus;
  String? name;
  String? username;
  String? email;
  String? userProfile;
  int? parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auction_id'] = auctionId;
    map['user_id'] = userId;
    map['delete_status'] = deleteStatus;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['user_profile'] = userProfile;
    map['parent_id'] = parentId;
    return map;
  }

}