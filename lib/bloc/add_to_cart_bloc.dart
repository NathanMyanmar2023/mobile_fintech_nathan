import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/add_to_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class AddToCartBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _addToCartController = PublishSubject();

  Stream<ResponseOb> addToCartStream() => _addToCartController.stream;

  addToCartList({required Map<String, dynamic> data}) async {
    postReq(ADD_TO_SHOPPING_CART, params: data,
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = AddToCartOb.fromJson(resp.data);
        } else {
          resp.data = AddToCartOb.fromJson(resp.data);
        }
      }
      _addToCartController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _addToCartController.sink.add(resp);
    });
  }
}
