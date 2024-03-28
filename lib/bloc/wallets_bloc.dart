import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/wallets_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class WalletsBloc extends BaseNetwork {
  PublishSubject<ResponseOb> walletsController = PublishSubject();
  Stream<ResponseOb> walletsStream() => walletsController.stream;

  getWallets() {
    getReq(WALLETS, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = WalletsOb.fromJson(resp.data);
      }
      walletsController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      walletsController.sink.add(resp);
    });
  }
}
