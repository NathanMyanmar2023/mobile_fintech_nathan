class WinnerOb {
  WinnerOb({
    this.success,
    this.message,
    this.data,
  });

  WinnerOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WinnerData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<WinnerData>? data;

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

class WinnerData {
  WinnerData({
    this.ticketNo,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userImage,
    this.prizeName,
    this.prize,
    this.data,
  });

  WinnerData.fromJson(dynamic json) {
    ticketNo = json['ticket_no'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userImage = json['user_image'];
    prizeName = json['prize_name'];
    prize = json['prize'];
    data = json['data'];
  }

  int? ticketNo;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userImage;
  String? prizeName;
  String? prize;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ticket_no'] = ticketNo;
    map['user_name'] = userName;
    map['user_email'] = userEmail;
    map['user_phone'] = userPhone;
    map['user_image'] = userImage;
    map['prize_name'] = prizeName;
    map['prize'] = prize;
    map['data'] = data;
    return map;
  }
}
