import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/money_market/Auction_insterest_ob.dart';
import 'package:nathan_app/objects/user_info_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class AuctionInsterestBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionInstController = PublishSubject();
  Stream<ResponseOb> auctionInstStream() => auctionInstController.stream;

  requestAuctionInst({required Map<String, dynamic> data}) {
    postReq(GET_AUCTION_RULE,params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = AuctionInsterestOb.fromJson(resp.data);
      }
      auctionInstController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionInstController.sink.add(resp);
    });
  }
}
