import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../../objects/history/promotion_history_ob.dart';

class PromotionHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> promotionHistoryController =
  PublishSubject();
  Stream<ResponseOb> promotionHistoryStream() =>
      promotionHistoryController.stream;

  getPromotionHistoryHistory(int page) async {
    getReq("${API_URL}history/promotions?page=$page",
        onDataCallBack: (ResponseOb resp) {
          if (resp.success == true) {
            resp.data = PromotionHistoryOb.fromJson(resp.data);
          }
          promotionHistoryController.sink.add(resp);
        }, errorCallBack: (ResponseOb resp) {
          promotionHistoryController.sink.add(resp);
        });
  }
}
