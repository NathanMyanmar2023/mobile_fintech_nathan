import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/deposit/payment_method_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/money_market/Auction_round_ob.dart';

class AuctionRoundBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionRoundController = PublishSubject();
  Stream<ResponseOb> auctionRoundStream() => auctionRoundController.stream;

  getAuctionRound(int auctionId) async {
    getReq("$GET_AUCTION_ROUND$auctionId", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = AuctionRoundOb.fromJson(resp.data);
        } else {
          resp.data = AuctionRoundOb.fromJson(resp.data);
        }
      }
      auctionRoundController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionRoundController.sink.add(resp);
    });
  }
}
