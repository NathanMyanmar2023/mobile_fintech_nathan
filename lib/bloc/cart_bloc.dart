import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/cart_ob.dart';
import 'package:rxdart/subjects.dart';

class CartBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _cartController = PublishSubject();

  Stream<ResponseOb> cartStream() => _cartController.stream;

  cartList() async {
    getReq(CART, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CartOb.fromJson(resp.data);
      }
      _cartController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _cartController.sink.add(resp);
    });
  }
}
