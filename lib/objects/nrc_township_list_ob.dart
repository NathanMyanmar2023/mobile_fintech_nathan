class NrcTownshipListOb {
  NrcTownshipListOb({
      this.success, 
      this.message, 
      this.data,});

  NrcTownshipListOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NRCTownshipData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<NRCTownshipData>? data;

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

class NRCTownshipData {
  NRCTownshipData({
    this.id,
    this.stateCode,
    this.shortEn,
    this.nameEn,});

  NRCTownshipData.fromJson(dynamic json) {
    id = json['id'];
    stateCode = json['stateCode'];
    shortEn = json['shortEn'];
    nameEn = json['nameEn'];
  }
  int? id;
  String? stateCode;
  String? shortEn;
  String? nameEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['stateCode'] = stateCode;
    map['shortEn'] = shortEn;
    map['nameEn'] = nameEn;
    return map;
  }
}