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
    print("dd r$LOGIN_URL");
    postReq(LOGIN_URL, params: map, onDataCallBack: (ResponseOb resp) {
      print("no error $resp");
      if (resp.success == true) {
        resp.data = LoginOb.fromJson(resp.data);
        if (resp.data.data.token != null) {
          SharedPref.setData(
            key: SharedPref.token,
            value: "Bearer " + resp.data.data.token,
          );
        }
      }
      loginController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      print("error $resp");
      loginController.sink.add(resp);
    });
  }
}
