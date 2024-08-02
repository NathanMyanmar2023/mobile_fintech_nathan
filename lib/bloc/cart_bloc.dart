import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/cart_ob.dart';
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
