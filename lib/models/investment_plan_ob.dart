class InvestmentPlanOb {
  InvestmentPlanOb({
      this.success, 
      this.message, 
      this.data,});

  InvestmentPlanOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;

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

class Data {
  Data({
      this.id, 
      this.name, 
      this.duration, 
      this.profit,
    this.is_allow,
      this.description,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    profit = json['profit'];
    is_allow = json['is_allow'];
    description = json['description'];
  }
  int? id;
  String? name;
  String? duration;
  int? profit;
  int? is_allow;
  dynamic description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['duration'] = duration;
    map['profit'] = profit;
    map['is_allow'] = is_allow;
    map['description'] = description;
    return map;
  }

}