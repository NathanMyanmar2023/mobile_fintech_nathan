
class AuctionRoundOb {
  AuctionRoundOb({
      this.data,});

  AuctionRoundOb.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
class Data {
  Data({
    this.id,
    this.roundNumber,
    this.userId,
    this.auctionId,
    this.baseAmount,
    this.realAmount,
    this.monthPosition,
    this.monthFinished,
    this.isDone,
    this.currentTime,
    this.createdAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    roundNumber = json['roundNumber'];
    userId = json['user_id'];
    auctionId = json['auction_id'];
    baseAmount = json['base_amount'];
    realAmount = json['real_amount'];
    monthPosition = json['month_position'];
    monthFinished = json['monthFinished'];
    isDone = json['is_done'];
    currentTime = json['currentTime'];
    createdAt = json['created_at'];
  }
  int? id;
  String? roundNumber;
  int? userId;
  int? auctionId;
  int? baseAmount;
  int? realAmount;
  int? monthPosition;
  String? monthFinished;
  int? isDone;
  String? currentTime;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roundNumber'] = roundNumber;
    map['user_id'] = userId;
    map['auction_id'] = auctionId;
    map['base_amount'] = baseAmount;
    map['real_amount'] = realAmount;
    map['month_position'] = monthPosition;
    map['monthFinished'] = monthFinished;
    map['is_done'] = isDone;
    map['currentTime'] = currentTime;
    map['created_at'] = createdAt;
    return map;
  }

}