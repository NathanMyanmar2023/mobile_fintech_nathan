import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class InvestmentPlanBloc extends BaseNetwork {
  PublishSubject<ResponseOb> investmentPlanController = PublishSubject();

  Stream<ResponseOb> investmentPlanStream() => investmentPlanController.stream;

  getInvestmentPlans() async {
    getReq(INVESTMENT_PLANS, onDataCallBack: (ResponseOb resp) {
      investmentPlanController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      investmentPlanController.sink.add(resp);
    });
  }
}
