class CheckUserOb {
  bool? success;
  String? message;
  Data? data;

  CheckUserOb({this.success, this.message, this.data});

  CheckUserOb.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  String? name;
  int? amount;

  Data({this.phone, this.name, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['name'] = name;
    data['amount'] = amount;
    return data;
  }
}
