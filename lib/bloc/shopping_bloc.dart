import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/shopping_ob.dart';
import 'package:rxdart/subjects.dart';

class ShoppingBloc extends BaseNetwork {
  PublishSubject<ResponseOb> shoppingController = PublishSubject();

  Stream<ResponseOb> shoppingStream() => shoppingController.stream;

  getShoppingProduct({required int? brandId}) async {
    getReq("$SHOPPING_BRAND$brandId", onDataCallBack: (ResponseOb resp) {
      resp.data = ShoppingOb.fromJson(resp.data);
      shoppingController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoppingController.sink.add(resp);
    });
  }

  getProducts(int page) async {
    getReq("$GET_PRODUCTS?page=$page", onDataCallBack: (ResponseOb resp) {
      resp.data = ShoppingOb.fromJson(resp.data);
      shoppingController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoppingController.sink.add(resp);
    });
  }
}
