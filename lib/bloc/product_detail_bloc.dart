import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/product_detail_ob.dart';
import 'package:rxdart/subjects.dart';

class ProductDetailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> productDetailController = PublishSubject();

  Stream<ResponseOb> productDetailStream() => productDetailController.stream;

  getProductDetail({required int? productId}) async {
    print("ddo ${productId}");
    getReq("$Product_detail$productId", onDataCallBack: (ResponseOb resp) {
      print("call");
      resp.data = ProductDetailOb.fromJson(resp.data);
      print("33 ${resp.data}");
      productDetailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      productDetailController.sink.add(resp);
    });
  }
}
