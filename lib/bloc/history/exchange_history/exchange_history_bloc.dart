import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/exchange_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ExchangeHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> exchangeHistoryController = PublishSubject();
  Stream<ResponseOb> exchangeHistoryStream() =>
      exchangeHistoryController.stream;

  getExchangeHistory(int page) async {
    getReq("${API_URL}history/exchange?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ExchangeHistoryOb.fromJson(resp.data);
      }
      exchangeHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      exchangeHistoryController.sink.add(resp);
    });
  }
}
