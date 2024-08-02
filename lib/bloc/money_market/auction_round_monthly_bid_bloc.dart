import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/auction_round_monthly_bid_ob.dart';
import 'package:rxdart/subjects.dart';

class AuctionRoundMonthlyBidBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionRoundMonthlyController = PublishSubject();
  Stream<ResponseOb> auctionRoundMonthlyStream() =>
      auctionRoundMonthlyController.stream;

  getRoundMonthlyBid(int roundID) {
    getReq("$ROUND_MONTHLY_PAY$roundID", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (resp.message == "Sorry, there are no one users") {
          print("NO user");
        } else {
          if (kIsWeb) {
            resp.data = AuctionRoundMonthlyBidOb.fromJson(resp.data);
          } else {
            resp.data = AuctionRoundMonthlyBidOb.fromJson(resp.data);
          }
        }
      }
      auctionRoundMonthlyController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionRoundMonthlyController.sink.add(resp);
    });
  }

  requestRoundMonthlyBid(
      {required int roundID, required Map<String, dynamic> data}) {
    postReq("$ROUND_MONTHLY_PAY$roundID", params: data,
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        auctionRoundMonthlyController.sink.add(resp);
      }
    }, errorCallBack: (ResponseOb resp) {
      auctionRoundMonthlyController.sink.add(resp);
    });
  }
}
