import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/deposit/payment_account_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class PaymentAccountBloc extends BaseNetwork {
  PublishSubject<ResponseOb> paymentAccountController = PublishSubject();
  Stream<ResponseOb> paymentAccountStream() => paymentAccountController.stream;

  getPaymentAccounts(int paymentMethodId) async {
    getReq("${API_URL}payment/$paymentMethodId/account", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = PaymentAccountOb.fromJson(resp.data);
      }
      paymentAccountController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      paymentAccountController.sink.add(resp);
    });
  }
}
