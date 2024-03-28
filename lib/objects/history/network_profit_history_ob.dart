class NetworkProfitHistoryOb {
  NetworkProfitHistoryOb({
    this.success,
    this.message,
    this.data,
  });

  NetworkProfitHistoryOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NetworkProfitHistoryData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<NetworkProfitHistoryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NetworkProfitHistoryData {
  NetworkProfitHistoryData({
    this.id,
    this.fromUserName,
    this.amount,
    this.createdAt,
  });

  NetworkProfitHistoryData.fromJson(dynamic json) {
    id = json['id'];
    fromUserName = json['from_user_name'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  int? id;
  String? fromUserName;
  String? amount;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['from_user_name'] = fromUserName;
    map['amount'] = amount;
    map['created_at'] = createdAt;
    return map;
  }
}
