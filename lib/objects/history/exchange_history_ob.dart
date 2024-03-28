class ExchangeHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  ExchangeHistoryOb({this.success, this.message, this.data});

  ExchangeHistoryOb.fromJson(Map<String, dynamic> json) {
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
  int? isToMainWallet;
  String? fromAmount;
  String? fromCurrency;
  String? toAmount;
  String? toCurrency;
  String? createdAt;

  Data(
      {this.id,
      this.isToMainWallet,
      this.fromAmount,
      this.fromCurrency,
      this.toAmount,
      this.toCurrency,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isToMainWallet = json['is_to_main_wallet'];
    fromAmount = json['from_amount'];
    fromCurrency = json['from_currency'];
    toAmount = json['to_amount'];
    toCurrency = json['to_currency'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_to_main_wallet'] = isToMainWallet;
    data['from_amount'] = fromAmount;
    data['from_currency'] = fromCurrency;
    data['to_amount'] = toAmount;
    data['to_currency'] = toCurrency;
    data['created_at'] = createdAt;
    return data;
  }
}
