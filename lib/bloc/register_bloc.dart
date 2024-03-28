import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/helpers/shared_pref.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:nathan_app/objects/register_ob.dart';
import 'package:rxdart/subjects.dart';

class RegisterBloc extends BaseNetwork {
  PublishSubject<ResponseOb> registerController = PublishSubject();

  Stream<ResponseOb> registerStream() => registerController.stream;

  register(Map<String, dynamic> map) async {
    postReq(REGISTER_URL, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = RegisterOb.fromJson(resp.data);
        SharedPref.setData(
          key: SharedPref.token,
          value: "Bearer " + resp.data.data.token,
        );
      }
      registerController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      registerController.sink.add(resp);
    });
  }
}
