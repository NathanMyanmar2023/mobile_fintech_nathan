import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/history/network_profit_history_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class NetworkProfitHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> networkProfitHistoryController = PublishSubject();
  Stream<ResponseOb> networkProfitHistoryStream() =>
      networkProfitHistoryController.stream;

  getNetworkProfitHistory(int page) async {
    getReq("${API_URL}history/network/profit?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = NetworkProfitHistoryOb.fromJson(resp.data);
      }
      networkProfitHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      networkProfitHistoryController.sink.add(resp);
    });
  }
}
