import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/transfer/transfer_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class TransferBloc extends BaseNetwork {
  PublishSubject<ResponseOb> transferController = PublishSubject();
  Stream<ResponseOb> transferStream() => transferController.stream;

  transfer(Map<String, dynamic> map) async {
    postReq(TRANSFER, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = TransferOb.fromJson(resp.data);
        } else {
          resp.data = TransferOb.fromJson(resp.data);
        }
      }
      transferController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      transferController.sink.add(resp);
    });
  }
}
