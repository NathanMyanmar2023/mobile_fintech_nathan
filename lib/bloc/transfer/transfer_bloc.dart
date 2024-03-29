import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/transfer/transfer_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class TransferBloc extends BaseNetwork {
  PublishSubject<ResponseOb> transferController = PublishSubject();
  Stream<ResponseOb> transferStream() => transferController.stream;

  transfer(Map<String, dynamic> map) async {
    postReq(TRANSFER, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = TransferOb.fromJson(resp.data);
      }
      transferController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      transferController.sink.add(resp);
    });
  }
}
