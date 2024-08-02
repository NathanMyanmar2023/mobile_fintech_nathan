import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/withdraw_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class WithdrawHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> withdrawHistoryController = PublishSubject();
  Stream<ResponseOb> withdrawHistoryStream() =>
      withdrawHistoryController.stream;

  getWithdrawHistory(int page) async {
    getReq("${API_URL}history/withdraw?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = WithdrawHistoryOb.fromJson(resp.data);
      }
      withdrawHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      withdrawHistoryController.sink.add(resp);
    });
  }
}
