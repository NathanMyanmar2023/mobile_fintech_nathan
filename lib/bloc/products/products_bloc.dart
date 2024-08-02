import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/products/photos_ob.dart';
import 'package:fnge/objects/products/products_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ProductsBloc extends BaseNetwork {
  PublishSubject<ResponseOb> productsController = PublishSubject();
  Stream<ResponseOb> productsStream() => productsController.stream;

  getProducts(int page) async {
    getReq("$GET_PRODUCTS?page=$page", onDataCallBack: (ResponseOb resp) {
      print(resp.data);
      if (resp.success == true) {
        resp.data = ProductsOb.fromJson(resp.data);
      }
      productsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      productsController.sink.add(resp);
    });
  }

  getPhotos(int productId) async {
    getReq("$GET_PHOTOS/$productId/photos", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = PhotosOb.fromJson(resp.data);
      }
      productsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      productsController.sink.add(resp);
    });
  }
}
