class MyTicketOb {
  MyTicketOb({
    this.success,
    this.message,
    this.data,
  });

  MyTicketOb.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TicketData.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<TicketData>? data;

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

class TicketData {
  TicketData({
    this.prize,
    this.tickets,
  });

  TicketData.fromJson(dynamic json) {
    prize = json['prize'];
    if (json['tickets'] != null) {
      tickets = [];
      json['tickets'].forEach((v) {
        tickets?.add(Tickets.fromJson(v));
      });
    }
  }

  String? prize;
  List<Tickets>? tickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prize'] = prize;
    if (tickets != null) {
      map['tickets'] = tickets?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Tickets {
  Tickets({
    this.prizeId,
    this.ticketNo,
    this.prizeName,
    this.openDate,
    this.isOpened,
    this.buyDate,
  });

  Tickets.fromJson(dynamic json) {
    prizeId = json['prize_id'];
    ticketNo = json['ticket_no'];
    prizeName = json['prize_name'];
    openDate = json['open_date'];
    isOpened = json['is_opened'];
    buyDate = json['buy_date'];
  }

  int? prizeId;
  int? ticketNo;
  String? prizeName;
  String? openDate;
  int? isOpened;
  String? buyDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prize_id'] = prizeId;
    map['ticket_no'] = ticketNo;
    map['prize_name'] = prizeName;
    map['open_date'] = openDate;
    map['is_opened'] = isOpened;
    map['buy_date'] = buyDate;
    return map;
  }
}
