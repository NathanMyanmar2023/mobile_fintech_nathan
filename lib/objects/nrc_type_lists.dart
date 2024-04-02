class NrcTypeLists {
  NrcTypeLists({
      this.id, 
      this.nrcTypeEN,});

  NrcTypeLists.fromJson(dynamic json) {
    id = json['id'];
    nrcTypeEN = json['nrcTypeEN'];
  }
  int? id;
  String? nrcTypeEN;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nrcTypeEN'] = nrcTypeEN;
    return map;
  }

}