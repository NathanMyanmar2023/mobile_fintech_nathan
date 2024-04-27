class AuctionRuleOb {
  AuctionRuleOb({
      this.success, 
      this.message, 
      this.data,});

  AuctionRuleOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  bool? success;
  String? message;
  List<String>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}