class CheckTicketOb {
  CheckTicketOb({
      this.success, 
      this.message, 
      this.data,});

  CheckTicketOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<int>() : [];
  }
  bool? success;
  String? message;
  List<int>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}