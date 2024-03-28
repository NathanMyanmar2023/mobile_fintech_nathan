class TownshipOb {
  TownshipOb({
    this.success,
    this.message,
    this.data,
  });

  TownshipOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TownShipData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<TownShipData>? data;

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

class TownShipData {
  TownShipData({
    this.id,
    this.regionId,
    this.name,
    this.fees,
    this.note,
    this.giveCod,
  });

  TownShipData.fromJson(dynamic json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
    fees = json['fees'];
    note = json['note'];
    giveCod = json['give_cod'];
  }

  int? id;
  dynamic regionId;
  String? name;
  int? fees;
  String? note;
  int? giveCod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['region_id'] = regionId;
    map['name'] = name;
    map['fees'] = fees;
    map['note'] = note;
    map['give_cod'] = giveCod;
    return map;
  }
}
