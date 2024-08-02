import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/check_email_ob.dart';
import 'package:rxdart/subjects.dart';

class CheckEmailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkEmailController = PublishSubject();

  Stream<ResponseOb> checkEmailStream() => checkEmailController.stream;

  checkEmail(Map<String, dynamic> map) async {
    postReq(CHECK_EMAIL, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CheckEmailOb.fromJson(resp.data);
        } else {
          resp.data = CheckEmailOb.fromJson(resp.data);
        }
      }
      checkEmailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkEmailController.sink.add(resp);
    });
  }
}
