class UpdateProfileOb {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileOb({this.success, this.message, this.data});

  UpdateProfileOb.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? username;
  String? phone;
  String? email;
  String? image;
  String? role;
  String? referCode;
  String? addressLine;
  String? city;
  String? region;
  String? country;
  String? postalCode;
  String? gender;
  String? isKyc;
  String? mainWalletAmount;
  String? mainWalletCurrencyName;
  String? mainWalletCurrencyType;
  String? usdWalletAmount;
  String? investmentWalletAmount;
  String? networkWalletAmount;

  Data(
      {this.name,
      this.username,
      this.phone,
      this.email,
      this.image,
      this.role,
      this.referCode,
      this.addressLine,
      this.city,
      this.region,
      this.country,
      this.postalCode,
      this.gender,
      this.isKyc,
      this.mainWalletAmount,
      this.mainWalletCurrencyName,
      this.mainWalletCurrencyType,
      this.usdWalletAmount,
      this.investmentWalletAmount,
      this.networkWalletAmount});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    role = json['role'];
    referCode = json['refer_code'];
    addressLine = json['address_line'];
    city = json['city'];
    region = json['region'];
    country = json['country'];
    postalCode = json['postal_code'];
    gender = json['gender'];
    isKyc = json['is_kyc'];
    mainWalletAmount = json['main_wallet_amount'];
    mainWalletCurrencyName = json['main_wallet_currency_name'];
    mainWalletCurrencyType = json['main_wallet_currency_type'];
    usdWalletAmount = json['usd_wallet_amount'];
    investmentWalletAmount = json['investment_wallet_amount'];
    networkWalletAmount = json['network_wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['role'] = role;
    data['refer_code'] = referCode;
    data['address_line'] = addressLine;
    data['city'] = city;
    data['region'] = region;
    data['country'] = country;
    data['postal_code'] = postalCode;
    data['gender'] = gender;
    data['is_kyc'] = isKyc;
    data['main_wallet_amount'] = mainWalletAmount;
    data['main_wallet_currency_name'] = mainWalletCurrencyName;
    data['main_wallet_currency_type'] = mainWalletCurrencyType;
    data['usd_wallet_amount'] = usdWalletAmount;
    data['investment_wallet_amount'] = investmentWalletAmount;
    data['network_wallet_amount'] = networkWalletAmount;
    return data;
  }
}
