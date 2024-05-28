import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class RequestAuctionRoundMonthlyBidBloc extends BaseNetwork {
  PublishSubject<ResponseOb> requestAuctionRoundMonthlyController = PublishSubject();
  Stream<ResponseOb> requestAuctionRoundMonthlyStream() => requestAuctionRoundMonthlyController.stream;

  requestRoundMonthlyBid({required int roundID, required Map<String, dynamic> data}) {
    postReq("$ROUND_MONTHLY_PAY$roundID",params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        requestAuctionRoundMonthlyController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      requestAuctionRoundMonthlyController.sink.add(resp);
    });
  }
}