import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/deposit_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class DepositHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> depositHistoryController = PublishSubject();
  Stream<ResponseOb> depositHistoryStream() => depositHistoryController.stream;

  getDepositHistory(int page) async {
    getReq("${API_URL}history/deposit?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = DepositHistoryOb.fromJson(resp.data);
      }
      depositHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      depositHistoryController.sink.add(resp);
    });
  }
}
