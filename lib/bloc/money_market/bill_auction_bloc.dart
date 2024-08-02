import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/referral_incentive_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/bill_auction_ob.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/history/phone_bill_ob.dart';

class BillAuctionBloc extends BaseNetwork {
  PublishSubject<ResponseOb> billAuctionController = PublishSubject();
  Stream<ResponseOb> billAuctionStream() => billAuctionController.stream;

  getBillAuction() async {
    getReq(GET_BILL_AUCTION, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = BillAuctionOb.fromJson(resp.data);
        } else {
          resp.data = BillAuctionOb.fromJson(resp.data);
        }
      }
      billAuctionController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      billAuctionController.sink.add(resp);
    });
  }
}
