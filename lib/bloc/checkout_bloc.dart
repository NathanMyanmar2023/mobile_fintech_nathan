import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/add_to_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class CheckoutBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _checkoutController = PublishSubject();

  Stream<ResponseOb> checkoutStream() => _checkoutController.stream;

  makeCheckout({required Map<String, dynamic> data}) async {
    postReq(CHECKOUT, params: data,
        onDataCallBack: (ResponseOb resp) {
          if (resp.success == true) {
            resp.data = AddToCartOb.fromJson(resp.data);
          }
          _checkoutController.sink.add(resp);
        }, errorCallBack: (ResponseOb resp) {
          _checkoutController.sink.add(resp);
        });
  }
}
