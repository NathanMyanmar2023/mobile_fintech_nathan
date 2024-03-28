class DepositHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  DepositHistoryOb({this.success, this.message, this.data});

  DepositHistoryOb.fromJson(Map<String, dynamic> json) {
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
  int? amount;
  String? status;
  String? country;
  String? currency;
  String? paymentMethod;
  String? createdAt;

  Data(
      {this.id,
      this.amount,
      this.status,
      this.country,
      this.currency,
      this.paymentMethod,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    country = json['country'];
    currency = json['currency'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['status'] = status;
    data['country'] = country;
    data['currency'] = currency;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    return data;
  }
}
