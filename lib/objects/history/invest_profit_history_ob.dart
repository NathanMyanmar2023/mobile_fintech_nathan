class InvestProfitHistoryOb {
  InvestProfitHistoryOb({
    this.success,
    this.message,
    this.data,
  });

  InvestProfitHistoryOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InvestProfitHistoryData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<InvestProfitHistoryData>? data;

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

class InvestProfitHistoryData {
  InvestProfitHistoryData({
    this.id,
    this.investAmount,
    this.plan,
    this.tradingProfitPercent,
    this.tradingProfitAmount,
    this.planPercent,
    this.profitAmount,
    this.investDate,
    this.returnDate,
  });

  InvestProfitHistoryData.fromJson(dynamic json) {
    id = json['id'];
    investAmount = json['invest_amount'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    tradingProfitPercent = json['trading_profit_percent'];
    tradingProfitAmount = json['trading_profit_amount'];
    planPercent = json['plan_percent'];
    profitAmount = json['profit_amount'];
    investDate = json['invest_date'];
    returnDate = json['return_date'];
  }

  int? id;
  String? investAmount;
  Plan? plan;
  String? tradingProfitPercent;
  String? tradingProfitAmount;
  String? planPercent;
  String? profitAmount;
  String? investDate;
  String? returnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['invest_amount'] = investAmount;
    if (plan != null) {
      map['plan'] = plan?.toJson();
    }
    map['trading_profit_percent'] = tradingProfitPercent;
    map['trading_profit_amount'] = tradingProfitAmount;
    map['plan_percent'] = planPercent;
    map['profit_amount'] = profitAmount;
    map['invest_date'] = investDate;
    map['return_date'] = returnDate;
    return map;
  }
}

class Plan {
  Plan({
    this.id,
    this.name,
    this.duration,
    this.profit,
    this.description,
  });

  Plan.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    profit = json['profit'];
    description = json['description'];
  }

  int? id;
  String? name;
  String? duration;
  int? profit;
  dynamic description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['duration'] = duration;
    map['profit'] = profit;
    map['description'] = description;
    return map;
  }
}
