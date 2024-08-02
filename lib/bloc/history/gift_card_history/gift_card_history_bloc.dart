import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../../objects/history/Gift_card_history_ob.dart';

class GiftCardHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> giftCardHistoryController = PublishSubject();
  Stream<ResponseOb> giftCardHistoryStream() =>
      giftCardHistoryController.stream;

  getGiftCardHistoryHistory() async {
    getReq("${API_URL}giftcard/history/", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = GiftCardHistoryOb.fromJson(resp.data);
      }
      giftCardHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      giftCardHistoryController.sink.add(resp);
    });
  }
}
