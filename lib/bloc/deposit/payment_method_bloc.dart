import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/deposit/payment_method_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class PaymentMethodBloc extends BaseNetwork {
  PublishSubject<ResponseOb> paymentMethodController = PublishSubject();
  Stream<ResponseOb> paymentMethodStream() => paymentMethodController.stream;

  getPaymentMethods(int currencyId) async {
    getReq("${API_URL}currency/$currencyId/payment",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = PaymentMethodOb.fromJson(resp.data);
        } else {
          resp.data = PaymentMethodOb.fromJson(resp.data);
        }
      }
      paymentMethodController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      paymentMethodController.sink.add(resp);
    });
  }
}
