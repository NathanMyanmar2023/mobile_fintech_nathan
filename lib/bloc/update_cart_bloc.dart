import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/update_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class UpdateCartBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _updateCartController = PublishSubject();

  Stream<ResponseOb> updateCartStream() => _updateCartController.stream;

  updateCart({required Map<String, dynamic> data}) async {
    postReq(UPDATE_SHOPPING_CART, params: data,
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = UpdateCartOb.fromJson(resp.data);
        } else {
          resp.data = UpdateCartOb.fromJson(resp.data);
        }
      }
      _updateCartController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _updateCartController.sink.add(resp);
    });
  }
}
