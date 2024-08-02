import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/user_info_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class UserInfoBloc extends BaseNetwork {
  PublishSubject<ResponseOb> userInfoController = PublishSubject();
  Stream<ResponseOb> userInfoStream() => userInfoController.stream;

  getUserInfos() {
    getReq(USER_INFO, onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = UserInfoOb.fromJson(resp.data);
      }
      userInfoController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      userInfoController.sink.add(resp);
    });
  }
}
