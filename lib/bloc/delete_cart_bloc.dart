import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/delete_shopping_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class DeleteCartBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _deleteCartController = PublishSubject();

  Stream<ResponseOb> deleteCartStream() => _deleteCartController.stream;

  deleteShoppingCart({required int id}) async {
    delReq("${API_URL}cart/delete/$id", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = DeleteShoppingCartOb.fromJson(resp.data);
      }
      _deleteCartController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _deleteCartController.sink.add(resp);
    });
  }
}
