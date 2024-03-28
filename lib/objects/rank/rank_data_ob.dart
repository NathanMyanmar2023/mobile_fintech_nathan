class IC {
  int? is_ic, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  IC(
      {this.is_ic,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  IC.fromJson(Map<String, dynamic> json) {
    is_ic = json['is_ic'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_ic'] = is_ic;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}

class Supervisor {
  int? is_supervisor, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  Supervisor(
      {this.is_supervisor,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  Supervisor.fromJson(Map<String, dynamic> json) {
    is_supervisor = json['is_supervisor'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_supervisor'] = is_supervisor;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}

class Manager {
  int? is_manager, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  Manager(
      {this.is_manager,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  Manager.fromJson(Map<String, dynamic> json) {
    is_manager = json['is_manager'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_manager'] = is_manager;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}

class GeneralManager {
  int? is_general_manager, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  GeneralManager(
      {this.is_general_manager,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  GeneralManager.fromJson(Map<String, dynamic> json) {
    is_general_manager = json['is_general_manager'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_general_manager'] = is_general_manager;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}

class Director {
  int? is_director, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  Director(
      {this.is_director,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  Director.fromJson(Map<String, dynamic> json) {
    is_director = json['is_director'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_director'] = is_director;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}

class President {
  int? is_president, total_child;
  bool? is_invest_money_enough, is_gave_bonus;

  President(
      {this.is_president,
      this.total_child,
      this.is_invest_money_enough,
      this.is_gave_bonus});

  President.fromJson(Map<String, dynamic> json) {
    is_president = json['is_president'];
    total_child = json['total_child'];
    is_invest_money_enough = json['is_invest_money_enough'];
    is_gave_bonus = json['is_gave_bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_president'] = is_president;
    data['total_child'] = total_child;
    data['is_invest_money_enough'] = is_invest_money_enough;
    data['is_gave_bonus'] = is_gave_bonus;
    return data;
  }
}
