import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/verify_email_ob.dart';
import 'package:rxdart/subjects.dart';

class VerifyEmailBloc extends BaseNetwork {
  PublishSubject<ResponseOb> verifyEmailController = PublishSubject();

  Stream<ResponseOb> verifyEmailStream() => verifyEmailController.stream;

  verifyEmail(Map<String, dynamic> map) async {
    postReq(VERIFY_EMAIL, params: map, onDataCallBack: (ResponseOb resp) {
      print(">>>>>>>>>>>> $resp");
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = VerifyEmailOb.fromJson(resp.data);
        } else {
          resp.data = VerifyEmailOb.fromJson(resp.data);
        }
      }
      verifyEmailController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      verifyEmailController.sink.add(resp);
    });
  }
}
