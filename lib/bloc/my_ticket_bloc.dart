import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/application_fee_ob.dart';
import 'package:fnge/objects/my_ticket_ob.dart';
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
