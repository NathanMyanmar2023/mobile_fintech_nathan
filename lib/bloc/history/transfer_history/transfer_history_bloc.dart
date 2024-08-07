import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/transfer_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class TransferHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> transferHistoryController = PublishSubject();
  Stream<ResponseOb> transferHistoryStream() =>
      transferHistoryController.stream;

  getTransferHistory(int page) async {
    getReq("${API_URL}history/transfer?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = TransferHistoryOb.fromJson(resp.data);
      }
      transferHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      transferHistoryController.sink.add(resp);
    });
  }
}
