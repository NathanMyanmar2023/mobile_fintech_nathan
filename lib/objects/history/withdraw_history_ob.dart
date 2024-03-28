class WithdrawHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  WithdrawHistoryOb({this.success, this.message, this.data});

  WithdrawHistoryOb.fromJson(Map<String, dynamic> json) {
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
  String? currency;
  String? accountName;
  String? accountNumber;
  String? paymentMethodName;
  String? paymentMethodIcon;
  int? status;
  String? createdAt;

  Data(
      {this.id,
      this.amount,
      this.currency,
      this.accountName,
      this.accountNumber,
      this.paymentMethodName,
      this.paymentMethodIcon,
      this.status,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    paymentMethodName = json['payment_method_name'];
    paymentMethodIcon = json['payment_method_icon'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['currency'] = currency;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['payment_method_name'] = paymentMethodName;
    data['payment_method_icon'] = paymentMethodIcon;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
