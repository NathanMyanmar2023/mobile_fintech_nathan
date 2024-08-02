import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/check_username_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CheckUsernameBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkUsernameController = PublishSubject();
  Stream<ResponseOb> checkUsernameStream() => checkUsernameController.stream;

  checkUsername(Map<String, dynamic> map) async {
    postReq(CHECK_USERNAME, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CheckUsernameOb.fromJson(resp.data);
        } else {
          resp.data = CheckUsernameOb.fromJson(resp.data);
        }
      }
      checkUsernameController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkUsernameController.sink.add(resp);
    });
  }
}
