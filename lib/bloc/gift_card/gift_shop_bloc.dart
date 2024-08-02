import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/referral_incentive_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/money_market/bill_auction_ob.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/gift_card/Gift_shop_ob.dart';
import '../../objects/history/phone_bill_ob.dart';

class GiftShopBloc extends BaseNetwork {
  PublishSubject<ResponseOb> giftShopController = PublishSubject();
  Stream<ResponseOb> giftShopStream() => giftShopController.stream;

  getGiftShopList() async {
    getReq(GET_GiFT_SHOP_LIST, onDataCallBack: (ResponseOb resp) {
      giftShopController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      giftShopController.sink.add(resp);
    });
  }
}
