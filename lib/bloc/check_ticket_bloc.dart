import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/check_ticket_ob.dart';
import 'package:rxdart/subjects.dart';

class CheckTicketBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkTicketController = PublishSubject();

  Stream<ResponseOb> checkTicketStream() => checkTicketController.stream;

  checkTicket({required Map<String, dynamic> data}) async {
    postReq(CHECK_TICKET, params: data, onDataCallBack: (ResponseOb resp) {
      if (kIsWeb) {
        resp.data = CheckTicketOb.fromJson(resp.data);
      } else {
        resp.data = CheckTicketOb.fromJson(resp.data);
      }
      checkTicketController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkTicketController.sink.add(resp);
    });
  }
}
