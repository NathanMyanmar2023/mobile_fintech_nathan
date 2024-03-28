import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/check_username_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class CheckUsernameBloc extends BaseNetwork {
  PublishSubject<ResponseOb> checkUsernameController = PublishSubject();
  Stream<ResponseOb> checkUsernameStream() => checkUsernameController.stream;

  checkUsername(Map<String, dynamic> map) async {
    postReq(CHECK_USERNAME, params: map, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = CheckUsernameOb.fromJson(resp.data);
      }
      checkUsernameController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      checkUsernameController.sink.add(resp);
    });
  }
}
