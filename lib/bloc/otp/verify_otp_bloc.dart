import 'package:flutter/foundation.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/helpers/shared_pref.dart';
import 'package:nathan_app/objects/otp/verify_otp_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class VerifyOtpBloc extends BaseNetwork {
  PublishSubject<ResponseOb> verifyOtpController = PublishSubject();
  Stream<ResponseOb> verifyOtpStream() => verifyOtpController.stream;

  verifyOtp(Map<String, dynamic> map) async {
    postReq(VERIFY_OTP, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if(kIsWeb) {
          resp.data = VerifyOtpOb.fromJson(resp.data);
        } else {
          resp.data = VerifyOtpOb.fromJson(resp.data);
        }
        SharedPref.setData(
          key: SharedPref.token,
          value: "Bearer " + resp.data.data.token,
        );
      }
      verifyOtpController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      verifyOtpController.sink.add(resp);
    });
  }
}
