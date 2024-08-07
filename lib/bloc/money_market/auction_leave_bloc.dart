import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/auction_detail_ob.dart';
import 'package:rxdart/subjects.dart';

class AuctionLeaveBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionLeaveController = PublishSubject();
  Stream<ResponseOb> auctionLeaveStream() => auctionLeaveController.stream;

  getAuctionLeave(
      {required int auctionID, required Map<String, dynamic> data}) {
    postReq("$REQUEST_LEAVE_AUCTION$auctionID", params: data,
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        auctionLeaveController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      auctionLeaveController.sink.add(resp);
    });
  }
}
