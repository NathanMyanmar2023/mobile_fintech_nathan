import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/update_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class UpdateCartBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _updateCartController = PublishSubject();

  Stream<ResponseOb> updateCartStream() => _updateCartController.stream;

  updateCart({required Map<String, dynamic> data}) async {
    postReq(UPDATE_SHOPPING_CART, params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = UpdateCartOb.fromJson(resp.data);
      }
      _updateCartController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _updateCartController.sink.add(resp);
    });
  }
}
