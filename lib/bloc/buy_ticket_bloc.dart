import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/buy_ticket_ob.dart';
import 'package:rxdart/subjects.dart';

class BuyTicketBloc extends BaseNetwork {
  PublishSubject<ResponseOb> buyTicketController = PublishSubject();

  Stream<ResponseOb> buyTicketStream() => buyTicketController.stream;

  buyTicket({required Map<String, dynamic> data}) async {
    postReq(BUY_TICKET, params: data, onDataCallBack: (ResponseOb resp) {
      resp.data = BuyTicketOb.fromJson(resp.data);
      buyTicketController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      buyTicketController.sink.add(resp);
    });
  }
}
