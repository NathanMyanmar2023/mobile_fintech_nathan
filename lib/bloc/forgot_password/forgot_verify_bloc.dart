
import 'package:flutter/foundation.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class ForgotVerifyBloc extends BaseNetwork {

  PublishSubject<ResponseOb> verifyOtpController = PublishSubject();
  Stream<ResponseOb> verifyOtpStream() => verifyOtpController.stream;

  verifyOtp(Map<String, dynamic> map) async {
    postReq(FORGOT_PASS_URL, params: map, onDataCallBack: (ResponseOb resp) {
      print('ree $resp');
      if(kIsWeb) {
      resp.data = ResponseOb(success: true);
      } else {
      resp.data = ResponseOb(success: true);
      }

      print("dd ${resp.data}");//Instance of 'ResponseOb'
      print("ddo ${resp.data.message}");
      verifyOtpController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      verifyOtpController.sink.add(resp);
    });
  }
}
