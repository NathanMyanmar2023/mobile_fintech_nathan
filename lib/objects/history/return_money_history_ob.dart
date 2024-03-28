class ReturnMoneyHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  ReturnMoneyHistoryOb({this.success, this.message, this.data});

  ReturnMoneyHistoryOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? amount;
  String? investDate;
  String? returnDate;

  Data({this.id, this.amount, this.investDate, this.returnDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    investDate = json['invest_date'];
    returnDate = json['return_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['invest_date'] = investDate;
    data['return_date'] = returnDate;
    return data;
  }
}
