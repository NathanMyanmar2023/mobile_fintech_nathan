
class BillAuctionOb {
  BillAuctionOb({
      this.success, 
      this.message, 
      this.data,});

  BillAuctionOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BillAuctionData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<BillAuctionData>? data;

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
class BillAuctionData {
  BillAuctionData({
    this.id,
    this.authUserHasStatus,
    this.title,
    this.amount,
    this.stardardLimit,
    this.existingUsers,
    this.leftUser,
    this.startMonth,
    this.description,});

  BillAuctionData.fromJson(dynamic json) {
    id = json['id'];
    authUserHasStatus = json['authUserHasStatus'];
    title = json['title'];
    amount = json['amount'];
    stardardLimit = json['stardardLimit'];
    existingUsers = json['existingUsers'];
    leftUser = json['leftUser'];
    startMonth = json['start_month'];
    description = json['description'];
  }
  int? id;
  int? authUserHasStatus;
  String? title;
  String? amount;
  int? stardardLimit;
  int? existingUsers;
  int? leftUser;
  String? startMonth;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['authUserHasStatus'] = authUserHasStatus;
    map['title'] = title;
    map['amount'] = amount;
    map['stardardLimit'] = stardardLimit;
    map['existingUsers'] = existingUsers;
    map['leftUser'] = leftUser;
    map['start_month'] = startMonth;
    map['description'] = description;
    return map;
  }

}