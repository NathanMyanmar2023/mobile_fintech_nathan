class PaymentMethodOb {
  bool? success;
  String? message;
  List<Data>? data;

  PaymentMethodOb({this.success, this.message, this.data});

  PaymentMethodOb.fromJson(Map<String, dynamic> json) {
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
  String? currencyName;
  String? currencyType;
  int? paymentId;
  String? paymentName;
  String? paymentImage;
  int? isBank;

  Data(
      {this.currencyName,
      this.currencyType,
      this.paymentId,
      this.paymentName,
      this.paymentImage,
      this.isBank});

  Data.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    currencyType = json['currency_type'];
    paymentId = json['payment_id'];
    paymentName = json['payment_name'];
    paymentImage = json['payment_image'];
    isBank = json['is_bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_name'] = currencyName;
    data['currency_type'] = currencyType;
    data['payment_id'] = paymentId;
    data['payment_name'] = paymentName;
    data['payment_image'] = paymentImage;
    data['is_bank'] = isBank;
    return data;
  }
}
