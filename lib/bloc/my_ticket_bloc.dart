import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/application_fee_ob.dart';
import 'package:nathan_app/objects/my_ticket_ob.dart';
import 'package:rxdart/subjects.dart';

class MyTicketBloc extends BaseNetwork {
  PublishSubject<ResponseOb> myTicketController = PublishSubject();

  Stream<ResponseOb> myTicketStream() => myTicketController.stream;

  getMyTicket() async {
    getReq(GET_TICKET, onDataCallBack: (ResponseOb resp) {
      resp.data = MyTicketOb.fromJson(resp.data);
      myTicketController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      myTicketController.sink.add(resp);
    });
  }
}
