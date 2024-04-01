class NrcStateLists {
  NrcStateLists({
      this.id, 
      this.numberEn, 
      this.nameEn,});

  NrcStateLists.fromJson(dynamic json) {
    id = json['id'];
    numberEn = json['numberEn'];
    nameEn = json['nameEn'];
  }
  int? id;
  String? numberEn;
  String? nameEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['numberEn'] = numberEn;
    map['nameEn'] = nameEn;
    return map;
  }

}