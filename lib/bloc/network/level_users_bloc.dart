import 'package:nathan_app/helpers/base_network.dart';
import 'package:nathan_app/helpers/response_ob.dart';
import 'package:nathan_app/objects/network/level_users_ob.dart';
import 'package:nathan_app/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class LevelUsersBloc extends BaseNetwork {
  PublishSubject<ResponseOb> levelUsersController = PublishSubject();
  Stream<ResponseOb> levelUsersStream() => levelUsersController.stream;

  getLevelUsers(int page, String level) async {
    getReq("${API_URL}level/$level/users?page=$page", onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        resp.data = LevelUsersOb.fromJson(resp.data);
      }
      levelUsersController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      levelUsersController.sink.add(resp);
    });
  }
}
