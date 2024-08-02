import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/return_money_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ReturnMoneyHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> returnMoneyHistoryController = PublishSubject();
  Stream<ResponseOb> returnMoneyHistoryStream() =>
      returnMoneyHistoryController.stream;

  getReturnMoneyHistory(int page) async {
    getReq("${API_URL}history/final_return_money?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ReturnMoneyHistoryOb.fromJson(resp.data);
      }
      returnMoneyHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      returnMoneyHistoryController.sink.add(resp);
    });
  }
}
