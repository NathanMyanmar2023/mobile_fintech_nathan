import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/add_to_cart_ob.dart';
import 'package:rxdart/subjects.dart';

class TopUpBloc extends BaseNetwork {
  final PublishSubject<ResponseOb> _topUpController = PublishSubject();

  Stream<ResponseOb> topUpStream() => _topUpController.stream;

  addPhoneBill({required Map<String, dynamic> data}) async {
    postReq(PHONE_BILL_URL, params: data, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = AddToCartOb.fromJson(resp.data);
        } else {
          resp.data = AddToCartOb.fromJson(resp.data);
        }
      }
      _topUpController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      _topUpController.sink.add(resp);
    });
  }
}
