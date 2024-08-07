import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/withdraw/withdraw_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class WithdrawBloc extends BaseNetwork {
  PublishSubject<ResponseOb> withdrawController = PublishSubject();
  Stream<ResponseOb> withdrawStream() => withdrawController.stream;

  withdraw(Map<String, dynamic> map) async {
    postReq(WITHDRAW, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = WithdrawOb.fromJson(resp.data);
        } else {
          resp.data = WithdrawOb.fromJson(resp.data);
        }
      }
      withdrawController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      withdrawController.sink.add(resp);
    });
  }
}
