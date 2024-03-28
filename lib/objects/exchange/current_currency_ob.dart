class CurrentCurrencyOb {
  bool? success;
  String? message;
  Data? data;

  CurrentCurrencyOb({this.success, this.message, this.data});

  CurrentCurrencyOb.fromJson(Map<String, dynamic> json) {
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
  String? balance;
  String? usdBalance;
  String? currencyName;
  String? currencyType;
  String? countryCode;
  String? buyRate;
  String? sellRate;

  Data(
      {this.balance,
      this.usdBalance,
      this.currencyName,
      this.currencyType,
      this.countryCode,
      this.buyRate,
      this.sellRate});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    usdBalance = json['usd_balance'];
    currencyName = json['currency_name'];
    currencyType = json['currency_type'];
    countryCode = json['country_code'];
    buyRate = json['buy_rate'];
    sellRate = json['sell_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['usd_balance'] = usdBalance;
    data['currency_name'] = currencyName;
    data['currency_type'] = currencyType;
    data['country_code'] = countryCode;
    data['buy_rate'] = buyRate;
    data['sell_rate'] = sellRate;
    return data;
  }
}
