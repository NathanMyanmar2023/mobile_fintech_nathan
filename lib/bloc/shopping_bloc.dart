import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/shopping_ob.dart';
import 'package:rxdart/subjects.dart';

class ShoppingBloc extends BaseNetwork {
  PublishSubject<ResponseOb> shoppingController = PublishSubject();

  Stream<ResponseOb> shoppingStream() => shoppingController.stream;

  getShoppingProduct({required int? brandId, required int? page}) async {
    getReq("$SHOPPING_BRAND$brandId?page=$page", onDataCallBack: (ResponseOb resp) {
      resp.data = ShoppingOb.fromJson(resp.data);
      shoppingController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoppingController.sink.add(resp);
    });
  }

  getCategoryProducts({required int? categoryId, required int? page}) async {
    getReq("$GET_CATEGORY_PRODUCTS$categoryId?page=$page", onDataCallBack: (ResponseOb resp) {
      resp.data = ShoppingOb.fromJson(resp.data);
      shoppingController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoppingController.sink.add(resp);
    });
  }
}
