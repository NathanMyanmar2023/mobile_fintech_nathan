import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/user_info_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/gift_card/Gift_buy_ob.dart';

class GiftBuyBloc extends BaseNetwork {
  PublishSubject<ResponseOb> giftBuyController = PublishSubject();
  Stream<ResponseOb> giftBuyStream() => giftBuyController.stream;

  requestGiftBuy({required Map<String, dynamic> data}) async {
    postReq(REQ_GIFT_BUY, params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = GiftBuyOb.fromJson(resp.data);
        } else {
          resp.data = GiftBuyOb.fromJson(resp.data);
        }
      }
      giftBuyController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      giftBuyController.sink.add(resp);
    });
  }
}
