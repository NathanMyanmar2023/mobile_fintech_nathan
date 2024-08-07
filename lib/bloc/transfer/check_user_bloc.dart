import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/transfer/check_user_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CheckUserBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkUserController = PublishSubject();
  Stream<ResponseOb> checkUserStream() => checkUserController.stream;

  check_user(Map<String, dynamic> map) async {
    postReq(CHECK_USER, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = CheckUserOb.fromJson(resp.data);
        } else {
          resp.data = CheckUserOb.fromJson(resp.data);
        }
      }
      checkUserController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkUserController.sink.add(resp);
    });
  }
}
