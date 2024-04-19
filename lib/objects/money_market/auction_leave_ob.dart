class AuctionLeaveOb {
  AuctionLeaveOb({
      this.success, 
      this.message});

  AuctionLeaveOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
  List<dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}