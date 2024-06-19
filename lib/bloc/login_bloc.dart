import 'package:flutter/foundation.dart';
import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/helpers/shared_pref.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/login_ob.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends BaseNetwork {
  PublishSubject<ResponseOb> loginController = PublishSubject();

  Stream<ResponseOb> loginStream() => loginController.stream;

  login(Map<String, dynamic> map) async {
    print("dd r $LOGIN_URL");
    postReq(LOGIN_URL, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = LoginOb.fromJson(resp.data);
        if (kIsWeb) {
          print("redata ${resp.data}");
          print("resp.data ${resp.data.data}");
          if (resp.data.data.token != null) {
            print("web toooken ${resp.data.data.token}");
            SharedPref.setData(
              key: SharedPref.token,
              value: "Bearer " + resp.data.data.token,
            );
            print("well save");
          }
        } else {
          if (resp.data.data.token != null) {
            print("toooken");
            SharedPref.setData(
              key: SharedPref.token,
              value: "Bearer " + resp.data.data.token,
            );
          }
        }
      }
      loginController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      print("error $resp");
      loginController.sink.add(resp);
    });
  }
}
