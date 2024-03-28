class PhoneBillOb {
  bool? success;
  String? message;
  List<PhoneBillData>? data;

  PhoneBillOb({this.success, this.message, this.data});

  PhoneBillOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PhoneBillData>[];
      json['data'].forEach((v) {
        data!.add(PhoneBillData.fromJson(v));
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

class PhoneBillData {
  int? id, status, amount;
  String? phone;
  String? operator;
  String? date;
  String? billed_time;

  PhoneBillData(
      {this.id,
        this.status,
        this.amount,
        this.phone,
        this.operator,
        this.date,
        this.billed_time,
      });

  PhoneBillData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    amount = json['amount'];
    phone = json['phone'];
    operator = json['operator'];
    date = json['date'];
    billed_time = json['billed_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['amount'] = amount;
    data['phone'] = phone;
    data['operator'] = operator;
    data['date'] = date;
    data['billed_time'] = billed_time;
    return data;
  }
}
