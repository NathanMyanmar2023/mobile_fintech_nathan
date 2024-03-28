class WalletsOb {
  bool? success;
  String? message;
  Data? data;

  WalletsOb({this.success, this.message, this.data});

  WalletsOb.fromJson(Map<String, dynamic> json) {
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
  String? mainWalletAmount;
  String? mainWalletCurrencyName;
  String? mainWalletCurrencyType;
  String? usdWalletAmount;
  String? investmentWalletAmount;
  String? networkWalletAmount;

  Data(
      {this.mainWalletAmount,
      this.mainWalletCurrencyName,
      this.mainWalletCurrencyType,
      this.usdWalletAmount,
      this.investmentWalletAmount,
      this.networkWalletAmount});

  Data.fromJson(Map<String, dynamic> json) {
    mainWalletAmount = json['main_wallet_amount'];
    mainWalletCurrencyName = json['main_wallet_currency_name'];
    mainWalletCurrencyType = json['main_wallet_currency_type'];
    usdWalletAmount = json['usd_wallet_amount'];
    investmentWalletAmount = json['investment_wallet_amount'];
    networkWalletAmount = json['network_wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main_wallet_amount'] = mainWalletAmount;
    data['main_wallet_currency_name'] = mainWalletCurrencyName;
    data['main_wallet_currency_type'] = mainWalletCurrencyType;
    data['usd_wallet_amount'] = usdWalletAmount;
    data['investment_wallet_amount'] = investmentWalletAmount;
    data['network_wallet_amount'] = networkWalletAmount;
    return data;
  }
}
