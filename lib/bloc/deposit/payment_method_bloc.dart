import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/deposit/payment_method_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class PaymentMethodBloc extends BaseNetwork {
  PublishSubject<ResponseOb> paymentMethodController = PublishSubject();
  Stream<ResponseOb> paymentMethodStream() => paymentMethodController.stream;

  getPaymentMethods(int currencyId) async {
    getReq("${API_URL}currency/$currencyId/payment",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = PaymentMethodOb.fromJson(resp.data);
      }
      paymentMethodController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      paymentMethodController.sink.add(resp);
    });
  }
}
