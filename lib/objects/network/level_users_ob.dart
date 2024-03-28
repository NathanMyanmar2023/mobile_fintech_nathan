class LevelUsersOb {
  bool? success;
  String? message;
  List<Data>? data;

  LevelUsersOb({this.success, this.message, this.data});

  LevelUsersOb.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? username;
  String? phone;
  String? imageLocation;
  int? totalInvestAmount;

  Data(
      {this.id,
      this.name,
      this.username,
      this.phone,
      this.imageLocation,
      this.totalInvestAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    imageLocation = json['image_location'];
    totalInvestAmount = json['total_invest_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['phone'] = phone;
    data['image_location'] = imageLocation;
    data['total_invest_amount'] = totalInvestAmount;
    return data;
  }
}
