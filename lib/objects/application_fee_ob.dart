class ApplicationFeeOb {
  ApplicationFeeOb({
    this.success,
    this.message,
    this.data,
  });

  ApplicationFeeOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ApplicationFeeData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<ApplicationFeeData>? data;

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

class ApplicationFeeData {
  ApplicationFeeData({
    this.amount,
    this.currencyType,
    this.forYear,
    this.date,
  });

  ApplicationFeeData.fromJson(dynamic json) {
    amount = json['amount'];
    currencyType = json['currency_type'];
    forYear = json['for_year'];
    date = json['date'];
  }

  int? amount;
  String? currencyType;
  String? forYear;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['currency_type'] = currencyType;
    map['for_year'] = forYear;
    map['date'] = date;
    return map;
  }
}
