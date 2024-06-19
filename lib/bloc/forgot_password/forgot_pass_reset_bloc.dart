import 'package:flutter/foundation.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/forgot_pass/Forgot_pass_reset_ob.dart';

class ForgotPassResetBloc extends BaseNetwork {
  PublishSubject<ResponseOb> changePasswordController = PublishSubject();
  Stream<ResponseOb> changePasswordStream() => changePasswordController.stream;

  changePassword(Map<String, dynamic> map) async {
    postReq(
      FORGOT_PASS_URL,
      params: map,
      onDataCallBack: (ResponseOb resp) {
        print("resetPa ${resp.data}");
        if (resp.success == true) {
          if(kIsWeb) {
          resp.data = ForgotPassResetOb.fromJson(resp.data);
          } else {
          resp.data = ForgotPassResetOb.fromJson(resp.data);
          }
        }
        changePasswordController.sink.add(resp);
      },
      errorCallBack: (ResponseOb resp) {
        changePasswordController.sink.add(resp);
      },
    );
  }
}