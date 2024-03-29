import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/check_ticket_ob.dart';
import 'package:rxdart/subjects.dart';

class CheckTicketBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkTicketController = PublishSubject();

  Stream<ResponseOb> checkTicketStream() => checkTicketController.stream;

  checkTicket({required Map<String, dynamic> data}) async {
    postReq(CHECK_TICKET, params: data, onDataCallBack: (ResponseOb resp) {
      resp.data = CheckTicketOb.fromJson(resp.data);
      checkTicketController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkTicketController.sink.add(resp);
    });
  }
}
