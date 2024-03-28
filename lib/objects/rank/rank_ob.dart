import 'package:nathan_app/objects/rank/rank_data_ob.dart';

class RankOb {
  bool? success;
  String? message;
  Data? data;

  RankOb({this.success, this.message, this.data});

  RankOb.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  IC? iC;
  Supervisor? supervisor;
  Manager? manager;
  GeneralManager? generalManager;
  Director? director;
  President? president;

  Data({
    this.iC,
    this.supervisor,
    this.manager,
    this.generalManager,
    this.director,
    this.president,
  });

  Data.fromJson(Map<String, dynamic> json) {
    iC = json['IC'] != null ? IC.fromJson(json['IC']) : null;
    supervisor = json['Supervisor'] != null
        ? Supervisor.fromJson(json['Supervisor'])
        : null;
    manager =
        json['Manager'] != null ? Manager.fromJson(json['Manager']) : null;
    generalManager = json['General_Manager'] != null
        ? GeneralManager.fromJson(json['General_Manager'])
        : null;
    director =
        json['Director'] != null ? Director.fromJson(json['Director']) : null;
    president = json['President'] != null
        ? President.fromJson(json['President'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.iC != null) {
      data['IC'] = this.iC!.toJson();
    }
    if (this.supervisor != null) {
      data['Supervisor'] = this.supervisor!.toJson();
    }
    if (this.manager != null) {
      data['Manager'] = this.manager!.toJson();
    }
    if (this.generalManager != null) {
      data['General_Manager'] = this.generalManager!.toJson();
    }
    if (this.director != null) {
      data['Director'] = this.director!.toJson();
    }
    if (this.president != null) {
      data['President'] = this.president!.toJson();
    }
    return data;
  }
}
