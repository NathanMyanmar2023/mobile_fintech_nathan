class DeleteShoppingCartOb {
  DeleteShoppingCartOb({
      this.success, 
      this.message,});

  DeleteShoppingCartOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}