import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/check_email_ob.dart';
import 'package:rxdart/subjects.dart';

class CheckEmailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkEmailController = PublishSubject();

  Stream<ResponseOb> checkEmailStream() => checkEmailController.stream;

  checkEmail(Map<String, dynamic> map) async {
    postReq(CHECK_EMAIL, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CheckEmailOb.fromJson(resp.data);
      }
      checkEmailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkEmailController.sink.add(resp);
    });
  }
}
