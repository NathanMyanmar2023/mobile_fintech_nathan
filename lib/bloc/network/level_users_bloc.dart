import 'package:flutter/foundation.dart';
import 'package:fnge/helpers/base_network.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/objects/network/level_users_ob.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class LevelUsersBloc extends BaseNetwork {
  PublishSubject<ResponseOb> levelUsersController = PublishSubject();
  Stream<ResponseOb> levelUsersStream() => levelUsersController.stream;

  getLevelUsers(int page, String level) async {
    getReq("${API_URL}level/$level/users?page=$page",
        onDataCallBack: (ResponseOb resp) {
      if (resp.success == true) {
        if (kIsWeb) {
          resp.data = LevelUsersOb.fromJson(resp.data);
        } else {
          resp.data = LevelUsersOb.fromJson(resp.data);
        }
      }
      levelUsersController.sink.add(resp);
    }, errorCallBack: (ResponseOb resp) {
      levelUsersController.sink.add(resp);
    });
  }
}
