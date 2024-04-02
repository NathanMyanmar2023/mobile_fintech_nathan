import 'nrc_state_lists.dart';
import 'nrc_type_lists.dart';

class NrcTypeOb {
  NrcTypeOb({
      this.success, 
      this.message, 
      this.data,});

  NrcTypeOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? NRCData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  NRCData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class NRCData {
  NRCData({
    this.nrcTypeLists,
    this.nrcStateLists,});

  NRCData.fromJson(dynamic json) {
    if (json['nrcTypeLists'] != null) {
      nrcTypeLists = [];
      json['nrcTypeLists'].forEach((v) {
        nrcTypeLists?.add(NrcTypeLists.fromJson(v));
      });
    }
    if (json['nrcStateLists'] != null) {
      nrcStateLists = [];
      json['nrcStateLists'].forEach((v) {
        nrcStateLists?.add(NrcStateLists.fromJson(v));
      });
    }
  }
  List<NrcTypeLists>? nrcTypeLists;
  List<NrcStateLists>? nrcStateLists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (nrcTypeLists != null) {
      map['nrcTypeLists'] = nrcTypeLists?.map((v) => v.toJson()).toList();
    }
    if (nrcStateLists != null) {
      map['nrcStateLists'] = nrcStateLists?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}