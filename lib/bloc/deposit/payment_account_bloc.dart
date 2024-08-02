import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/deposit/payment_account_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class PaymentAccountBloc extends BaseNetwork {
  PublishSubject<ResponseOb> paymentAccountController = PublishSubject();
  Stream<ResponseOb> paymentAccountStream() => paymentAccountController.stream;

  getPaymentAccounts(int paymentMethodId) async {
    getReq("${API_URL}payment/$paymentMethodId/account",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = PaymentAccountOb.fromJson(resp.data);
        } else {
          resp.data = PaymentAccountOb.fromJson(resp.data);
        }
      }
      paymentAccountController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      paymentAccountController.sink.add(resp);
    });
  }
}
