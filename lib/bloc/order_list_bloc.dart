import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/order_list_ob.dart';
import 'package:rxdart/subjects.dart';

class OrderListBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _orderListController = PublishSubject();

  Stream<ResponseOb> orderListStream() => _orderListController.stream;

  orderList() async {
    getReq(ORDER, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = OrderListOb.fromJson(resp.data);
      }
      _orderListController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _orderListController.sink.add(resp);
    });
  }
}
