import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ChangeWalletTypeBloc extends BaseNetwork {
  PublishSubject<ResponseOb> changeWalletTypeController = PublishSubject();
  Stream<ResponseOb> changeWalletTypeStream() =>
      changeWalletTypeController.stream;

  changeWalletType(Map<String, dynamic> map) async {
    postReq(
      CHANGE_WALLET_TYPE,
      params: map,
      onDataCallBack: (ResponseOb resp) {
        changeWalletTypeController.sink.add(resp);
      },
      errorCallBack: (ResponseOb resp) {
        changeWalletTypeController.sink.add(resp);
      },
    );
  }
}
