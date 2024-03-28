import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/referral_incentive_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/history/phone_bill_ob.dart';

class PhoneBillBloc extends BaseNetwork {
  PublishSubject<ResponseOb> phoneBillController =
  PublishSubject();
  Stream<ResponseOb> phoneBillStream() =>
      phoneBillController.stream;

  getPhoneBillHistory(int page) async {
    getReq("${API_URL}history/phone/bills",
        onDataCallBack: (ResponseOb resp) {
          if (resp.success == true) {
            resp.data = PhoneBillOb.fromJson(resp.data);
          }
          phoneBillController.sink.add(resp);
        }, errorCallBack: (ResponseOb resp) {
          phoneBillController.sink.add(resp);
        });
  }
}
