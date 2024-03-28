import 'data_response.dart';

class ForgotPassResetOb {
  bool? success;
  String? message;
  DataOB? dataob;
  ForgotPassResetOb({
      this.success, 
      this.message, 
      this.dataob,});

  ForgotPassResetOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    dataob = json['data'] != null ? DataOB.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (dataob != null) {
      map['data'] = dataob?.toJson();
    }
    return map;
  }
}
class DataOB {
  DataResponse? dataRes;
  String? token;
  DataOB({
    this.dataRes,
    this.token,});

  DataOB.fromJson(dynamic json) {
    dataRes = json['data'] != null ? DataResponse.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataRes != null) {
      map['data'] = dataRes?.toJson();
    }
    map['token'] = token;
    return map;
  }

}