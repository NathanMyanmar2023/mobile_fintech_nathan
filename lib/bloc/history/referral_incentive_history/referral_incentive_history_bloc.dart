import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/referral_incentive_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ReferralIncentiveHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> referralIncentiveHistoryController =
      PublishSubject();
  Stream<ResponseOb> referralIncentiveHistoryStream() =>
      referralIncentiveHistoryController.stream;

  getReferralIncentiveHistory(int page) async {
    getReq("${API_URL}history/referral_incentive",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ReferralIncentiveHistoryOb.fromJson(resp.data);
      }
      referralIncentiveHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      referralIncentiveHistoryController.sink.add(resp);
    });
  }
}
