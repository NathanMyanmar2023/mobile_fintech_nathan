import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/money_market/Auction_insterest_ob.dart';
import 'package:fnge/objects/user_info_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class BidStopBloc extends BaseNetwork {
  PublishSubject<ResponseOb> bidStopController = PublishSubject();
  Stream<ResponseOb> bidStopStream() => bidStopController.stream;

  requestBidStop(int roundID) {
    postReq("$BID_STOP_ROUND$roundID/stop", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        bidStopController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      bidStopController.sink.add(resp);
    });
  }
}
