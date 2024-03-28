class InvestmentOb {
  InvestmentOb({
      this.success, 
      this.message, 
      this.data,});

  InvestmentOb.fromJson(dynamic json) {
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
      this.investmentId, 
      this.amount, 
      this.investDate, 
      this.finishDate, 
      this.note,});

  Data.fromJson(dynamic json) {
    investmentId = json['investment_id'];
    amount = json['amount'];
    investDate = json['invest_date'];
    finishDate = json['finish_date'];
    note = json['note'];
  }
  int? investmentId;
  int? amount;
  String? investDate;
  String? finishDate;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investment_id'] = investmentId;
    map['amount'] = amount;
    map['invest_date'] = investDate;
    map['finish_date'] = finishDate;
    map['note'] = note;
    return map;
  }

}