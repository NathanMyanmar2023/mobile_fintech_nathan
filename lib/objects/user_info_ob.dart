class UserInfoOb {
  bool? success;
  String? message;
  Data? data;

  UserInfoOb({this.success, this.message, this.data});

  UserInfoOb.fromJson(Map<String, dynamic> json) {
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
  int? id;
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
  String? kyc_message;

  Data({
    this.id,
    this.name,
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
    this.kyc_message,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    kyc_message = json['kyc_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    data['kyc_message'] = kyc_message;
    return data;
  }
}
