import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/investment_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class InvestmentHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> investmentHistoryController = PublishSubject();
  Stream<ResponseOb> investmentHistoryStream() => investmentHistoryController.stream;

  getInvestmentHistory(int page) async {
    getReq("${API_URL}history/investment?page=$page", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = InvestmentHistoryOb.fromJson(resp.data);
      }
      investmentHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      investmentHistoryController.sink.add(resp);
    });
  }
}
