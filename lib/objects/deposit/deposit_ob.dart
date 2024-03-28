class DepositOb {
  bool? success;
  String? message;
  Data? data;

  DepositOb({this.success, this.message, this.data});

  DepositOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? currency;
  String? country;
  String? paymentMethod;
  String? transactionId;
  String? amount;

  Data(
      {this.currency,
      this.country,
      this.paymentMethod,
      this.transactionId,
      this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    country = json['country'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['country'] = country;
    data['payment_method'] = paymentMethod;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    return data;
  }
}
