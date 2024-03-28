class ReferralIncentiveHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  ReferralIncentiveHistoryOb({this.success, this.message, this.data});

  ReferralIncentiveHistoryOb.fromJson(Map<String, dynamic> json) {
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
  String? fromUserName;
  String? amount;
  String? seventyPercentAmount;
  String? thirtyPercentAmount;
  String? percent;
  String? createdAt;

  Data(
      {this.id,
      this.fromUserName,
      this.amount,
      this.seventyPercentAmount,
      this.thirtyPercentAmount,
      this.percent,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserName = json['from_user_name'];
    amount = json['amount'];
    seventyPercentAmount = json['seventy_percent_amount'];
    thirtyPercentAmount = json['thirty_percent_amount'];
    percent = json['percent'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_user_name'] = fromUserName;
    data['amount'] = amount;
    data['seventy_percent_amount'] = seventyPercentAmount;
    data['thirty_percent_amount'] = thirtyPercentAmount;
    data['percent'] = percent;
    data['created_at'] = createdAt;
    return data;
  }
}
