import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ChangePasswordBloc extends BaseNetwork {
  PublishSubject<ResponseOb> changePasswordController = PublishSubject();
  Stream<ResponseOb> changePasswordStream() => changePasswordController.stream;

  changePassword(Map<String, dynamic> map) async {
    postReq(
      CHANGE_PASSWORD,
      params: map,
      onDataCallBack: (ResponseOb resp) {
        changePasswordController.sink.add(resp);
      },
      errorCallBack: (ResponseOb resp) {
        changePasswordController.sink.add(resp);
      },
    );
  }
}
