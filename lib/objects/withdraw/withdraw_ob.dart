class WithdrawOb {
  bool? success;
  String? message;
  Data? data;

  WithdrawOb({this.success, this.message, this.data});

  WithdrawOb.fromJson(Map<String, dynamic> json) {
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
  int? amount;
  String? accountName;
  String? accountNumber;
  String? paymentMethodName;
  int? paymentMethodId;
  int? withdrawId;

  Data(
      {this.amount,
      this.accountName,
      this.accountNumber,
      this.paymentMethodName,
      this.paymentMethodId,
      this.withdrawId});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    paymentMethodName = json['payment_method_name'];
    paymentMethodId = json['payment_method_id'];
    withdrawId = json['withdraw_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['payment_method_name'] = paymentMethodName;
    data['payment_method_id'] = paymentMethodId;
    data['withdraw_id'] = withdrawId;
    return data;
  }
}
