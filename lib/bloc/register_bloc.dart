import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/helpers/shared_pref.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:fnge/objects/register_ob.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc extends BaseNetwork {
  PublishSubject<ResponseOb> registerController = PublishSubject();

  Stream<ResponseOb> registerStream() => registerController.stream;

  register(Map<String, dynamic> map) async {
    postReq(REGISTER_URL, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = RegisterOb.fromJson(resp.data);
          SharedPref.setData(
            key: SharedPref.token,
            value: "Bearer " + resp.data.data.token,
          );
        } else {
          resp.data = RegisterOb.fromJson(resp.data);
          SharedPref.setData(
            key: SharedPref.token,
            value: "Bearer " + resp.data.data.token,
          );
        }
      }
      registerController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      registerController.sink.add(resp);
    });
  }
}
