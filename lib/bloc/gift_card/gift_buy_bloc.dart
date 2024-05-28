import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/user_info_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/gift_card/Gift_buy_ob.dart';

class GiftBuyBloc extends BaseNetwork {
  PublishSubject<ResponseOb> giftBuyController = PublishSubject();
  Stream<ResponseOb> giftBuyStream() => giftBuyController.stream;

  requestGiftBuy({required Map<String, dynamic> data}) async {
    postReq(REQ_GIFT_BUY, params: data,
    onDataCallBack: (ResponseOb resp) {
    if (resp.success == true) {
    resp.data = GiftBuyOb.fromJson(resp.data);
    }
          giftBuyController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
          giftBuyController.sink.add(resp);
    });
  }
}
