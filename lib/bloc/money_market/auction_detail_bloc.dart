import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/auction_detail_ob.dart';
import 'package:rxdart/subjects.dart';

class AuctionDetailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> auctionDetailController = PublishSubject();
  Stream<ResponseOb> auctionDetailStream() => auctionDetailController.stream;

  getAuctionDetail(int id) {
    getReq("$GET_AUCTION_DETAIL$id", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = AuctionDetailOb.fromJson(resp.data);
        } else {
          resp.data = AuctionDetailOb.fromJson(resp.data);
        }
      }
      auctionDetailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      auctionDetailController.sink.add(resp);
    });
  }
}
