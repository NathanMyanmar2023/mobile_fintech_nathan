class LevelsOb {
  LevelsOb({
    this.success,
    this.message,
    this.data,
  });

  LevelsOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

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

class Data {
  Data({
    this.userId,
    this.levelOne,
    this.levelTwo,
    this.levelThree,
    this.levelFour,
    this.levelFive,
    this.levelSix,
    this.levelSeven,
    this.levelEight,
    this.levelNine,
    this.levelTen,
  });

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    levelOne =
        json['level_one'] != null ? LevelOne.fromJson(json['level_one']) : null;
    levelTwo =
        json['level_two'] != null ? LevelTwo.fromJson(json['level_two']) : null;
    levelThree = json['level_three'] != null
        ? LevelThree.fromJson(json['level_three'])
        : null;
    levelFour = json['level_four'] != null
        ? LevelFour.fromJson(json['level_four'])
        : null;
    levelFive = json['level_five'] != null
        ? LevelFive.fromJson(json['level_five'])
        : null;
    levelSix =
        json['level_six'] != null ? LevelSix.fromJson(json['level_six']) : null;
    levelSeven = json['level_seven'] != null
        ? LevelSeven.fromJson(json['level_seven'])
        : null;
    levelEight = json['level_eight'] != null
        ? LevelEight.fromJson(json['level_eight'])
        : null;
    levelNine = json['level_nine'] != null
        ? LevelNine.fromJson(json['level_nine'])
        : null;
    levelTen =
        json['level_ten'] != null ? LevelTen.fromJson(json['level_ten']) : null;
  }

  int? userId;
  LevelOne? levelOne;
  LevelTwo? levelTwo;
  LevelThree? levelThree;
  LevelFour? levelFour;
  LevelFive? levelFive;
  LevelSix? levelSix;
  LevelSeven? levelSeven;
  LevelEight? levelEight;
  LevelNine? levelNine;
  LevelTen? levelTen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    if (levelOne != null) {
      map['level_one'] = levelOne?.toJson();
    }
    if (levelTwo != null) {
      map['level_two'] = levelTwo?.toJson();
    }
    if (levelThree != null) {
      map['level_three'] = levelThree?.toJson();
    }
    if (levelFour != null) {
      map['level_four'] = levelFour?.toJson();
    }
    if (levelFive != null) {
      map['level_five'] = levelFive?.toJson();
    }
    if (levelSix != null) {
      map['level_six'] = levelSix?.toJson();
    }
    if (levelSeven != null) {
      map['level_seven'] = levelSeven?.toJson();
    }
    if (levelEight != null) {
      map['level_eight'] = levelEight?.toJson();
    }
    if (levelNine != null) {
      map['level_nine'] = levelNine?.toJson();
    }
    if (levelTen != null) {
      map['level_ten'] = levelTen?.toJson();
    }
    return map;
  }
}

class LevelTen {
  LevelTen({
    this.persons,
    this.investTotal,
  });

  LevelTen.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelNine {
  LevelNine({
    this.persons,
    this.investTotal,
  });

  LevelNine.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelEight {
  LevelEight({
    this.persons,
    this.investTotal,
  });

  LevelEight.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelSeven {
  LevelSeven({
    this.persons,
    this.investTotal,
  });

  LevelSeven.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelSix {
  LevelSix({
    this.persons,
    this.investTotal,
  });

  LevelSix.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelFive {
  LevelFive({
    this.persons,
    this.investTotal,
  });

  LevelFive.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelFour {
  LevelFour({
    this.persons,
    this.investTotal,
  });

  LevelFour.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelThree {
  LevelThree({
    this.persons,
    this.investTotal,
  });

  LevelThree.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelTwo {
  LevelTwo({
    this.persons,
    this.investTotal,
  });

  LevelTwo.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}

class LevelOne {
  LevelOne({
    this.persons,
    this.investTotal,
  });

  LevelOne.fromJson(dynamic json) {
    persons = json['persons'];
    investTotal = json['invest_total'];
  }

  int? persons;
  int? investTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['persons'] = persons;
    map['invest_total'] = investTotal;
    return map;
  }
}
