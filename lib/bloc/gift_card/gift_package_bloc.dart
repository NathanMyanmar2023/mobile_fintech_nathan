import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/referral_incentive_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/bill_auction_ob.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/gift_card/Gift_shop_ob.dart';
import '../../objects/history/phone_bill_ob.dart';

class GiftPackageBloc extends BaseNetwork {
  PublishSubject<ResponseOb> giftPackageController = PublishSubject();
  Stream<ResponseOb> giftPackageStream() => giftPackageController.stream;

  getGiftPackageList(String tag) async {
    getReq("$GET_GiFT_PKG_LIST$tag", onDataCallBack: (ResponseOb resp) {
      giftPackageController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      giftPackageController.sink.add(resp);
    });
  }
}
