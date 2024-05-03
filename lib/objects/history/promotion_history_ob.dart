class PromotionHistoryOb {
  PromotionHistoryOb({
    this.success,
    this.message,
    this.data,});

  PromotionHistoryOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;

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
class Data {
  Data({
    this.id,
    this.promotionName,
    this.percentage,
    this.cashAmt,
    this.investAmt,
    this.createAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    promotionName = json['promotion_name'];
    percentage = json['percentage'];
    cashAmt = json['cash_amount'];
    investAmt = json['invest_amount'];
    createAt = json['created_at'];
  }
  int? id;
  String? promotionName;
  String? percentage;
  String? cashAmt;
  String? investAmt;
  String? createAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['promotion_name'] = promotionName;
    map['percentage'] = percentage;
    map['cash_amount'] = cashAmt;
    map['invest_amount'] = investAmt;
    map['created_at'] = createAt;
    return map;
  }

}
