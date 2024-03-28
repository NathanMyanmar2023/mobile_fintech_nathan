import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/invest_profit_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class InvestProfitHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> investProfitHistoryController = PublishSubject();
  Stream<ResponseOb> investProfitHistoryStream() => investProfitHistoryController.stream;

  getInvestProfitHistory(int page) async {
    getReq("${API_URL}history/investment/profit?page=$page", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = InvestProfitHistoryOb.fromJson(resp.data);
      }
      investProfitHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      investProfitHistoryController.sink.add(resp);
    });
  }
}
