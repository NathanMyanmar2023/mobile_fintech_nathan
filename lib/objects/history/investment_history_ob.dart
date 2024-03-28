class InvestmentHistoryOb {
  InvestmentHistoryOb({
      this.success, 
      this.message, 
      this.data,});

  InvestmentHistoryOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InvestmentHistoryData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<InvestmentHistoryData>? data;

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

class InvestmentHistoryData {
  InvestmentHistoryData({
      this.id, 
      this.amount, 
      this.plan, 
      this.investDate, 
      this.investYear, 
      this.finishDate, 
      this.note,});

  InvestmentHistoryData.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    investDate = json['invest_date'];
    investYear = json['invest_year'];
    finishDate = json['finish_date'];
    note = json['note'];
  }
  int? id;
  String? amount;
  Plan? plan;
  String? investDate;
  String? investYear;
  String? finishDate;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    if (plan != null) {
      map['plan'] = plan?.toJson();
    }
    map['invest_date'] = investDate;
    map['invest_year'] = investYear;
    map['finish_date'] = finishDate;
    map['note'] = note;
    return map;
  }

}

class Plan {
  Plan({
      this.id, 
      this.name, 
      this.duration, 
      this.profit, 
      this.description,});

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