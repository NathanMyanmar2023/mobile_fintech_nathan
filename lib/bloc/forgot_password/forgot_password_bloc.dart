import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/helpers/shared_pref.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/login_ob.dart';
import 'package:rxdart/subjects.dart';

import '../../objects/forgot_pass/forgot_pass_ob.dart';
import '../../objects/otp/verify_otp_ob.dart';

class ForgotPasswordBloc extends BaseNetwork {
  PublishSubject<ResponseOb> forgotPasswordController = PublishSubject();

  Stream<ResponseOb> forgotPassStream() => forgotPasswordController.stream;

  forgotPass(Map<String, dynamic> map) async {
    print("dd r$map");
    postReq(FORGOT_PASS_URL, params: map, onDataCallBack: (ResponseOb resp) {
      print("no error $resp");
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = ForgotPassOb.fromJson(resp.data);
        } else {
          resp.data = ForgotPassOb.fromJson(resp.data);
        }
      }
      forgotPasswordController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      print("error $resp");
      forgotPasswordController.sink.add(resp);
    });
  }
}
