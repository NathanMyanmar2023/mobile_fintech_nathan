

class InvestmentPlanOb {
  InvestmentPlanOb({
    this.success,
    this.message,
    this.data,});

  InvestmentPlanOb.fromJson(dynamic json) {
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
    this.name,
    this.duration,
    this.profit,
    this.isAllow,
    this.description,
    this.promotion,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    profit = json['profit'];
    isAllow = json['is_allow'];
    description = json['description'];
    promotion = json['promotion'] != null ? Promotion.fromJson(json['promotion']) : null;
  }
  int? id;
  String? name;
  String? duration;
  int? profit;
  int? isAllow;
  dynamic description;
  Promotion? promotion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['duration'] = duration;
    map['profit'] = profit;
    map['is_allow'] = isAllow;
    map['description'] = description;
    if (promotion != null) {
      map['promotion'] = promotion?.toJson();
    }
    return map;
  }

}

class Promotion {
  Promotion({
    this.id,
    this.isAvailable,
    this.name,
    this.amount,
    this.startDate,
    this.endDate,});

  Promotion.fromJson(dynamic json) {
    id = json['id'];
    isAvailable = json['is_available'];
    name = json['name'];
    amount = json['amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
  int? id;
  bool? isAvailable;
  String? name;
  String? amount;
  String? startDate;
  String? endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['is_available'] = isAvailable;
    map['name'] = name;
    map['amount'] = amount;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }

}
