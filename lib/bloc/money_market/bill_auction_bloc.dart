import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/referral_incentive_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/money_market/bill_auction_ob.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/history/phone_bill_ob.dart';

class BillAuctionBloc extends BaseNetwork {
  PublishSubject<ResponseOb> billAuctionController =
  PublishSubject();
  Stream<ResponseOb> billAuctionStream() =>
      billAuctionController.stream;

  getBillAuction() async {
    getReq(GET_BILL_AUCTION,
        onDataCallBack: (ResponseOb resp) {
          if (resp.success == true) {
            resp.data = BillAuctionOb.fromJson(resp.data);
          }
          billAuctionController.sink.add(resp);
        }, errorCallBack: (ResponseOb resp) {
          billAuctionController.sink.add(resp);
        });
  }
}
