class ExchangeOb {
  bool? success;
  String? message;
  Data? data;

  ExchangeOb({this.success, this.message, this.data});

  ExchangeOb.fromJson(Map<String, dynamic> json) {
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
  int? exchangeId;
  bool? isToMainWallet;
  String? fromAmount;
  String? fromCurrency;
  String? toAmount;
  String? toCurrency;

  Data(
      {this.exchangeId,
      this.isToMainWallet,
      this.fromAmount,
      this.fromCurrency,
      this.toAmount,
      this.toCurrency});

  Data.fromJson(Map<String, dynamic> json) {
    exchangeId = json['exchange_id'];
    isToMainWallet = json['is_to_main_wallet'];
    fromAmount = json['from_amount'];
    fromCurrency = json['from_currency'];
    toAmount = json['to_amount'];
    toCurrency = json['to_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exchange_id'] = exchangeId;
    data['is_to_main_wallet'] = isToMainWallet;
    data['from_amount'] = fromAmount;
    data['from_currency'] = fromCurrency;
    data['to_amount'] = toAmount;
    data['to_currency'] = toCurrency;
    return data;
  }
}
