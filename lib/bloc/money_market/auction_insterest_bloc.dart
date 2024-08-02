import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/money_market/Auction_insterest_ob.dart';
import 'package:fnge/objects/user_info_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class AuctionInsterestBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionInstController = PublishSubject();
  Stream<ResponseOb> auctionInstStream() => auctionInstController.stream;

  requestAuctionInst({required Map<String, dynamic> data}) {
    postReq(GET_AUCTION_RULE, params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = AuctionInsterestOb.fromJson(resp.data);
        } else {
          resp.data = AuctionInsterestOb.fromJson(resp.data);
        }
      }
      auctionInstController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionInstController.sink.add(resp);
    });
  }
}
