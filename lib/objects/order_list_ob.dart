class OrderListOb {
  OrderListOb({
    this.success,
    this.message,
    this.data,
  });

  OrderListOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OrderListData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<OrderListData>? data;

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

class OrderListData {
  OrderListData({
    this.id,
    this.orderId,
    this.status,
    this.data,
  });

  OrderListData.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    status = json['status'];
    data = json['data'];
  }

  int? id;
  String? orderId;
  String? status;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['status'] = status;
    map['data'] = data;
    return map;
  }
}
