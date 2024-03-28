class LuckyDrawOb {
  LuckyDrawOb({
    this.success,
    this.message,
    this.data,
  });

  LuckyDrawOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LuckyDrawData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<LuckyDrawData>? data;

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

class LuckyDrawData {
  LuckyDrawData({
    this.id,
    this.name,
    this.maxTicket,
    this.price,
    this.openDate,
    this.isOpened,
    this.rules,
    this.poster,
    this.prizes,
  });

  LuckyDrawData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    maxTicket = json['max_ticket'];
    price = json['price'];
    openDate = json['open_date'];
    isOpened = json['is_opened'];
    rules = json['rules'];
    poster = json['poster'];
    if (json['prizes'] != null) {
      prizes = [];
      json['prizes'].forEach((v) {
        prizes?.add(Prizes.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  int? maxTicket;
  double? price;
  dynamic openDate;
  int? isOpened;
  String? rules;
  String? poster;
  List<Prizes>? prizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['max_ticket'] = maxTicket;
    map['price'] = price;
    map['open_date'] = openDate;
    map['is_opened'] = isOpened;
    map['rules'] = rules;
    map['poster'] = poster;
    if (prizes != null) {
      map['prizes'] = prizes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Prizes {
  Prizes({
    this.name,
    this.photo,
  });

  Prizes.fromJson(dynamic json) {
    name = json['name'];
    photo = json['photo'];
  }

  String? name;
  String? photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['photo'] = photo;
    return map;
  }
}
