class TransferHistoryOb {
  bool? success;
  String? message;
  List<Data>? data;

  TransferHistoryOb({this.success, this.message, this.data});

  TransferHistoryOb.fromJson(Map<String, dynamic> json) {
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
  int? isTransfer;
  String? senderName;
  String? senderPhone;
  String? currency;
  String? receiverName;
  String? receiverPhone;
  String? amount;
  String? note;
  String? createdAt;

  Data(
      {this.id,
      this.isTransfer,
      this.senderName,
      this.senderPhone,
      this.currency,
      this.receiverName,
      this.receiverPhone,
      this.amount,
      this.note,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isTransfer = json['is_transfer'];
    senderName = json['sender_name'];
    senderPhone = json['sender_phone'];
    currency = json['currency'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    amount = json['amount'];
    note = json['note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_transfer'] = isTransfer;
    data['sender_name'] = senderName;
    data['sender_phone'] = senderPhone;
    data['currency'] = currency;
    data['receiver_name'] = receiverName;
    data['receiver_phone'] = receiverPhone;
    data['amount'] = amount;
    data['note'] = note;
    data['created_at'] = createdAt;
    return data;
  }
}
