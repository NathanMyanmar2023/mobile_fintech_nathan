
class AuctionInsterestOb {
  AuctionInsterestOb({
      this.success, 
      this.message, 
      this.data,});

  AuctionInsterestOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AuctionInsterestData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  AuctionInsterestData? data;

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
class AuctionInsterestData {
  AuctionInsterestData({
    this.totalUserLists,
    this.resultsData,
    this.planMonth,
    this.termCodition,
    this.isAgree,
    this.auctionPlanStartIn,
    this.auctionPlanExpireIn,
    this.planUserStartIn,
    this.planUserExpireIn,
    this.paymentHistory,});

  AuctionInsterestData.fromJson(dynamic json) {
    totalUserLists = json['totalUserLists'];
    resultsData = json['resultsData'];
    planMonth = json['planMonth'];
    termCodition = json['termCodition'] != null ? json['termCodition'].cast<String>() : [];
    isAgree = json['isAgree'];
    auctionPlanStartIn = json['auctionPlanStartIn'];
    auctionPlanExpireIn = json['auctionPlanExpireIn'];
    planUserStartIn = json['planUserStartIn'];
    planUserExpireIn = json['planUserExpireIn'];
    paymentHistory = json['paymentHistory'];
  }
  int? totalUserLists;
  int? resultsData;
  dynamic planMonth;
  List<String>? termCodition;
  String? isAgree;
  String? auctionPlanStartIn;
  String? auctionPlanExpireIn;
  String? planUserStartIn;
  int? planUserExpireIn;
  int? paymentHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalUserLists'] = totalUserLists;
    map['resultsData'] = resultsData;
    map['planMonth'] = planMonth;
    map['termCodition'] = termCodition;
    map['isAgree'] = isAgree;
    map['auctionPlanStartIn'] = auctionPlanStartIn;
    map['auctionPlanExpireIn'] = auctionPlanExpireIn;
    map['planUserStartIn'] = planUserStartIn;
    map['planUserExpireIn'] = planUserExpireIn;
    map['paymentHistory'] = paymentHistory;
    return map;
  }

}