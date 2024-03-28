import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/history/deposit_history_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/history/shopping_network_ob.dart';
import 'package:rxdart/subjects.dart';

class ShoppingNetworkHistoryBloc extends BaseNetwork {
  PublishSubject<ResponseOb> shoppingNetworkHistoryController = PublishSubject();
  Stream<ResponseOb> shoppingNetworkHistoryStream() => shoppingNetworkHistoryController.stream;

  getShoppingNetworkHistory(int page) async {
    getReq("${API_URL}history/shopping/networks?page=$page", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = ShoppingNetworkOb.fromJson(resp.data);
      }
      shoppingNetworkHistoryController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      shoppingNetworkHistoryController.sink.add(resp);
    });
  }
}
