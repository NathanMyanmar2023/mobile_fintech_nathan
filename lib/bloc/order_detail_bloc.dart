import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/order_detail_ob.dart';
import 'package:rxdart/subjects.dart';

import '../helpers/response_data_ob.dart';

class OrderDetailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> orderDetailController = PublishSubject();

  Stream<ResponseOb> orderDetailStream() => orderDetailController.stream;

  getOrderDetail({required String? orderId}) async {
    print("ododfe $ORDER_detail$orderId");
    getReq("$ORDER_detail$orderId", onDataCallBack: (ResponseOb resp) {
      resp.data = OrderDetailOb.fromJson(resp.data);
      print("odoerer ${resp.data}");
      orderDetailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      orderDetailController.sink.add(resp);
    });
  }
}
