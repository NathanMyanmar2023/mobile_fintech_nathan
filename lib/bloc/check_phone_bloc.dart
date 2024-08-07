import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/check_phone_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CheckPhoneBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkPhoneController = PublishSubject();
  Stream<ResponseOb> checkPhoneStream() => checkPhoneController.stream;

  checkPhone(Map<String, dynamic> map) async {
    postReq(CHECK_PHONE, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CheckPhoneOb.fromJson(resp.data);
        } else {
          resp.data = CheckPhoneOb.fromJson(resp.data);
        }
      }
      checkPhoneController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkPhoneController.sink.add(resp);
    });
  }
}
