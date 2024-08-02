import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/buy_ticket_ob.dart';
import 'package:rxdart/subjects.dart';

class BuyTicketBloc extends BaseNetwork {
  PublishSubject<ResponseOb> buyTicketController = PublishSubject();

  Stream<ResponseOb> buyTicketStream() => buyTicketController.stream;

  buyTicket({required Map<String, dynamic> data}) async {
    postReq(BUY_TICKET, params: data, onDataCallBack: (ResponseOb resp) {
      if (kIsWeb) {
        resp.data = BuyTicketOb.fromJson(resp.data);
      } else {
        resp.data = BuyTicketOb.fromJson(resp.data);
      }
      buyTicketController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      buyTicketController.sink.add(resp);
    });
  }
}
